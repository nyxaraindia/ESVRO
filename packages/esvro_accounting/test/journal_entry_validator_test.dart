import 'package:flutter_test/flutter_test.dart';
import 'package:esvro_accounting/esvro_accounting.dart';

void main() {
  const validator = JournalEntryValidator();

  final activeAccounts = [
    Account(code: '1500', name: 'Equipment', type: AccountType.assets),
    Account(code: '1000', name: 'Cash', type: AccountType.assets),
  ];

  group('JournalEntryValidator', () {
    test('accepts a balanced entry with existing active accounts', () {
      final entry = JournalEntry(
        id: 'JE001',
        description: 'Equipment purchase',
        transactionDate: DateTime(2026, 11, 7),
        lines: [
          JournalLine(
            accountCode: '1500',
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

      final result = validator.validate(entry, accounts: activeAccounts);

      expect(result.isValid, isTrue);
      expect(result.errors, isEmpty);
    });

    test('rejects an entry referencing a missing account', () {
      final entry = JournalEntry(
        id: 'JE002',
        description: 'Unknown account transaction',
        transactionDate: DateTime(2026, 11, 7),
        lines: [
          JournalLine(
            accountCode: '9999',
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

      final result = validator.validate(entry, accounts: activeAccounts);

      expect(result.isValid, isFalse);
      expect(result.errors.any((error) => error.contains('9999')), isTrue);
    });

    test('rejects an entry using an inactive account', () {
      final accounts = [
        Account(
          code: '1500',
          name: 'Equipment',
          type: AccountType.assets,
          isActive: false,
        ),
        activeAccounts[1],
      ];

      final entry = JournalEntry(
        id: 'JE003',
        description: 'Inactive account transaction',
        transactionDate: DateTime(2026, 11, 7),
        lines: [
          JournalLine(
            accountCode: '1500',
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

      final result = validator.validate(entry, accounts: accounts);

      expect(result.isValid, isFalse);
      expect(result.errors.any((error) => error.contains('inactive')), isTrue);
    });

    test('rejects an unbalanced journal entry', () {
      final entry = JournalEntry(
        id: 'JE004',
        description: 'Incorrect purchase',
        transactionDate: DateTime(2026, 11, 7),
        lines: [
          JournalLine(
            accountCode: '1500',
            side: JournalSide.debit,
            amount: const Money(minorUnits: 1000000),
          ),
          JournalLine(
            accountCode: '1000',
            side: JournalSide.credit,
            amount: const Money(minorUnits: 900000),
          ),
        ],
      );

      final result = validator.validate(entry, accounts: activeAccounts);

      expect(result.isValid, isFalse);
      expect(
        result.errors.any((error) => error.contains('not balanced')),
        isTrue,
      );
    });

    test('does not allow modification of validation errors', () {
      final entry = JournalEntry(
        id: 'JE005',
        description: 'Unbalanced transaction',
        transactionDate: DateTime(2026, 11, 7),
        lines: [
          JournalLine(
            accountCode: '1500',
            side: JournalSide.debit,
            amount: const Money(minorUnits: 1000),
          ),
          JournalLine(
            accountCode: '1000',
            side: JournalSide.credit,
            amount: const Money(minorUnits: 500),
          ),
        ],
      );

      final result = validator.validate(entry, accounts: activeAccounts);

      expect(() => result.errors.add('Fake error'), throwsUnsupportedError);
    });
  });
}
