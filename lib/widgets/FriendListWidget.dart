import 'package:flutter/material.dart';

class FriendListWidget extends StatefulWidget {
  // This widget is the root of your application.
  FriendListWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FriendListWidgetState createState() => _FriendListWidgetState();
}

class _FriendListWidgetState extends State<FriendListWidget> {
  double _screenHeight;
  double _screenWidth;

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return Container(
        width: _screenWidth / 4,
        height: _screenWidth / 4,
        child: Column(
          children: <Widget>[],
        ));
  }
}
