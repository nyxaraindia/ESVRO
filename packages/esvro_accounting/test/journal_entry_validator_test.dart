import 'package:flutter_test/flutter_test.dart';
import 'package:esvro_accounting/esvro_accounting.dart';

void main() {
  const validator = JournalEntryValidator();

  group('JournalEntryValidator', () {
    test('accepts a balanced journal entry', () {
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

      final result = validator.validate(entry);

      expect(result.isValid, isTrue);
      expect(result.errors, isEmpty);
    });

    test('rejects an unbalanced journal entry', () {
      final entry = JournalEntry(
        id: 'JE002',
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

      final result = validator.validate(entry);

      expect(result.isValid, isFalse);
      expect(result.errors, isNotEmpty);
    });

    test('does not allow modification of validation errors', () {
      final entry = JournalEntry(
        id: 'JE003',
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

      final result = validator.validate(entry);

      expect(() => result.errors.add('Fake error'), throwsUnsupportedError);
    });
  });
}
