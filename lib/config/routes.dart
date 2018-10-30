import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'route_handlers.dart';

class Routes {
  static String root = "/";
  static String searchBank = "/search";
  static String bankDetails = "/bankDetails";
  static String demoFunc = "/demo/func";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: rootHandler);
    router.define(searchBank, handler: searchBankRouteHandler);
    router.define(bankDetails, handler: bankDetailsRouteHandler);
  }
}
