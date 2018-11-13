import 'package:bank_ifsc_flutter/network/IfscApi.dart';
import 'package:bank_ifsc_flutter/network/model/bank_data.dart';
import 'package:bank_ifsc_flutter/network/model/response_model.dart';
import 'package:bank_ifsc_flutter/utils/WidgetUtils.dart';
import 'package:bank_ifsc_flutter/utils/strings.dart';
import 'package:bank_ifsc_flutter/widgets/w_bank_search_card.dart';
import 'package:flutter/material.dart';

class SearchBankPage extends StatefulWidget {
  final String bankName;
  final String bankState;
  final String bankCity;
  final String bankBranch;

  SearchBankPage({this.bankName, this.bankState, this.bankCity, this.bankBranch});

  @override
  State<StatefulWidget> createState() {
    return _SearchBankPageStage();
  }
}

class _SearchBankPageStage extends State<SearchBankPage> {
  ResponseModel<List<BankData>> responseModel;

  @override
  void initState() {
    loadBankDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bankSearchTitle),
      ),
      body: _getBody(responseModel),
    );
  }

  void loadBankDataFromAPI() async {
    var model = await IfscAPI().searchBank(
        bankName: widget.bankName,
        bankState: widget.bankState,
        bankCity: widget.bankCity,
        bankBranch: widget.bankBranch,
        pageNumber: "1");

    setState(() {
      responseModel = model;
    });
  }

  Widget _getBody(ResponseModel<List<BankData>> responseModel) {
    Widget container = Center(child: Text(bankSearchEmptyResult));
    if (responseModel == null) {
      container = Center(child: CircularProgressIndicator());
    } else if (responseModel.data != null && responseModel.data.isNotEmpty) {
      container = _getBankCardsList(responseModel.data);
    }

    return container;
  }

  Widget _getBankCardsList(List<BankData> bankData) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 8.0, end: 8.0, top: 16.0, bottom: 8.0),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int position) {
          return BankSearchCard(bankData[position]);
        },
        itemCount: bankData.length,
      ),
    );
  }
}
