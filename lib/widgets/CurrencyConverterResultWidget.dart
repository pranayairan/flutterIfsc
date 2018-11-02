import 'package:flutter/material.dart';

class CurrencyConverterResultWidget extends StatefulWidget {

  final String fromCurrency;
  final String toCurrency;

  CurrencyConverterResultWidget(this.fromCurrency, this.toCurrency);

  @override
  State<StatefulWidget> createState() {
    return _CurrencyConverterResultWidgetState();
  }
}

class _CurrencyConverterResultWidgetState extends State<CurrencyConverterResultWidget> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  }
}
