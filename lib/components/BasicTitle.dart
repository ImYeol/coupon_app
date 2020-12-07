import 'dart:ffi';

import 'package:flutter/material.dart';

class BasicTitle extends StatelessWidget {
  final String text;
  final double fontSize;
  final Widget trailing;
  const BasicTitle({Key key, this.text, this.fontSize = 18.0, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
              fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing != null ? trailing : Text("")
      ],
    );
  }
}
