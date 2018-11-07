import 'package:bank_ifsc_flutter/network/model/bank_data.dart';
import 'package:bank_ifsc_flutter/pages/bank_detail_page.dart';
import 'package:bank_ifsc_flutter/pages/currency_converter_page.dart';
import 'package:bank_ifsc_flutter/pages/home_page.dart';
import 'package:bank_ifsc_flutter/pages/search_bank_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:bank_ifsc_flutter/pages/compound_interest_page.dart';
import 'package:bank_ifsc_flutter/pages/emi_converter_page.dart';

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

var currencyConverterRouteHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new CurrencyConverterPage();
});

var compoundInterestRouteHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new CompoundInterestPage();
});

var emiRouteHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new EmiConverterPage();
});
