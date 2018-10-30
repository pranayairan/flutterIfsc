import 'package:bank_ifsc_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class FancyTextField extends StatefulWidget {
  final String hintText;
  final String fancyImage;
  final Function onTap;
  final TextEditingController textEditingController;

  FancyTextField(this.textEditingController, this.hintText, this.fancyImage, [this.onTap]);

  @override
  State<StatefulWidget> createState() {
    return _FancyTextFieldState();
  }
}

class _FancyTextFieldState extends State<FancyTextField> {
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
          child: _getWrappedTextField(),
        ),
      ],
    );
  }

  Widget _getWrappedTextField() {
    if (widget.onTap == null) {
      return _getTextField();
    } else {
      return GestureDetector(
        child: _getTextField(),
        onTap: widget.onTap,
      );
    }
  }

  Widget _getTextField() {
    return new TextField(
      controller: widget.textEditingController,
      decoration: new InputDecoration(
        hintText: widget.hintText,
        border: InputBorder.none,
      ),
      key: widget.key,
      style: TextStyle(
        color: Colors.white,
        fontSize: Font_Size_Text_Input,
      ),
    );
  }
}
