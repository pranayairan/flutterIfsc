import 'package:bank_ifsc_flutter/network/model/bank_data.dart';
import 'package:bank_ifsc_flutter/pages/bank_detail_page.dart';
import 'package:bank_ifsc_flutter/pages/home_page.dart';
import 'package:bank_ifsc_flutter/pages/search_bank_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

// route all request to home page
var rootHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new HomePage();
});

var searchBankRouteHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new SearchBankPage(
    bankName: params["bankName"]?.first,
    bankState: params["bankState"]?.first,
    bankCity: params["bankCity"]?.first,
    bankBranch: params["bankBranch"]?.first,
  );
});

var bankDetailsRouteHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new BankDetailsPage(
    bankData: BankData(
        bank: params["bankName"]?.first,
        state: params["bankState"]?.first,
        city: params["bankCity"]?.first,
        branch: params["bankBranch"]?.first,
        ifsc: params["bankIFSC"]?.first,
        district: params["bankDistrict"]?.first,
        contact: params["bankContact"]?.first,
        address: params["bankAddress"]?.first,
        rtgs: params["bankRtgs"]?.first),
    bankIFSC: params["bankIFSC"]?.first,
  );
});

//var demoFunctionHandler = new Handler(
//    type: HandlerType.function,
//    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//      String message = params["message"]?.first;
//      showDialog(
//        context: context,
//        builder: (context) {
//          return new AlertDialog(
//            title: new Text(
//              "Hey Hey!",
//              style: new TextStyle(
//                color: const Color(0xFF00D6F7),
//                fontFamily: "Lazer84",
//                fontSize: 22.0,
//              ),
//            ),
//            content: new Text("$message"),
//            actions: <Widget>[
//              new Padding(
//                padding: new EdgeInsets.only(bottom: 8.0, right: 8.0),
//                child: new FlatButton(
//                  onPressed: () {
//                    Navigator.of(context).pop(true);
//                  },
//                  child: new Text("OK"),
//                ),
//              ),
//            ],
//          );
//        },
//      );
//    });

/// Handles deep links into the app
/// To test on Android:
///
/// `adb shell am start -W -a android.intent.action.VIEW -d "fluro://deeplink?path=/message&mesage=fluro%20rocks%21%21" com.goposse.fluro`
//var deepLinkHandler = new Handler(
//    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//      String colorHex = params["color_hex"]?.first;
//      String result = params["result"]?.first;
//      Color color = new Color(0xFFFFFFFF);
//      if (colorHex != null && colorHex.length > 0) {
//        color = new Color(ColorHelpers.fromHexString(colorHex));
//      }
//      return new DemoSimpleComponent(
//          message: "DEEEEEP LINK!!!", color: color, result: result);
//    });
