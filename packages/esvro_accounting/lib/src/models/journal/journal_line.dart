import '../money.dart';

/// Identifies whether a journal line is a debit or credit.
enum JournalSide { debit, credit }

/// Represents one debit or credit line in a journal entry.
class JournalLine {
  JournalLine({
    required this.accountCode,
    required this.side,
    required this.amount,
  }) {
    if (accountCode.trim().isEmpty) {
      throw ArgumentError('Account code cannot be empty.');
    }

    if (amount.minorUnits <= 0) {
      throw ArgumentError('Journal line amount must be greater than zero.');
    }
  }

  final String accountCode;
  final JournalSide side;
  final Money amount;
}
