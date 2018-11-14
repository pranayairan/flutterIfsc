import 'package:flutter/material.dart';

class VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 50.0,
      width: 1.0,
      color: Theme.of(context).dividerColor,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}
