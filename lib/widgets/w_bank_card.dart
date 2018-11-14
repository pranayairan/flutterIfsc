import 'package:bank_ifsc_flutter/config/application.dart';
import 'package:bank_ifsc_flutter/config/routes.dart';
import 'package:bank_ifsc_flutter/network/model/bank_care_data.dart';
import 'package:flutter/material.dart';

import 'w_circular_image_view.dart';

class BankCard extends StatelessWidget {
  final BankCareData bankData;

  BankCard(this.bankData);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.0),
      child: Card(
        child: InkWell(
          onTap: () {
            // balanceCheckDetail
            Uri balancCheckroute = Uri.http("", "${Routes.balanceCheckDetail}", {
              "bankName": "${bankData.bankName}",
              "bankBalanceNum": "${bankData.bankBalanceNum}",
              "miniStatementNum": "${bankData.miniStatementNum}",
              "customerCareNum": "${bankData.customerCareNum}",
              "officialWebsite": "${bankData.officialWebsite}",
              "personalWebsite": "${bankData.personalWebsite}"
            });

            String route = balancCheckroute.toString().replaceAll("http:", "");
            Application.router.navigateTo(context, route);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircularImageView(bankData.bankName[0].toUpperCase()),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(bankData.bankName, style: Theme.of(context).textTheme.subhead),
                      SizedBox(height: 8.0),
                      Text(
                        bankData.officialWebsite,
                        style: Theme.of(context).textTheme.body1,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
