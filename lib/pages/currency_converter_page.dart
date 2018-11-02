import 'package:bank_ifsc_flutter/network/OtherApi.dart';
import 'package:bank_ifsc_flutter/network/model/response_model.dart';
import 'package:bank_ifsc_flutter/utils/CommonUtils.dart';
import 'package:bank_ifsc_flutter/utils/UiUtils.dart';
import 'package:bank_ifsc_flutter/utils/WidgetUtils.dart';
import 'package:bank_ifsc_flutter/utils/strings.dart';
import 'package:flutter/material.dart';

class CurrencyConverterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CurrencyConverterPageState();
  }
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  TextEditingController textEditingController = TextEditingController(text: "0");
  double exchangeRate = 0.0;
  String fromCurrency = CommonUtils.currencyName[1].currencyValue;
  String toCurrency = CommonUtils.currencyName[0].currencyValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currencyConverterTitle),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                child: Container(
                  margin: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "From :",
                            style: UiUtils.getTextStyleForListSubTitle(isBold: true),
                          ),
                          _getDropDownWidget(
                            CommonUtils.currencyName,
                            (CurrencyConverterData data) {
                              fromCurrency = data.currencyValue;
                            },
                            CommonUtils.currencyName[1],
                          )
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "To :",
                            style: UiUtils.getTextStyleForListSubTitle(isBold: true),
                          ),
                          _getDropDownWidget(
                            CommonUtils.currencyName,
                            (CurrencyConverterData data) {
                              toCurrency = data.currencyValue;
                            },
                            CommonUtils.currencyName[0],
                          )
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Amount :",
                            style: UiUtils.getTextStyleForListSubTitle(isBold: true),
                          ),
                          SizedBox(width: 60.0),
                          Flexible(
                            child: TextField(
                              controller: textEditingController,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8.0),
                      RaisedButton(
                        onPressed: () {
                          _loadExchangeRateFromAPI(fromCurrency, toCurrency);
                        },
                        child: Text("Get Rates"),
                        color: Theme.of(context).primaryColorLight,
                      )
                    ],
                  ),
                ),
              ),
              Card(
                  child: Container(
                      margin: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Exchange Rate:",
                                style: UiUtils.getTextStyleForListSubTitle(isBold: true),
                              ),
                              Text(
                                "${exchangeRate.toStringAsFixed(2)}",
                                style: UiUtils.getTextStyleForListSubTitle(isBold: false),
                              )
                            ],
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Value:",
                                style: UiUtils.getTextStyleForListSubTitle(isBold: true),
                              ),
                              Text(
                                "${(double.parse(textEditingController.text) * exchangeRate).toStringAsFixed(2)}",
                                style: UiUtils.getTextStyleForListSubTitle(isBold: false),
                              )
                            ],
                          ),
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }

  Widget _getDropDownWidget(List<CurrencyConverterData> items, Function function, CurrencyConverterData value) {
    var itemList = items.map<DropdownMenuItem<CurrencyConverterData>>((CurrencyConverterData data) {
      return DropdownMenuItem<CurrencyConverterData>(
        value: data,
        child: Text(data.currencyName),
      );
    }).toList();

    return DropdownButton<CurrencyConverterData>(
      items: itemList,
      onChanged: function,
      value: value,
    );
  }

  void _loadExchangeRateFromAPI(String fromCurrency, String toCurrency) async {
    if (fromCurrency != null && toCurrency != null) {
      ResponseModel<double> responseModel =
          await OtherAPI().getRates(fromCurrency: fromCurrency, toCurrency: toCurrency);
      if (responseModel.errorCode == 200 && responseModel.data != null) {
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          exchangeRate = responseModel.data;
        });
      } else {
        WidgetUtils.showSnackBar(context, responseModel.errorMessage);
      }
    }
  }
}
