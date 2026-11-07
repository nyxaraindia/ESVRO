import 'account_type.dart';

/// An individual account in a business's chart of accounts.
class Account {
  Account({
    required this.code,
    required this.name,
    required this.type,
    this.isActive = true,
  }) {
    if (code.trim().isEmpty) {
      throw ArgumentError.value(code, 'code', 'Account code cannot be empty.');
    }
    if (name.trim().isEmpty) {
      throw ArgumentError.value(name, 'name', 'Account name cannot be empty.');
    }
  }

  final String code;
  final String name;
  final AccountType type;
  final bool isActive;
}
