import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'route_handlers.dart';

class Routes {
  static String root = "/";
  static String balanceCheck = "/balanceCheck";
  static String balanceCheckDetail = "/balanceCheckDetail";
  static String customerCare = "/customerCare";
  static String searchBank = "/search";
  static String bankDetails = "/bankDetails";
  static String currencyConverter = "/currencyConverter";
  static String compoundInterest = "/compoundInterest";
  static String emi = "/emi";
  static String findAtm = "/findAtm";
  static String findBranch = "/findBranch";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: rootHandler);
    router.define(balanceCheck, handler: bankBalanceCheckPageRouteHandler);
    router.define(customerCare, handler: bankCustomerCareRouteHandler);
    router.define(searchBank, handler: searchBankRouteHandler);
    router.define(bankDetails, handler: bankDetailsRouteHandler);
    router.define(currencyConverter, handler: currencyConverterRouteHandler);
    router.define(compoundInterest, handler: compoundInterestRouteHandler);
    router.define(emi, handler: emiRouteHandler);
    router.define(findAtm, handler: atmRouteHandler);
    router.define(findBranch, handler: branchRouteHandler);
    router.define(balanceCheckDetail, handler: bankBalanceDetailPageRouteHandler);
  }
}
