import 'dart:async';
import 'dart:convert';

import 'package:bank_ifsc_flutter/config/application.dart';
import 'package:bank_ifsc_flutter/network/model/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_logger/http_logger.dart';
import 'package:http_middleware/http_middleware.dart';
import 'package:logging/logging.dart';

import 'model/bank_data.dart';

class IfscAPI {
  String _baseIFSCUrl = "http://10.0.2.2:8080/BankIFSCLocator";

  final Logger logger = Logger("IfscAPI");

  HttpWithMiddleware httpClient = HttpWithMiddleware.build(
      middlewares:
          Application.isInDebugMode ? [HttpLogger(logLevel: LogLevel.BODY)] : [HttpLogger(logLevel: LogLevel.NONE)]);

  final Map<String, String> headers = {"Accept": "application/json", "Content-Type": "multipart/form-data"};

  /// Method to get search bank
  Future<ResponseModel<List<BankData>>> searchBank(
      {String bankName, String bankState, String bankCity, String bankBranch, String pageNumber}) async {
    Map<String, dynamic> bankRequestData = {'bankname': bankName, 'encodedon': DateTime.now().millisecondsSinceEpoch};
    bankRequestData["state"] = bankState;
    bankRequestData["city"] = bankCity;
    if (bankBranch != null && bankBranch.isNotEmpty) {
      bankRequestData["branch"] = bankBranch;
    }
    bankRequestData["pagenumber"] = pageNumber;

    String url = "$_baseIFSCUrl/searchBanksRazorPay.php";

    http.Response response = await httpClient.post(url, headers: headers, body: json.encode(bankRequestData));

    if (response.statusCode == 200) {
      List<BankData> parseResult = _parseResult(response.body);
      return ResponseModel(errorCode: response.statusCode, data: parseResult, errorMessage: null);
    } else {
      logger.severe("Unable to load bank detils via IFSC, $response");
      return ResponseModel(errorCode: response.statusCode, errorMessage: "Unable to find bank", data: null);
    }
  }

  /// Method to get bank details by specific IFSC code.
  Future<ResponseModel<List<BankData>>> searchBankByIFSC(String ifscCode) async {
    final Map<String, dynamic> bankRequestData = {'ifsc': ifscCode, 'encodedon': DateTime.now().millisecondsSinceEpoch};

    String url = "$_baseIFSCUrl/getBankDetailsRazorPay.php";

    http.Response response = await httpClient.post(url, headers: headers, body: json.encode(bankRequestData));

    if (response.statusCode == 200) {
      List<BankData> parseResult = _parseResult(response.body);
      return ResponseModel(errorCode: response.statusCode, data: parseResult, errorMessage: null);
    } else {
      logger.severe("Unable to load bank detils via IFSC, $response");
      return ResponseModel(errorCode: response.statusCode, errorMessage: "Unable to find bank", data: null);
    }
  }

  /// Method to parse the bank result json from server
  List<BankData> _parseResult(String responseBody) {
    List<BankData> bankList = List();
    try {
      final List<Map<String, dynamic>> productListData = List.from(json.decode(responseBody));
      if (productListData != null && productListData.isNotEmpty) {
        productListData.forEach((bankMap) {
          var address = bankMap["ADDRESS"].toString();
          var index = address.indexOf(RegExp("\\?"));
          if (index > 0) {
            address = address.substring(0, index);
          }
          var bankBranch = bankMap["BRANCH"].toString();
          int branchIndex = bankBranch.indexOf(RegExp("\\?"));
          if (branchIndex > 0) {
            bankBranch = bankBranch.substring(0, branchIndex);
          }
          BankData bankData = BankData(
              ifsc: bankMap["IFSC"],
              bank: bankMap["BANK"],
              state: bankMap["STATE"],
              city: bankMap["CITY"],
              branch: bankBranch,
              address: address,
              contact: bankMap["CONTACT"],
              district: bankMap["DISTRICT"],
              rtgs: bankMap["RTGS"]);

          bankList.add(bankData);
        });
      }
    } catch (e) {
      logger.severe(e);
    }

    return bankList;
  }
}
