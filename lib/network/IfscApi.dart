import 'dart:async';
import 'dart:convert';

import 'package:bank_ifsc_flutter/config/application.dart';
import 'package:bank_ifsc_flutter/network/model/bank_care_data.dart';
import 'package:bank_ifsc_flutter/network/model/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_logger/http_logger.dart';
import 'package:http_middleware/http_middleware.dart';
import 'package:logging/logging.dart';

import 'model/bank_data.dart';

class IfscAPI {
  String _baseIFSCUrl = "https://apps.dexterapps.in/BankIFSCLocator";

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

  /// Method to get customer care info
  Future<ResponseModel<List<BankCareData>>> getCustomerCareInfo() async {
    String url = "$_baseIFSCUrl/bank_info.json";

    if (Application.bankCareData != null && Application.bankCareData.isNotEmpty) {
      return ResponseModel(errorCode: 200, data: Application.bankCareData, errorMessage: null);
    } else {
      http.Response response = await httpClient.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<BankCareData> data = _parseCareResult(response.body);
        Application.bankCareData = data;
        return ResponseModel(errorCode: response.statusCode, data: data, errorMessage: null);
      } else {
        logger.severe("Unable to load customer care info, $response");
        return ResponseModel(errorCode: response.statusCode, errorMessage: "load customer care info", data: null);
      }
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

  /// Method to parse the bank care result json from server
  List<BankCareData> _parseCareResult(String responseBody) {
    List<BankCareData> bankList = List();
    try {
      final Map<String, dynamic> data = json.decode(responseBody);
      final List<Map<String, dynamic>> bankCareData = List.from(data["bank"]);

      if (bankCareData != null && bankCareData.isNotEmpty) {
        bankCareData.forEach((bankMap) {
          BankCareData bankData = BankCareData(
              bankName: bankMap["bank_name"],
              bankBalanceNum: bankMap["bank_balance_num"],
              miniStatementNum: bankMap["mini_state_num"],
              customerCareNum: bankMap["customer_num"],
              officialWebsite: bankMap["official_website"],
              personalWebsite: bankMap["personal_website"],
              ussdNum: bankMap["ussd_num"],
              shortName: bankMap["short_name"],
              mini: bankMap["mini"],
              inquiry: bankMap["inquiry"]);

          bankList.add(bankData);
        });
      }
    } catch (e) {
      logger.severe(e);
    }

    return bankList;
  }
}
