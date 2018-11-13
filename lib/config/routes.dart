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
    RouteHandler routeHandler = RouteHandler();
    router.notFoundHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: routeHandler.rootHandler);
    router.define(balanceCheck, handler: routeHandler.bankBalanceCheckPageRouteHandler);
    router.define(customerCare, handler: routeHandler.bankCustomerCareRouteHandler);
    router.define(searchBank, handler: routeHandler.searchBankRouteHandler);
    router.define(bankDetails, handler: routeHandler.bankDetailsRouteHandler);
    router.define(currencyConverter, handler: routeHandler.currencyConverterRouteHandler);
    router.define(compoundInterest, handler: routeHandler.compoundInterestRouteHandler);
    router.define(emi, handler: routeHandler.emiRouteHandler);
    router.define(findAtm, handler: routeHandler.atmRouteHandler);
    router.define(findBranch, handler: routeHandler.branchRouteHandler);
    router.define(balanceCheckDetail, handler: routeHandler.bankBalanceDetailPageRouteHandler);
  }
}
