import 'account_type.dart';
import 'money.dart';

/// Calculates an account's balance from its total debits and credits.
///
/// A negative normal balance is preserved because it can indicate an
/// unusual or opposite-side balance that should be reviewed.
class AccountBalance {
  const AccountBalance({required this.totalDebits, required this.totalCredits});

  final Money totalDebits;
  final Money totalCredits;

  Money normalBalanceFor(AccountType accountType) {
    if (totalDebits.currencyCode != totalCredits.currencyCode) {
      throw ArgumentError('Debit and credit currencies must match.');
    }

    switch (accountType.normalBalanceSide) {
      case BalanceSide.debit:
        return totalDebits - totalCredits;
      case BalanceSide.credit:
        return totalCredits - totalDebits;
    }
  }
}
