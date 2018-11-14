import 'dart:math' as Math;

import 'package:bank_ifsc_flutter/utils/ut_utils.dart';
import 'package:bank_ifsc_flutter/utils/widget_utils.dart';
import 'package:bank_ifsc_flutter/misc/strings.dart';
import 'package:flutter/material.dart';

class CompoundInterestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CompoundInterestPageState();
  }
}

class _CompoundInterestPageState extends State<CompoundInterestPage> {
  TextEditingController tecAmount = TextEditingController();
  TextEditingController tecInterest = TextEditingController();
  TextEditingController tecPeriod = TextEditingController();
  TextEditingController tecMonthlyDep = TextEditingController();
  String compounded = "Weekly";
  double matuarityValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(compoundInterestTitle),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _getTopSection(context),
              _getBottomSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTopSection(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(compoundInterestPrincipalAmt, style: Theme.of(context).textTheme.title),
            TextField(
              controller: tecAmount,
              decoration: InputDecoration(hintText: compoundInterestPrincipalAmtEx),
              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
            ),
            SizedBox(height: 16.0),
            Text(compoundInterestAnnualInt, style: Theme.of(context).textTheme.title),
            TextField(
              controller: tecInterest,
              decoration: InputDecoration(hintText: compoundInterestAnnualIntEx),
              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
            ),
            SizedBox(height: 16.0),
            Text(compoundInterestPeriod, style: Theme.of(context).textTheme.title),
            TextField(
              controller: tecPeriod,
              decoration: InputDecoration(hintText: compoundInterestPeriodEx),
              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
            ),
            SizedBox(height: 16.0),
            Text(compoundInterestMonthlyDep, style: Theme.of(context).textTheme.title),
            TextField(
              controller: tecMonthlyDep,
              decoration: InputDecoration(hintText: compoundInterestMonthlyDepEx),
              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  compoundInterestCompounded,
                  style: Theme.of(context).textTheme.subhead,
                ),
                SizedBox(width: 32.0),
                _getDropDownWidget((String data) {
                  compounded = data;
                })
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        tecAmount.text = "";
                        tecInterest.text = "";
                        tecPeriod.text = "";
                        tecMonthlyDep.text = "";
                        matuarityValue = 0.0;
                        WidgetUtils.dismissKeyboard(context);
                      });
                    },
                    child: Text(compoundInterestReset),
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                SizedBox(width: 32.0),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        WidgetUtils.dismissKeyboard(context);
                        _calculate();
                      });
                    },
                    child: Text(compoundInterestCalculate),
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _getBottomSection(BuildContext context) {
    double principalValue = 0.0;
    double interestValue = 0.0;

    if (matuarityValue > 0) {
      if (tecMonthlyDep.text != null &&
          tecMonthlyDep.text.isNotEmpty &&
          tecAmount.text != null &&
          tecAmount.text.isNotEmpty &&
          tecMonthlyDep.text != null &&
          tecMonthlyDep.text.isNotEmpty &&
          tecPeriod.text != null &&
          tecPeriod.text.isNotEmpty) {
        principalValue = double.parse(tecAmount.text) + double.parse(tecMonthlyDep.text) * double.parse(tecPeriod.text);
      } else if (tecAmount.text != null && tecAmount.text.isNotEmpty) {
        principalValue = double.parse(tecAmount.text);
      }
      interestValue = matuarityValue - principalValue;
    }

    return Card(
      child: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _getResultColumn("${principalValue.toStringAsFixed(2)} ₹", compoundInterestTotalPrincipal),
                  _getResultColumn("${interestValue.toStringAsFixed(2)} ₹", compoundInterestInterestAmount),
                ],
              ),
              SizedBox(height: 32.0),
              Column(
                children: <Widget>[
                  Text(compoundInterestMaturityValue, style: Theme.of(context).textTheme.title),
                  SizedBox(height: 8.0),
                  Text("${matuarityValue.toStringAsFixed(2)} ₹", style: Theme.of(context).textTheme.headline),
                ],
              )
            ],
          )),
    );
  }

  Widget _getResultColumn(String data, String subLabel) {
    return Column(
      children: <Widget>[
        Text(data, style: Theme.of(context).textTheme.headline),
        Text(subLabel, style: UiUtils.getTextStyleForSecondaryText()),
      ],
    );
  }

  Widget _getDropDownWidget(Function function) {
    List<String> items = ["Weekly", "Monthly", "Quarterly", "Half-Yearly", "Annually"];
    var itemList = items.map<DropdownMenuItem<String>>((String data) {
      return DropdownMenuItem<String>(
        value: data,
        child: Text(data),
      );
    }).toList();

    return DropdownButton<String>(
      items: itemList,
      onChanged: (String data) {
        setState(() {
          function(data);
        });
      },
      value: compounded,
    );
  }

  _calculate() {
    double principal = double.parse(tecAmount.text);
    double rate = double.parse(tecInterest.text);
    double periodInMonths = double.parse(tecPeriod.text);
    double monthlyContribution = 0.0;
    if (tecMonthlyDep.text != null && tecMonthlyDep.text.isNotEmpty) {
      monthlyContribution = double.parse(tecMonthlyDep.text);
    }

    if (principal > 0.0 && rate > 0.0 && periodInMonths > 0.0 && monthlyContribution > 0.0) {
      matuarityValue =
          _calculateCIWithMonthlyDeposit(principal, monthlyContribution, rate / 100, periodInMonths, compounded);
    } else if (principal > 0.0 && rate > 0.0 && periodInMonths > 0.0) {
      matuarityValue = _calculateCIWithoutMonthlyDeposit(principal, rate, periodInMonths, compounded);
    }
  }

  double _calculateCIWithoutMonthlyDeposit(double principal, double rate, double periodInMonths, String compoundTime) {
    double maturityValue = 0.0;

    if (compoundTime == "Weekly") {
      maturityValue = principal * Math.pow((1 + (rate / 100 / 52)), (52 * periodInMonths / 12));
    } else if (compoundTime == "Monthly") {
      maturityValue = principal * Math.pow((1 + (rate / 100 / 12)), (12 * periodInMonths / 12));
    } else if (compoundTime == "Quarterly") {
      maturityValue = principal * Math.pow((1 + (rate / 100 / 4)), (4 * periodInMonths / 12));
    } else if (compoundTime == "Half-Yearly") {
      maturityValue = principal * Math.pow((1 + (rate / 100 / 2)), (2 * periodInMonths / 12));
    } else if (compoundTime == "Annually") {
      maturityValue = principal * Math.pow((1 + (rate / 100)), (periodInMonths / 12));
    }

    return maturityValue;
  }

  double _calculateCIWithMonthlyDeposit(
      double principal, double monthlyContribution, double rate, double periodInMonths, String compoundTime) {
    int interestFrequency = 0;
    if (compoundTime == "Weekly") {
      interestFrequency = 52;
    } else if (compoundTime == "Monthly") {
      interestFrequency = 12;
    } else if (compoundTime == "Quarterly") {
      interestFrequency = 4;
    } else if (compoundTime == "Half-Yearly") {
      interestFrequency = 2;
    } else if (compoundTime == "Annually") {
      interestFrequency = 1;
    }

    final double interestPeriod = 12.0 / interestFrequency;
    final double pRate = Math.pow(1 + rate, 1.0 / interestPeriod) - 1;
    double value = principal;

    for (int i = 0; i < periodInMonths; ++i) {
      value += monthlyContribution;
      if (i % interestFrequency == interestFrequency - 1) {
        value *= 1 + pRate;
      }
    }
    return value;
  }
}
