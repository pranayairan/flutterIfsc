import 'package:bank_ifsc_flutter/network/model/bank_data.dart';
import 'package:bank_ifsc_flutter/pages/bank_detail_page.dart';
import 'package:bank_ifsc_flutter/pages/compound_interest_page.dart';
import 'package:bank_ifsc_flutter/pages/currency_converter_page.dart';
import 'package:bank_ifsc_flutter/pages/emi_converter_page.dart';
import 'package:bank_ifsc_flutter/pages/home_page.dart';
import 'package:bank_ifsc_flutter/pages/search_bank_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:bank_ifsc_flutter/utils/WidgetUtils.dart';
import 'package:bank_ifsc_flutter/pages/bank_customer_care_page.dart';
import 'package:bank_ifsc_flutter/pages/balance_check_list_page.dart';
import 'package:bank_ifsc_flutter/pages/balance_check_detail_page.dart';

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

var bankBalanceCheckPageRouteHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new BankBalanceCheckPage();
});

var bankBalanceDetailPageRouteHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new BankBalanceDetailPage(
    bankName:  params["bankName"]?.first,
    bankBalanceNum:  params["bankBalanceNum"]?.first,
    miniStatementNum:  params["miniStatementNum"]?.first,
    customerCareNum:  params["customerCareNum"]?.first,
    officialWebsite:  params["officialWebsite"]?.first,
    personalWebsite:  params["personalWebsite"]?.first,
  );
});

var bankCustomerCareRouteHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new BankCustomerCarePage();
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

var atmRouteHandler = new Handler(
    type: HandlerType.function,
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      WidgetUtils.launchMapURL("ATM near me");
    });

var branchRouteHandler = new Handler(
    type: HandlerType.function,
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      WidgetUtils.launchMapURL("Bank near me");
    });
