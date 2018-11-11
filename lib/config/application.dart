import 'package:bank_ifsc_flutter/network/model/bank_care_data.dart';
import 'package:fluro/fluro.dart';
import 'package:logging/logging.dart';

class Application {
  // static reference of routes
  static Router router;

  static List<BankCareData> bankCareData;

  static bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  static initLogging() {
    Logger.root.level = isInDebugMode ? Level.ALL : Level.OFF;

    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });
  }
}
