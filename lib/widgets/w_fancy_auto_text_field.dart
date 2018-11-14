import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:bank_ifsc_flutter/misc/styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FancyAutoCompleteTextField extends StatefulWidget {
  final List<String> suggestions;
  final String hintText;
  final String fancyImage;

  String textValue;

  FancyAutoCompleteTextField(this.suggestions, this.hintText, this.fancyImage);

  @override
  State<StatefulWidget> createState() {
    return _FancyAutoCompleteTextFieldState();
  }
}

class _FancyAutoCompleteTextFieldState extends State<FancyAutoCompleteTextField> {
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Image(
          image: AssetImage(widget.fancyImage),
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
          child: _getTextField(),
        ),
      ],
    );
  }

  Widget _getTextField() {
    return new AutoCompleteTextField<String>(
        decoration: new InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Color(0xFF696969),
          ),
        ),
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSizeTextInput,
        ),
        submitOnSuggestionTap: true,
        clearOnSubmit: false,
        suggestions: widget.suggestions,
        textChanged: (item) {
          currentText = item;
        },
        textSubmitted: (item) {
          setState(() {
            currentText = item;
            widget.textValue = item;
            currentText = "";
          });
        },
        itemBuilder: (context, item) {
          return new Padding(
              padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 12.0, bottom: 12.0),
              child: new Text(
                item,
                style: TextStyle(
                  fontSize: fontSizeListTitle,
                ),
              ));
        },
        itemSorter: (a, b) {
          return a.compareTo(b);
        },
        itemFilter: (item, query) {
          return item.toLowerCase().startsWith(query.toLowerCase());
        });
  }
}
