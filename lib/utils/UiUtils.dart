import 'package:flutter/material.dart';

import 'styles.dart';

class UiUtils {
  static TextStyle getTextStyleForHeaders() {
    return TextStyle(fontSize: Font_Size_Page_title);
  }

  static TextStyle getTextStyleForSubHeaders() {
    return TextStyle(fontSize: 18.0);
  }

  static TextStyle getTextStyleForListHeaders(bool isBold) {
    return isBold
        ? TextStyle(fontSize: Font_Size_List_Items, fontWeight: FontWeight.bold)
        : TextStyle(fontSize: Font_Size_List_Items);
  }

  static TextStyle getTextStyleForListHeadersSecondary() {
    return TextStyle(fontSize: Font_Size_List_Items, color: Colors.redAccent, fontWeight: FontWeight.bold);
  }

  static TextStyle getTextStyleForListSubTitle({bool isBold = false}) {
    return isBold
        ? TextStyle(fontSize: Font_Size_List_Title, fontWeight: FontWeight.bold)
        : TextStyle(fontSize: Font_Size_List_Title);
  }

  static TextStyle getSmallTextStyleForListSubTitle() {
    return TextStyle(fontSize: 15.0);
  }

  static TextStyle getTextStyleForSecondaryText() {
    return TextStyle(fontSize: 15.0, color: Colors.black54);
  }
}

//const double Font_Size_Page_title = 22.0;
//const double Font_Size_Paragraph = 16.0;
//const double Font_Size_List_Title = 16.0; // medium weight ie bold
//const double Font_Size_List_Items = 18.0;
//const double Font_Size_Secondary_Text = 16.0; // lighter weight using secondary color
//const double Font_Size_Buttons = 16.0; // medium weight
//const double Font_Size_Text_Input = 18.0;
