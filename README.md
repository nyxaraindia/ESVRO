# ESVRO — Business AI Accountant

ESVRO is a two-app bookkeeping ecosystem that helps businesses capture financial records and helps accountants review them. It is built with Flutter and SQLite, with a clear separation between deterministic bookkeeping and optional AI assistance.

## The ESVRO apps

| App | For | Purpose |
| --- | --- | --- |
| **ESVRO Snap** | Shop owners | Capture invoices offline and export them for bookkeeping. |
| **ESVRO Ledger** | Accountants | Verify submitted records and manage bookkeeping. |

Together, the apps are designed to make it easier to move from day-to-day business documents to accountant-reviewed records.

## Designed for trustworthy bookkeeping

- **Offline-friendly capture:** Snap is designed to capture and export invoices without requiring an always-on connection.
- **Deterministic core:** Financial records and bookkeeping logic are kept distinct from AI features.
- **Human review:** AI can assist, but financial data remains traceable and subject to human approval.
- **SQLite storage:** The apps use SQLite as part of their data foundation.

AI is an assistant—not the authority for financial decisions. Review records before relying on them for accounting, tax, or compliance purposes.

## Repository layout

```text
ESVRO/
├── ESVRO APP/
│   └── apps/
│       ├── esvro_snap/    # ESVRO Snap Flutter app
│       └── esvro_ledger/  # ESVRO Ledger Flutter app
└── ESVRO LEARNING/       # Learning notes and project goals
```

## Getting started

Install the [Flutter SDK](https://docs.flutter.dev/get-started/install), then open the app you want to work on. From that app's directory, fetch its dependencies and launch it on a configured device or emulator:

```bash
cd "ESVRO APP/apps/esvro_snap"
flutter pub get
flutter run
```

For the accountant app, use `ESVRO APP/apps/esvro_ledger` instead. See each app directory's README for app-specific setup as the project develops.

## Project status

ESVRO is under active development. Features, setup details, and architecture may change as the two apps evolve.

## Contributing

Contributions and feedback are welcome. Please keep changes aligned with ESVRO's core principles: traceable records, deterministic bookkeeping, and human-approved financial data.

## License

No license has been specified yet. Until one is added, all rights are reserved by the repository's copyright holder.
