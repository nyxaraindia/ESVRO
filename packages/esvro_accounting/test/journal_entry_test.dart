import 'package:flutter_test/flutter_test.dart';
import 'package:esvro_accounting/esvro_accounting.dart';

void main() {
  group('JournalLine', () {
    test('rejects an empty account code', () {
      expect(
        () => JournalLine(
          accountCode: '',
          side: JournalSide.debit,
          amount: const Money(minorUnits: 1000),
        ),
        throwsArgumentError,
      );
    });

    test('rejects zero or negative amounts', () {
      expect(
        () => JournalLine(
          accountCode: '1000',
          side: JournalSide.debit,
          amount: const Money(minorUnits: 0),
        ),
        throwsArgumentError,
      );

      expect(
        () => JournalLine(
          accountCode: '1000',
          side: JournalSide.debit,
          amount: const Money(minorUnits: -100),
        ),
        throwsArgumentError,
      );
    });
  });

  group('JournalEntry', () {
    test('calculates totals for a balanced entry', () {
      final entry = JournalEntry(
        id: 'JE001',
        description: 'Equipment purchased with cash',
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

      expect(entry.totalDebits, const Money(minorUnits: 1000000));
      expect(entry.totalCredits, const Money(minorUnits: 1000000));
      expect(entry.isBalanced, isTrue);
    });

    test('detects an unbalanced entry', () {
      final entry = JournalEntry(
        id: 'JE002',
        description: 'Incorrect transaction',
        transactionDate: DateTime(2026, 11, 7),
        lines: [
          JournalLine(
            accountCode: '1000',
            side: JournalSide.debit,
            amount: const Money(minorUnits: 100000),
          ),
          JournalLine(
            accountCode: '4000',
            side: JournalSide.credit,
            amount: const Money(minorUnits: 80000),
          ),
        ],
      );

      expect(entry.isBalanced, isFalse);
    });

    test('rejects an entry with fewer than two lines', () {
      expect(
        () => JournalEntry(
          id: 'JE003',
          description: 'Incomplete entry',
          transactionDate: DateTime(2026, 11, 7),
          lines: [
            JournalLine(
              accountCode: '1000',
              side: JournalSide.debit,
              amount: const Money(minorUnits: 1000),
            ),
          ],
        ),
        throwsArgumentError,
      );
    });

    test('rejects mixed currencies', () {
      expect(
        () => JournalEntry(
          id: 'JE004',
          description: 'Mixed currency entry',
          transactionDate: DateTime(2026, 11, 7),
          lines: [
            JournalLine(
              accountCode: '1000',
              side: JournalSide.debit,
              amount: const Money(minorUnits: 1000, currencyCode: 'INR'),
            ),
            JournalLine(
              accountCode: '4000',
              side: JournalSide.credit,
              amount: const Money(minorUnits: 1000, currencyCode: 'USD'),
            ),
          ],
        ),
        throwsArgumentError,
      );
    });

    test('does not allow modification of journal lines', () {
      final entry = JournalEntry(
        id: 'JE005',
        description: 'Immutable lines test',
        transactionDate: DateTime(2026, 11, 7),
        lines: [
          JournalLine(
            accountCode: '1000',
            side: JournalSide.debit,
            amount: const Money(minorUnits: 1000),
          ),
          JournalLine(
            accountCode: '4000',
            side: JournalSide.credit,
            amount: const Money(minorUnits: 1000),
          ),
        ],
      );

      expect(
        () => entry.lines.add(
          JournalLine(
            accountCode: '5000',
            side: JournalSide.debit,
            amount: const Money(minorUnits: 500),
          ),
        ),
        throwsUnsupportedError,
      );
    });
  });
}
