import 'package:flutter_test/flutter_test.dart';
import 'package:esvro_accounting/esvro_accounting.dart';

void main() {
  final activeAccounts = [
    Account(code: '1500', name: 'Equipment', type: AccountType.assets),
    Account(code: '1000', name: 'Cash', type: AccountType.assets),
  ];

  JournalEntry createEntry({String id = 'JE001', String accountCode = '1500'}) {
    return JournalEntry(
      id: id,
      description: 'Equipment purchase',
      transactionDate: DateTime(2026, 11, 8),
      lines: [
        JournalLine(
          accountCode: accountCode,
          side: JournalSide.debit,
          amount: const Money(minorUnits: 1000000),
        ),
        JournalLine(
          accountCode: '1000',
          side: JournalSide.credit,
          amount: const Money(minorUnits: 1000000),
        ),
      ],
    );
  }

  group('JournalPostingService', () {
    test('successfully posts a valid journal entry', () {
      final service = JournalPostingService();

      final result = service.post(
        createEntry(),
        accounts: activeAccounts,
        actorId: 'accountant_01',
      );

      expect(result.isPosted, isTrue);
      expect(result.errors, isEmpty);
      expect(result.postedEntry, isNotNull);
      expect(service.postedEntries, hasLength(1));
    });

    test('records the posting timestamp in UTC', () {
      final service = JournalPostingService(
        clock: () => DateTime.utc(2026, 11, 8, 12, 30),
      );

      final result = service.post(
        createEntry(),
        accounts: activeAccounts,
        actorId: 'accountant_01',
      );

      expect(result.isPosted, isTrue);
      expect(result.postedEntry!.postedAt.isUtc, isTrue);
      expect(result.postedEntry!.postedAt, DateTime.utc(2026, 11, 8, 12, 30));
    });

    test('prevents the same journal entry from being posted twice', () {
      final service = JournalPostingService();

      final firstResult = service.post(
        createEntry(),
        accounts: activeAccounts,
        actorId: 'accountant_01',
      );

      final secondResult = service.post(
        createEntry(),
        accounts: activeAccounts,
        actorId: 'accountant_01',
      );

      expect(firstResult.isPosted, isTrue);
      expect(secondResult.isPosted, isFalse);
      expect(secondResult.errors, isNotEmpty);
      expect(service.postedEntries, hasLength(1));
      expect(service.auditEvents, hasLength(1));
    });

    test('rejects an entry referencing a missing account', () {
      final service = JournalPostingService();

      final result = service.post(
        createEntry(accountCode: '9999'),
        accounts: activeAccounts,
        actorId: 'accountant_01',
      );

      expect(result.isPosted, isFalse);
      expect(result.postedEntry, isNull);
      expect(service.postedEntries, isEmpty);
      expect(service.auditEvents, isEmpty);
    });

    test('rejects an entry using an inactive account', () {
      final service = JournalPostingService();

      final accounts = [
        Account(
          code: '1500',
          name: 'Equipment',
          type: AccountType.assets,
          isActive: false,
        ),
        activeAccounts[1],
      ];

      final result = service.post(
        createEntry(),
        accounts: accounts,
        actorId: 'accountant_01',
      );

      expect(result.isPosted, isFalse);
      expect(result.errors.any((error) => error.contains('inactive')), isTrue);
      expect(service.postedEntries, isEmpty);
      expect(service.auditEvents, isEmpty);
    });

    test('does not allow modification of posted-entry history', () {
      final service = JournalPostingService();

      service.post(
        createEntry(),
        accounts: activeAccounts,
        actorId: 'accountant_01',
      );

      expect(() => service.postedEntries.clear(), throwsUnsupportedError);

      expect(service.postedEntries, hasLength(1));
    });

    test('records the correct actor in the audit event', () {
      final service = JournalPostingService();

      final result = service.post(
        createEntry(),
        accounts: activeAccounts,
        actorId: 'accountant_01',
      );

      expect(result.isPosted, isTrue);
      expect(result.auditEvent, isNotNull);
      expect(result.auditEvent!.actorId, 'accountant_01');
      expect(result.auditEvent!.journalEntryId, 'JE001');
      expect(result.auditEvent!.action, JournalAuditAction.posted);
    });

    test('posting and audit event share the same timestamp', () {
      final service = JournalPostingService(
        clock: () => DateTime.utc(2026, 11, 8, 12, 30),
      );

      final result = service.post(
        createEntry(),
        accounts: activeAccounts,
        actorId: 'accountant_01',
      );

      expect(result.auditEvent!.occurredAt, result.postedEntry!.postedAt);
    });

    test('rejects an empty actor ID', () {
      final service = JournalPostingService();

      final result = service.post(
        createEntry(),
        accounts: activeAccounts,
        actorId: '   ',
      );

      expect(result.isPosted, isFalse);
      expect(result.errors, isNotEmpty);
      expect(service.postedEntries, isEmpty);
      expect(service.auditEvents, isEmpty);
    });

    test('does not allow modification of audit history', () {
      final service = JournalPostingService();

      service.post(
        createEntry(),
        accounts: activeAccounts,
        actorId: 'accountant_01',
      );

      expect(() => service.auditEvents.clear(), throwsUnsupportedError);

      expect(service.auditEvents, hasLength(1));
    });
  });
}
