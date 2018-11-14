import 'package:bank_ifsc_flutter/misc/strings.dart';
import 'package:bank_ifsc_flutter/misc/styles.dart';
import 'package:bank_ifsc_flutter/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class BankBalanceDetailPage extends StatelessWidget {
  final String bankName;
  final String bankBalanceNum;
  final String miniStatementNum;
  final String customerCareNum;
  final String officialWebsite;
  final String personalWebsite;

  BankBalanceDetailPage(
      {this.bankName,
      this.bankBalanceNum,
      this.miniStatementNum,
      this.customerCareNum,
      this.officialWebsite,
      this.personalWebsite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 44.0, right: 44.0, bottom: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      bankName,
                      style: TextStyle(fontSize: fontSizePageTitle, color: Colors.white),
                    ),
                    SizedBox(height: 16.0),
                    InkWell(
                      onTap: () {
                        WidgetUtils.launchUrl(officialWebsite);
                      },
                      child: Text(
                        officialWebsite,
                        style: TextStyle(fontSize: fontSizeParagraph, color: Colors.white),
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    InkWell(
                      onTap: () {
                        WidgetUtils.launchUrl(personalWebsite);
                      },
                      child: Text(
                        personalWebsite,
                        style: TextStyle(fontSize: fontSizeParagraph, color: Colors.white),
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: _getBankBalanceCard(context),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: _getMiniStatementCard(context),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: _getCustomerCareCard(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBankBalanceCard(BuildContext context) {
    return _getSectionCard(
        context,
        balanceCheckBankBalance,
        "Give a miss call to $bankName for checking balance",
        bankBalanceNum,
        "Give a Miss Call to $bankName to get Bank Balance, on this number $bankBalanceNum \n\nFind IFSC and Check Balance with IFSC Balance finder, Download now https://kzun.app.link/bankIfsc");
  }

  Widget _getMiniStatementCard(BuildContext context) {
    return _getSectionCard(
        context,
        balanceCheckMiniStatement,
        "Give a miss call to $bankName for check mini statement",
        miniStatementNum,
        "Give a Miss Call to $bankName to get mini statement, on this number $miniStatementNum \n\nFind IFSC and Check Balance with IFSC Balance finder, Download now https://kzun.app.link/bankIfsc");
  }

  Widget _getCustomerCareCard(BuildContext context) {
    return _getSectionCard(context, balanceCheckCustomerCare, "Call to $bankName for other request", customerCareNum,
        "$bankName customer care number: $customerCareNum \n\nFind IFSC and Check Balance with IFSC Balance finder, Download now https://kzun.app.link/bankIfsc");
  }

  Widget _getSectionCard(BuildContext context, String title, String content, String phoneNumber, String shareContent) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: TextStyle(fontSize: fontSizeListItems, color: Theme.of(context).primaryColor)),
                  SizedBox(height: 24.0),
                  Text(content),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.call, size: 36.0),
                          onPressed: () {
                            WidgetUtils.launchPhoneNumber(phoneNumber);
                          }),
                      SizedBox(width: 16.0),
                      IconButton(
                          icon: Icon(Icons.share, size: 36.0),
                          onPressed: () {
                            _share(shareContent);
                          })
                    ],
                  ),
                  SizedBox(height: 32.0),
                  Text(phoneNumber,
                      style: TextStyle(fontSize: fontSizeListItems, color: Theme.of(context).accentColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _share(String textToSend) {
    Share.share(textToSend);
  }
}
