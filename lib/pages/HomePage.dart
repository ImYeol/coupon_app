import 'package:coupon_app/components/BasicTitle.dart';
import 'package:coupon_app/components/FlatBottomButton.dart';
import 'package:coupon_app/components/HorzontalCouponListView.dart';
import 'package:coupon_app/constants/CouponImages.dart';
import 'package:coupon_app/pages/CouponDescriptionPage.dart';
import 'package:coupon_app/pages/QRScanPage.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends StatefulWidget {
  // This widget is the root of your application.
  final String userId;
  final String title;

  HomePage({Key key, this.title, this.userId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _screenHeight;
  double _screenWidth;
  BuildContext _context;
  int _couponPoint;

  CouponImages repository = CouponImages();

  @override
  Widget build(BuildContext context) {
    _context = context;
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    _couponPoint = 0;
    return Scaffold(
        //appBar: buildAppBar(),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // profile area (qr code, id)
                  Container(
                    height: _screenHeight / 3,
                    decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[850],
                              offset: Offset(0.0, 0.5),
                              blurRadius: 2.0)
                        ]),
                    child: getProfileInfo(),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //coupon list area (my coupon, releaseable coupon list)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: BasicTitle(text: "My Coupons"),
                  ),
                  //getHorizontalCouponListView(),
                  HorizontalCouponListView(
                    height: _screenHeight / 5,
                    bottomColor: Colors.grey[850],
                    coupons: repository.images,
                    onTap: () => (ctx, index) {
                      print("item selected");
                      Navigator.push(
                          ctx,
                          MaterialPageRoute(
                              builder: (ctx) => CouponDescriptionPage(
                                    coupon: repository.images[index],
                                  )));
                    },
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: BasicTitle(
                        text: "Releasable Coupons",
                        trailing: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Color(0xFFE0E0E0),
                            size: 25.0,
                          ),
                          onPressed: () {
                            print("My coupons button clicked");
                            // go to store page
                          },
                        )),
                  ),
                  HorizontalCouponListView(
                    height: _screenHeight / 5,
                    bottomColor: Colors.grey[850],
                    coupons: repository.release_images,
                    onTap: () => (ctx, index) {
                      print("item selected");
                      Navigator.push(
                          ctx,
                          MaterialPageRoute(
                              builder: (ctx) => CouponDescriptionPage(
                                    coupon: repository.release_images[index],
                                  )));
                    },
                  ),
                ],
              ),
            )),
        bottomNavigationBar: FlatBottomButton(
            width: _screenWidth,
            height: 60,
            text: "SCAN",
            onPressed: () {
              print("FlatBottomButton pressed");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QRScanPage()));
            }));
  }

  void itemSelected(BuildContext context, int index) {
    print("item selected");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CouponDescriptionPage(
                  coupon: repository.images[index],
                )));
  }

  Widget getProfileInfo() {
    return Container(
      height: _screenHeight / 3 - 50,
      width: _screenWidth - 200.0,
      margin: EdgeInsets.symmetric(horizontal: 100.0, vertical: 25.0),
      // margin: EdgeInsets.symmetric(
      //     horizontal: _screenWidth / 6, vertical: _screenHeight / 10),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey[800],
          boxShadow: [
            BoxShadow(
              color: Colors.grey[900],
              blurRadius: 6.0,
              offset: Offset(0.0, 1.0),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QrImage(
            data: 'This is a simple QR code',
            version: QrVersions.auto,
            size: 100,
            gapless: false,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "${widget.userId}",
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "$_couponPoint point",
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
