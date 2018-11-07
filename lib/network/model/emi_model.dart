class EmiModel {
  int _paymentYear;
  double _principalAmount;
  double _interestAmount;
  double _balanceAmount;
  int _paymentMonth;
  double _price;
  double _salesTax;
  double _percentOff;
  double _percentUp;
  String _displayMonthYear;

  int get paymentYear => _paymentYear;

  set paymentYear(int value) {
    _paymentYear = value;
  }

  double get principalAmount => _principalAmount;

  String get displayMonthYear => _displayMonthYear;

  set displayMonthYear(String value) {
    _displayMonthYear = value;
  }

  double get percentUp => _percentUp;

  set percentUp(double value) {
    _percentUp = value;
  }

  double get percentOff => _percentOff;

  set percentOff(double value) {
    _percentOff = value;
  }

  double get salesTax => _salesTax;

  set salesTax(double value) {
    _salesTax = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  int get paymentMonth => _paymentMonth;

  set paymentMonth(int value) {
    _paymentMonth = value;
  }

  double get balanceAmount => _balanceAmount;

  set balanceAmount(double value) {
    _balanceAmount = value;
  }

  double get interestAmount => _interestAmount;

  set interestAmount(double value) {
    _interestAmount = value;
  }

  set principalAmount(double value) {
    _principalAmount = value;
  }
}
