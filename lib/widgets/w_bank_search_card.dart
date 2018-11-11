import 'package:bank_ifsc_flutter/config/application.dart';
import 'package:bank_ifsc_flutter/config/routes.dart';
import 'package:bank_ifsc_flutter/network/model/bank_data.dart';
import 'package:bank_ifsc_flutter/utils/UiUtils.dart';
import 'package:bank_ifsc_flutter/utils/strings.dart';
import 'package:flutter/material.dart';

class BankSearchCard extends StatelessWidget {
  final BankData bankData;

  BankSearchCard(this.bankData);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: InkWell(
              onTap: () {
                String route = "${Routes.bankDetails}?bankName=${bankData.bank}&bankState=${bankData.state}&"
                    "bankCity=${bankData.city}&bankBranch=${bankData.branch}&bankIFSC=${bankData.ifsc}&"
                    "bankDistrict=${bankData.district}&bankContact=${bankData.contact}&bankAddress=${bankData.address}&"
                    "bankRtgs=${bankData.rtgs}";

                Application.router.navigateTo(context, route);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    bankData.bank,
                    style: Theme.of(context).textTheme.body1,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    bankData.address,
                    style: UiUtils.getSmallTextStyleForListSubTitle(),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        bankData.ifsc,
                        style: UiUtils.getTextStyleForListHeaders(true),
                      ),
                      Text(
                        bankMoreDetails,
                        style: UiUtils.getTextStyleForListSubTitle(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
