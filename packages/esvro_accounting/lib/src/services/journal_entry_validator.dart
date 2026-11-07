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

  JournalValidationResult validate(JournalEntry entry) {
    final errors = <String>[];

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
