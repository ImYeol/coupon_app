import 'package:flutter/material.dart';

class AvailableCouponsPage extends StatefulWidget {
  AvailableCouponsPage({Key key}) : super(key: key);

  @override
  _AvailableCouponsPageState createState() => _AvailableCouponsPageState();
}

class _AvailableCouponsPageState extends State<AvailableCouponsPage> {
  BuildContext _context;
  double _screenHeight;
  double _screenWidth;
  final String _title = "Available Coupon";

  @override
  Widget build(BuildContext context) {
    _context = context;
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
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
    ));
  }
}
