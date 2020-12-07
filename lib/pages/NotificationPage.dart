import 'package:flutter/material.dart';

// https://pub.dev/packages/flutter_slidable/example
class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: getAppBar(context),
      body: SafeArea(child: Text("aaa")),
    ));
  }

  Widget getAppBar(BuildContext context) {
    return AppBar(
        elevation: 1.0,
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        title: Text('Notifications'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFFE0E0E0),
            size: 25.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
  }
}
