import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({Key key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _title = "Profile";
  double _screenHeight;
  double _screenWidth;
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
        title: _title,
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(_title),
                floating: true,
                flexibleSpace: Placeholder(),
                expandedHeight: _screenHeight / 3,
                backgroundColor: Colors.black54,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_context, index) => ListTile(title: Text('Item #$index')),
                  childCount: 10,
                ),
              )
            ],
          ),
          // coupon release button
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: RaisedButton(
              color: Colors.cyanAccent,
              onPressed: () {},
              child: Text(
                "Release",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
        ));
  }
}
