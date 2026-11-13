import 'package:flutter_test/flutter_test.dart';
import 'package:esvro_accounting/esvro_accounting.dart';

void main() {
  group('Account types', () {
    test('assets and expenses have debit normal balances', () {
      expect(AccountType.assets.normalBalanceSide, BalanceSide.debit);
      expect(AccountType.expenses.normalBalanceSide, BalanceSide.debit);
    });

    test('liabilities, equity and income have credit normal balances', () {
      expect(AccountType.liabilities.normalBalanceSide, BalanceSide.credit);
      expect(AccountType.equity.normalBalanceSide, BalanceSide.credit);
      expect(AccountType.income.normalBalanceSide, BalanceSide.credit);
    });
  });

  group('Account', () {
    test('stores account details', () {
      final account = Account(
        code: '1000',
        name: 'Cash',
        type: AccountType.assets,
      );

      expect(account.code, '1000');
      expect(account.name, 'Cash');
      expect(account.type, AccountType.assets);
      expect(account.isActive, isTrue);
    });

    test('rejects an empty account code or name', () {
      expect(
        () => Account(code: '', name: 'Cash', type: AccountType.assets),
        throwsArgumentError,
      );

      expect(
        () => Account(code: '1000', name: ' ', type: AccountType.assets),
        throwsArgumentError,
      );
    });
  });

  group('Money', () {
    test('adds and subtracts exact minor units', () {
      const first = Money(minorUnits: 10050);
      const second = Money(minorUnits: 250);

      expect(first + second, const Money(minorUnits: 10300));
      expect(first - second, const Money(minorUnits: 9800));
    });

    test('rejects arithmetic across different currencies', () {
      const rupees = Money(minorUnits: 100, currencyCode: 'INR');
      const dollars = Money(minorUnits: 100, currencyCode: 'USD');

      expect(() => rupees + dollars, throwsArgumentError);
    });
  });

  group('Account balance', () {
    test('calculates debit-normal account balances', () {
      const balance = AccountBalance(
        totalDebits: Money(minorUnits: 10000),
        totalCredits: Money(minorUnits: 3000),
      );

      expect(
        balance.normalBalanceFor(AccountType.assets),
        const Money(minorUnits: 7000),
      );
    });

    test('calculates credit-normal account balances', () {
      const balance = AccountBalance(
        totalDebits: Money(minorUnits: 2000),
        totalCredits: Money(minorUnits: 9000),
      );

      expect(
        balance.normalBalanceFor(AccountType.income),
        const Money(minorUnits: 7000),
      );
    });

    test('preserves an abnormal negative balance', () {
      const balance = AccountBalance(
        totalDebits: Money(minorUnits: 2000),
        totalCredits: Money(minorUnits: 5000),
      );

      expect(
        balance.normalBalanceFor(AccountType.assets),
        const Money(minorUnits: -3000),
      );
    });

    test('rejects mismatched debit and credit currencies', () {
      const balance = AccountBalance(
        totalDebits: Money(minorUnits: 100, currencyCode: 'INR'),
        totalCredits: Money(minorUnits: 100, currencyCode: 'USD'),
      );

      expect(
        () => balance.normalBalanceFor(AccountType.assets),
        throwsArgumentError,
      );
    });
  });
}
