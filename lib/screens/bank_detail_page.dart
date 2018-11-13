import 'package:bank_ifsc_flutter/network/IfscApi.dart';
import 'package:bank_ifsc_flutter/network/model/bank_data.dart';
import 'package:bank_ifsc_flutter/network/model/response_model.dart';
import 'package:bank_ifsc_flutter/utils/UiUtils.dart';
import 'package:bank_ifsc_flutter/utils/WidgetUtils.dart';
import 'package:bank_ifsc_flutter/utils/images.dart';
import 'package:bank_ifsc_flutter/utils/strings.dart';
import 'package:bank_ifsc_flutter/widgets/VerticalDivider.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class BankDetailsPage extends StatefulWidget {
  final BankData bankData;
  final String bankIFSC;

  BankDetailsPage({this.bankData, this.bankIFSC});

  @override
  State<StatefulWidget> createState() {
    return _BankDetailsPageState(bankData);
  }
}

class _BankDetailsPageState extends State<BankDetailsPage> {
  BankData localBankData;

  _BankDetailsPageState(this.localBankData);

  @override
  void initState() {
    if (localBankData == null) {
      _loadBankDataFromAPI();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bankDetailsTitle),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  (localBankData.bank).trim(),
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(localBankData.branch, style: UiUtils.getTextStyleForSecondaryText()),
              ),
              SizedBox(height: 12.0),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(bankDetailsIfscCode, style: UiUtils.getTextStyleForSecondaryText()),
                    SizedBox(width: 8.0),
                    Text(localBankData.ifsc, style: UiUtils.getTextStyleForListHeadersSecondary(context)),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(bankDetailsContact, style: UiUtils.getTextStyleForSecondaryText()),
                    SizedBox(width: 8.0),
                    Text(localBankData.contact != "null" ? localBankData.contact : "NA",
                        style: UiUtils.getTextStyleForListHeadersSecondary(context)),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
//                      InkWell(
//                        child: _getImageAndTextWidget(Save_Image, bankDetailsSave),
//                      ),
//                      VerticalDivider(),
                      InkWell(
                        child: _getImageAndTextWidget(Save_Sms, bankDetailsSms),
                        onTap: () {
                          _share();
                        },
                      ),
                      VerticalDivider(),
                      InkWell(
                        child: _getImageAndTextWidget(Save_Whatsapp, bankDetailsWhatsapp),
                        onTap: () {
                          _share();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: WidgetUtils.getMapsImageWidget(localBankData.bank, localBankData.branch, localBankData.address),
              ),
              SizedBox(
                height: 16.0,
              ),
              Card(
                child: Container(
                  margin: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(bankDetailsAddress, style: Theme.of(context).textTheme.body2),
                          SizedBox(width: 16.0),
                          Flexible(child: Text(localBankData.address, style: UiUtils.getTextStyleForSecondaryText())),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: <Widget>[
                          Text(bankDetailsDistrict, style: Theme.of(context).textTheme.body2),
                          SizedBox(width: 22.0),
                          Text(localBankData.district, style: UiUtils.getTextStyleForSecondaryText()),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: <Widget>[
                          Text(bankDetailsState, style: Theme.of(context).textTheme.body2),
                          SizedBox(width: 36.0),
                          Text(localBankData.state, style: UiUtils.getTextStyleForSecondaryText()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _share() {
    String textToSend =
        "Bank : ${localBankData.bank}\n\nBranch: ${localBankData.branch}\n\nIFSC CODE: ${localBankData.ifsc}\n\nAddress: ${localBankData.address}"
        "\n\nBranch Phone: ${localBankData.contact != "null" ? localBankData.contact : "NA"}. \n\nFind IFSC and Check Balance with IFSC Balance finder, Download now https://kzun.app.link/bankIfsc";

    Share.share(textToSend);
  }

  Widget _getImageAndTextWidget(String imageName, String label) {
    return Column(
      children: <Widget>[
        Image(
          height: 40.0,
          image: AssetImage(imageName),
        ),
        SizedBox(
          height: 6.0,
        ),
        Text(label)
      ],
    );
  }

  void _loadBankDataFromAPI() async {
    if (widget.bankIFSC != null) {
      ResponseModel<List<BankData>> responseModel = await IfscAPI().searchBankByIFSC(widget.bankIFSC);
      if (responseModel.errorCode == 200 && responseModel.data != null) {
        setState(() {
          localBankData = responseModel.data[0];
        });
      }
    }
  }
}
