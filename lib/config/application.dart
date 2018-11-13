import 'package:bank_ifsc_flutter/network/model/bank_care_data.dart';
import 'package:fluro/fluro.dart';
import 'package:logging/logging.dart';

/// Class holding static reference of common data across the app.
/// this is used for sharing state between screens.
class Application {
  // static reference of routes
  static Router router;

  static List<BankCareData> bankCareData;

  static bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true); // asserts does not work in prod so this boolean will always be false.
    return inDebugMode;
  }

  static initLogging() {
    Logger.root.level = isInDebugMode ? Level.ALL : Level.OFF;

    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });
  }
}
