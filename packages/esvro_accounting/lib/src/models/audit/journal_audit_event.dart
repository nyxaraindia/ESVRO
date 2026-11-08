/// Actions that can be recorded in a journal entry's audit history.
enum JournalAuditAction { posted }

/// An immutable record of an important journal entry event.
class JournalAuditEvent {
  const JournalAuditEvent({
    required this.eventId,
    required this.journalEntryId,
    required this.action,
    required this.actorId,
    required this.occurredAt,
  });

  /// Unique identifier for this audit event.
  final String eventId;

  /// The journal entry affected by this event.
  final String journalEntryId;

  /// What happened to the journal entry.
  final JournalAuditAction action;

  /// Identifier of the person or system performing the action.
  final String actorId;

  /// The exact time the event occurred, stored in UTC.
  final DateTime occurredAt;
}
