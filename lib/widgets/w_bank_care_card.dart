import 'package:bank_ifsc_flutter/network/model/bank_care_data.dart';
import 'package:bank_ifsc_flutter/utils/widget_utils.dart';
import 'package:flutter/material.dart';

import 'w_circular_image_view.dart';

class BankCareCard extends StatelessWidget {
  final BankCareData bankData;

  BankCareCard(this.bankData);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.0),
      child: Card(
        child: InkWell(
          onTap: () {
            WidgetUtils.launchPhoneNumber(bankData.customerCareNum);
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
                      Text(bankData.customerCareNum, style: Theme.of(context).textTheme.subhead),
                    ],
                  ),
                ),
                Icon(Icons.call, size: 32.0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
