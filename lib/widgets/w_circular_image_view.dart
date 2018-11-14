import 'dart:math';

import 'package:flutter/material.dart';

class CircularImageView extends StatelessWidget {
  final String text;

  CircularImageView(this.text);

  final List colors = [
    Color(0xffe57373),
    Color(0xfff06292),
    Color(0xffba68c8),
    Color(0xff9575cd),
    Color(0xff7986cb),
    Color(0xff64b5f6),
    Color(0xff4fc3f7),
    Color(0xff4dd0e1),
    Color(0xff4db6ac),
    Color(0xff81c784),
    Color(0xffaed581),
    Color(0xffff8a65),
    Color(0xffd4e157),
    Color(0xffffd54f),
    Color(0xffffb74d),
    Color(0xffa1887f),
    Color(0xff90a4ae)
  ];

  final Random random = new Random();

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        Container(
          width: 60.0,
          height: 60.0,
          decoration: new BoxDecoration(
            color: colors[random.nextInt(colors.length)],
            shape: BoxShape.circle,
          ),
        ),
        Container(
          alignment: Alignment(0.0, 0.0),
          width: 60.0,
          height: 60.0,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 28.0),
          ),
        )
      ],
    );
  }
}
