import 'package:flutter/material.dart';

import 'styles.dart';

class UiUtils {
  static TextStyle getTextStyleForListHeadersSecondary(BuildContext context) {
    return TextStyle(fontSize: Font_Size_List_Items, color: Colors.redAccent, fontWeight: FontWeight.bold);
  }

  static TextStyle getTextStyleForSecondaryText() {
    return TextStyle(fontSize: 16.0, color: Colors.black54);
  }
}

//const double Font_Size_Page_title = 22.0;
//const double Font_Size_Paragraph = 16.0;
//const double Font_Size_List_Title = 16.0; // medium weight ie bold
//const double Font_Size_List_Items = 18.0;
//const double Font_Size_Secondary_Text = 16.0; // lighter weight using secondary color
//const double Font_Size_Buttons = 16.0; // medium weight
//const double Font_Size_Text_Input = 18.0;
