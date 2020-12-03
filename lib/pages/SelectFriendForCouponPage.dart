import 'package:flutter/material.dart';

class SelectFriendForCouponPage extends StatefulWidget {
  SelectFriendForCouponPage({Key key}) : super(key: key);

  @override
  _SelectFriendForCouponPageState createState() =>
      _SelectFriendForCouponPageState();
}

class _SelectFriendForCouponPageState extends State<SelectFriendForCouponPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
    );
  }

  Widget getAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(
          Icons.keyboard_backspace,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        "Choose friend",
      ),
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (BuildContext context){
            //       return Notifications();
            //     },
            //   ),
            // );
          },
        ),
      ],
    );
  }
}
