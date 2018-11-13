import 'package:bank_ifsc_flutter/config/application.dart';
import 'package:bank_ifsc_flutter/config/routes.dart';
import 'package:bank_ifsc_flutter/pages/home_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
    Application.initLogging();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Bank IFSC Code Finder',
      theme: new ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        cursorColor: Colors.black54,
      ),
      home: new HomePage(),
      navigatorObservers: <NavigatorObserver>[observer],
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
    );
  }
}
