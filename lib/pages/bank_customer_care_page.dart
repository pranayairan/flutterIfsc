import 'package:bank_ifsc_flutter/network/IfscApi.dart';
import 'package:bank_ifsc_flutter/network/model/bank_care_data.dart';
import 'package:bank_ifsc_flutter/network/model/response_model.dart';
import 'package:bank_ifsc_flutter/utils/WidgetUtils.dart';
import 'package:bank_ifsc_flutter/utils/strings.dart';
import 'package:bank_ifsc_flutter/widgets/w_bank_care_card.dart';
import 'package:flutter/material.dart';

class BankCustomerCarePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BankCustomerCarePageStage();
  }
}

class _BankCustomerCarePageStage extends State<BankCustomerCarePage> {
  ResponseModel<List<BankCareData>> responseModel;

  @override
  void initState() {
    loadBankDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Customer Care"),
      ),
      body: _getBody(responseModel),
    );
  }

  void loadBankDataFromAPI() async {
    var model = await IfscAPI().getCustomerCareInfo();

    setState(() {
      responseModel = model;
    });
  }

  Widget _getBody(ResponseModel<List<BankCareData>> responseModel) {
    Widget container = Center(child: Text("No Banks Found"));
    if (responseModel == null) {
      container = Center(child: CircularProgressIndicator());
    } else if (responseModel.errorCode != 200) {
      WidgetUtils.showSnackBar(context, networkError);
    } else if (responseModel.data != null && responseModel.data.isNotEmpty) {
      container = _getBankCardsList(responseModel.data);
    }

    return container;
  }

  Widget _getBankCardsList(List<BankCareData> bankData) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 8.0, end: 8.0, top: 16.0, bottom: 8.0),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int position) {
          return BankCareCard(bankData[position]);
        },
        itemCount: bankData.length,
      ),
    );
  }
}
