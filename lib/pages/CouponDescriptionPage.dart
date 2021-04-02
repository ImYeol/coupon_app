import 'dart:ui';

import 'package:coupon_app/components/FlatBottomButton.dart';
import 'package:coupon_app/model/Coupon.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'QRScanPage.dart';

class CouponDescriptionPage extends StatelessWidget {
  final CouponItem couponItem;
  final int couponCount;
  const CouponDescriptionPage({Key key, this.couponItem, this.couponCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
            child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: height * 3 / 5,
              stretch: true,
              collapsedHeight: kToolbarHeight + 1,
              floating: true,
              pinned: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle
                ],
                background: getBackground(width, height),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) => Card(
                      color: Theme.of(context).primaryColor,
                      child: ListTile(
                        autofocus: false,
                        leading: IconButton(
                          icon: Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          onPressed: null,
                        ),
                        title: Text("Released",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text("11:14 12/07 2020",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    )),
              ),
            )
          ],
        )),
        bottomNavigationBar: getBottomButtons(context));
  }

  Widget getBackground(double width, double height) {
    return Container(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            getCouponImage(width, height / 3),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [getCouponDescription(width, height), getQRCode()],
                ))
          ],
        ));
  }

  Widget getCouponDescription(double width, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: width - 150,
            child: Text(couponItem.name,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0))),
        SizedBox(
          height: 15.0,
        ),
        Text("1 EA / 3 Point",
            style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w900,
                fontSize: 12.0)),
        SizedBox(
          height: 15.0,
        ),
        Container(
            width: width - 150,
            child: Text(couponItem.description,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0))),
      ],
    );
  }

  Widget getCouponImage(double width, double height) {
    return Hero(
        tag: couponItem.image + couponItem.type.toString(),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(couponItem.image), fit: BoxFit.fill),
          ),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
              child: Container(color: Colors.black.withOpacity(0.1))),
        ));
  }

  Widget getQRCode() {
    return Center(
      child: QrImage(
        data: couponItem.name,
        version: QrVersions.auto,
        size: 100,
        gapless: false,
      ),
    );
  }

  Widget getBottomButtons(BuildContext context) {
    return FlatBottomButton(
      width: MediaQuery.of(context).size.width,
      text: "Release",
      onPressed: () {
        print("Release button pressed");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QRScanPage()));
      },
    );
  }
}
