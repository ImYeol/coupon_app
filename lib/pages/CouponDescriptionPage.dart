import 'package:coupon_app/model/Coupon.dart';
import 'package:flutter/material.dart';

class CouponDescriptionPage extends StatelessWidget {
  final Coupon coupon;
  final int couponCount;
  const CouponDescriptionPage({Key key, this.coupon, this.couponCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: getAppBar(context),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(color: Colors.black87),
            child: Column(
              children: [
                getCouponImage(context),
                Expanded(
                    child: ListView(
                  children: [
                    getCouponTitle(),
                    getMyCapability(),
                    getCouponDescriptionTitle(),
                    getCouponDescription(),
                  ],
                ))
              ],
            ),
          ),
        ),
        bottomNavigationBar: getBottomButtons());
  }

  Widget getAppBar(BuildContext context) {
    return AppBar(
        elevation: 1.0,
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        title: Text('Coupon Details'),
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

  Widget getCouponImage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(1.0)),
      width: double.infinity,
      height: MediaQuery.of(context).size.width / 1.5,
      child: Hero(
        tag: "tag",
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/big_out_of_trap.PNG"),
                fit: BoxFit.fitWidth),
          ),
        ),
      ),
    );
  }

  Widget getCustomScrollView(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // sliver app bar
        SliverAppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          expandedHeight: MediaQuery.of(context).size.width,
          forceElevated: false,
          floating: false,
          pinned: true,
          backgroundColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
              title: Text("aaaaa"),
              background: Container(
                decoration: BoxDecoration(color: Colors.transparent),
              )),
        ),
        // sliver widget childs
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[getCouponTitle()]),
        ),
      ],
    );
  }

  Widget getCouponTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Text(
        "Big out of trap coupon",
        style: TextStyle(
          fontSize: 25.0,
          color: Colors.white,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget getMyCapability() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(children: [
          Text(
            "0 point",
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white70,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            " 0 items",
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white70,
            ),
          ),
        ]));
  }

  Widget getCouponDescriptionTitle() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Text(
          "Description",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ));
  }

  Widget getCouponDescription() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Text(
          "asdfsafadasdddddddddddddd\n safdvad \ndfasdf \nsadf asdfasdf \nsadf asdfsa \ndfsad \nfsadfsda f",
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white70,
          ),
        ));
  }

  Widget getBottomButtons() {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset.zero,
          )
        ]),
        //color: Colors.black54,
        padding: EdgeInsets.only(left: 5, right: 5),
        height: 100,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    "Release",
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    "Use",
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ));
  }

  // Widget buildFooter() {
  //   return Container(
  //       padding: EdgeInsets.all(24),
  //       decoration: BoxDecoration(color: Colors.cyan),
  //       child: Row(
  //         children: [
  //           FlatButton(
  //             onPressed: () {},
  //             child: Text("Combination"),
  //           ),
  //           FlatButton(
  //             onPressed: () {},
  //             child: Text("Use"),
  //           ),
  //         ],
  //       ));
  // }
}
