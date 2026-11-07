/// The five fundamental account types used in double-entry accounting.
enum AccountType { assets, liabilities, equity, income, expenses }

/// The side on which an account normally increases.
enum BalanceSide { debit, credit }

extension AccountTypeAccounting on AccountType {
  /// Assets and expenses normally carry debit balances.
  /// Liabilities, equity and income normally carry credit balances.
  BalanceSide get normalBalanceSide {
    switch (this) {
      case AccountType.assets:
      case AccountType.expenses:
        return BalanceSide.debit;
      case AccountType.liabilities:
      case AccountType.equity:
      case AccountType.income:
        return BalanceSide.credit;
    }
  }
}
