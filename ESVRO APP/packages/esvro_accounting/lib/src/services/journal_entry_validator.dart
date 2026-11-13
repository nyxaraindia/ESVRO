import '../models/account.dart';
import '../models/journal/journal_entry.dart';

/// Contains the result of validating a journal entry.
class JournalValidationResult {
  const JournalValidationResult({required this.isValid, required this.errors});

  final bool isValid;
  final List<String> errors;
}

/// Validates journal entries before they can be considered for posting.
class JournalEntryValidator {
  const JournalEntryValidator();

  JournalValidationResult validate(
    JournalEntry entry, {
    required List<Account> accounts,
  }) {
    final errors = <String>[];

    // Build a lookup table using account codes.
    final accountsByCode = {
      for (final account in accounts) account.code: account,
    };

    // Check whether every journal line references a valid account.
    for (final line in entry.lines) {
      final account = accountsByCode[line.accountCode];

      if (account == null) {
        errors.add(
          'Account ${line.accountCode} does not exist in the chart of accounts.',
        );
        continue;
      }

      // Inactive accounts cannot be used in new journal entries.
      if (!account.isActive) {
        errors.add(
          'Account ${line.accountCode} is inactive and cannot be used.',
        );
      }
    }

    // Debits and credits must always be equal.
    if (!entry.isBalanced) {
      errors.add(
        'Journal entry is not balanced: '
        'debits and credits must be equal.',
      );
    }

    return JournalValidationResult(
      isValid: errors.isEmpty,
      errors: List.unmodifiable(errors),
    );
  }
}
