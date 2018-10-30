import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetUtils {
  static const String BING_API_KEY = "AtKnRPNgYC80Vdn1YW_R15un7J80MNG0V-UoXEbhrvs0wo8B-HS4ivy6GPt6AUUD";

  static void showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  //TODO change to prod key
  static Widget getMapsImageWidget(String address) {
    if (address != null && address.isNotEmpty) {
      Uri _staticMapUri = Uri.https("dev.virtualearth.net", "/REST/V1/Imagery/Map/Road/$address",
          {"mapSize": "500,300", "format": "png", "zoomLevel": "10", "key": BING_API_KEY});

      return GestureDetector(
        onTap: () {
          _launchMapURL(address);
        },
        child: Image.network(_staticMapUri.toString()),
      );
    }

    return Container();
  }

  static _launchMapURL(String address) async {
    Uri googleMapUrl = Uri.https("google.com", "/maps/search/", {"api": "1", "query": "$address"});
    String url = googleMapUrl.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
