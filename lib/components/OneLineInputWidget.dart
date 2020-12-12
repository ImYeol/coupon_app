import 'dart:math';

import 'package:flutter/material.dart';

class OneLineInputWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hint;
  final double width;
  final double height;
  final double fontSize;
  final int maxLength;
  const OneLineInputWidget(
      {Key key,
      this.textEditingController,
      this.hint,
      this.width,
      this.height,
      this.fontSize = 20,
      this.maxLength = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Expanded(
        child: TextField(
            textAlign: TextAlign.start,
            controller: textEditingController,
            autofocus: false,
            style: TextStyle(fontSize: fontSize, color: Colors.white),
            maxLines: 1,
            maxLength: maxLength,
            buildCounter: (context, {currentLength, isFocused, maxLength}) {
              return Text(
                "$currentLength / $maxLength",
                style: TextStyle(fontSize: 12, color: Colors.white),
              );
            },
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(fontSize: fontSize, color: Colors.white30),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)))),
      ),
    );
  }
}
