import '../money.dart';
import 'journal_line.dart';

/// Represents one complete accounting transaction.
class JournalEntry {
  JournalEntry({
    required this.id,
    required this.description,
    required this.transactionDate,
    required List<JournalLine> lines,
  }) : lines = List.unmodifiable(lines) {
    if (id.trim().isEmpty) {
      throw ArgumentError('Journal entry ID cannot be empty.');
    }

    if (description.trim().isEmpty) {
      throw ArgumentError('Journal description cannot be empty.');
    }

    if (this.lines.length < 2) {
      throw ArgumentError('A journal entry must contain at least two lines.');
    }

    final currency = this.lines.first.amount.currencyCode;

    if (this.lines.any((line) => line.amount.currencyCode != currency)) {
      throw ArgumentError('All journal lines must use the same currency.');
    }
  }

  final String id;
  final String description;
  final DateTime transactionDate;
  final List<JournalLine> lines;

  /// Calculates the total debit amount.
  Money get totalDebits {
    var total = Money(
      minorUnits: 0,
      currencyCode: lines.first.amount.currencyCode,
    );

    for (final line in lines) {
      if (line.side == JournalSide.debit) {
        total = total + line.amount;
      }
    }

    return total;
  }

  /// Calculates the total credit amount.
  Money get totalCredits {
    var total = Money(
      minorUnits: 0,
      currencyCode: lines.first.amount.currencyCode,
    );

    for (final line in lines) {
      if (line.side == JournalSide.credit) {
        total = total + line.amount;
      }
    }

    return total;
  }

  /// True only when total debits equal total credits.
  bool get isBalanced => totalDebits == totalCredits;
}
