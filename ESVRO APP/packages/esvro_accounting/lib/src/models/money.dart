/// Represents money using integer minor units to avoid floating-point errors.
///
/// For INR, 10050 minor units represent ₹100.50.
class Money {
  const Money({required this.minorUnits, this.currencyCode = 'INR'});

  final int minorUnits;
  final String currencyCode;

  Money operator +(Money other) {
    _ensureSameCurrency(other);
    return Money(
      minorUnits: minorUnits + other.minorUnits,
      currencyCode: currencyCode,
    );
  }

  Money operator -(Money other) {
    _ensureSameCurrency(other);
    return Money(
      minorUnits: minorUnits - other.minorUnits,
      currencyCode: currencyCode,
    );
  }

  void _ensureSameCurrency(Money other) {
    if (currencyCode != other.currencyCode) {
      throw ArgumentError('Cannot calculate using different currencies.');
    }
  }

  @override
  bool operator ==(Object other) =>
      other is Money &&
      other.minorUnits == minorUnits &&
      other.currencyCode == currencyCode;

  @override
  int get hashCode => Object.hash(minorUnits, currencyCode);

  @override
  String toString() => '$currencyCode $minorUnits minor units';
}
