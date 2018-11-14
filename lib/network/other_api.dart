import 'dart:async';
import 'dart:convert';

import 'package:bank_ifsc_flutter/config/application.dart';
import 'package:bank_ifsc_flutter/network/model/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_logger/http_logger.dart';
import 'package:http_middleware/http_middleware.dart';
import 'package:logging/logging.dart';

class OtherAPI {
  String _currencyURL = "https://api.exchangeratesapi.io";

  final Logger logger = Logger("OtherAPI");

  HttpWithMiddleware httpClient = HttpWithMiddleware.build(
      middlewares:
          Application.isInDebugMode ? [HttpLogger(logLevel: LogLevel.BODY)] : [HttpLogger(logLevel: LogLevel.NONE)]);

  final Map<String, String> headers = {"Accept": "application/json", "Content-Type": "multipart/form-data"};

  /// Method to get currency exchange rate
  Future<ResponseModel<double>> getRates({String fromCurrency, String toCurrency}) async {
    String url = "$_currencyURL/latest?symbols=$toCurrency&base=$fromCurrency";

    http.Response response = await httpClient.get(url, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> exchangeData = json.decode(response.body);
      var exchangeData2 = exchangeData["rates"][toCurrency];
      return ResponseModel(errorCode: response.statusCode, data: exchangeData2, errorMessage: null);
    } else {
      logger.severe("Unable to load exchange rates, $response");
      return ResponseModel(errorCode: response.statusCode, errorMessage: "load exchange rates", data: null);
    }
  }
}
