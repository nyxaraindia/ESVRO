import '../models/account.dart';
import '../models/audit/journal_audit_event.dart';
import '../models/journal/journal_entry.dart';
import 'journal_entry_validator.dart';

/// Represents a journal entry that has successfully been posted.
class PostedJournalEntry {
  const PostedJournalEntry({
    required this.entry,
    required this.postedAt,
    required this.actorId,
  });

  final JournalEntry entry;
  final DateTime postedAt;
  final String actorId;
}

/// Contains the result of attempting to post a journal entry.
class JournalPostingResult {
  JournalPostingResult({
    required this.isPosted,
    required List<String> errors,
    this.postedEntry,
    this.auditEvent,
  }) : errors = List.unmodifiable(errors);

  final bool isPosted;
  final List<String> errors;
  final PostedJournalEntry? postedEntry;
  final JournalAuditEvent? auditEvent;
}

/// Controls which journal entries can be posted.
class JournalPostingService {
  JournalPostingService({
    JournalEntryValidator? validator,
    DateTime Function()? clock,
  }) : _validator = validator ?? const JournalEntryValidator(),
       _clock = clock ?? DateTime.now;

  final JournalEntryValidator _validator;
  final DateTime Function() _clock;

  final Map<String, PostedJournalEntry> _postedEntries = {};
  final List<JournalAuditEvent> _auditEvents = [];

  /// Returns an unmodifiable list of posted entries.
  List<PostedJournalEntry> get postedEntries =>
      List.unmodifiable(_postedEntries.values);

  /// Returns an unmodifiable audit history.
  List<JournalAuditEvent> get auditEvents => List.unmodifiable(_auditEvents);

  /// Attempts to post a journal entry.
  JournalPostingResult post(
    JournalEntry entry, {
    required List<Account> accounts,
    required String actorId,
  }) {
    if (actorId.trim().isEmpty) {
      return JournalPostingResult(
        isPosted: false,
        errors: ['Actor ID cannot be empty.'],
      );
    }

    // Prevent the same journal entry from being posted twice.
    if (_postedEntries.containsKey(entry.id)) {
      return JournalPostingResult(
        isPosted: false,
        errors: ['Journal entry ${entry.id} has already been posted.'],
      );
    }

    // Validate accounts and debit/credit totals before posting.
    final validation = _validator.validate(entry, accounts: accounts);

    if (!validation.isValid) {
      return JournalPostingResult(isPosted: false, errors: validation.errors);
    }

    // Capture one timestamp for both posting and audit history.
    final timestamp = _clock().toUtc();

    final postedEntry = PostedJournalEntry(
      entry: entry,
      postedAt: timestamp,
      actorId: actorId.trim(),
    );

    // Create an audit record for this successful posting.
    final auditEvent = JournalAuditEvent(
      eventId: 'AUD-${entry.id}-POSTED',
      journalEntryId: entry.id,
      action: JournalAuditAction.posted,
      actorId: actorId.trim(),
      occurredAt: timestamp,
    );

    _postedEntries[entry.id] = postedEntry;
    _auditEvents.add(auditEvent);

    return JournalPostingResult(
      isPosted: true,
      errors: [],
      postedEntry: postedEntry,
      auditEvent: auditEvent,
    );
  }
}
