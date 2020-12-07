import 'package:flutter/material.dart';

class FlatBottomButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final Function onPressed;

  const FlatBottomButton(
      {Key key, this.width, this.height = 60, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 0.5, offset: Offset(0.0, -0.5), color: Colors.grey[800])
      ]),
      child: FlatButton(
        color: Colors.grey[700],
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
