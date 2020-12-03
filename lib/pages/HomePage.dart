import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:coupon_app/constants/CouponImages.dart';
import 'package:coupon_app/pages/CouponDescriptionPage.dart';
import 'package:coupon_app/pages/LoginPage.dart';
import 'package:coupon_app/pages/SearchFriendPage.dart';
import 'package:coupon_app/pages/UserProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  // This widget is the root of your application.
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _screenHeight;
  double _screenWidth;
  BuildContext _context;
  int _couponPoint;

  @override
  Widget build(BuildContext context) {
    _context = context;
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    _couponPoint = 0;

    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: getContents(),
      ),
    );
  }

  Widget getProfileInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildProfileInfo("https://i.imgur.com/iQkzaTO.jpg", "yeol1232435243"),
          buildProfileInfo(null, null)
        ],
      ),
    );
  }

  Widget buildProfileInfo(String imageUrl, String name) {
    return Column(
      children: [
        imageUrl == null
            ? MaterialButton(
                onPressed: () {
                  Navigator.push(
                      _context,
                      MaterialPageRoute(
                          builder: (_context) => SearchFriendPage()));
                },
                color: Colors.black87,
                textColor: Colors.white,
                child: Icon(
                  Icons.person_add,
                  size: 70.0,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              )
            : Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: imageUrl == null
                          ? ExactAssetImage("images/unnamed.png")
                          : CachedNetworkImageProvider(imageUrl),
                    )),
              ),
        SizedBox(
          height: 15.0,
        ),
        name == null
            ? SizedBox(height: 15.0)
            : Center(
                child: Text(
                "$name",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 1.0,
      centerTitle: true,
      backgroundColor: Colors.grey[850],
      title: Text('Couple Coupon'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_alert,
            color: Color(0xFFE0E0E0),
            size: 25.0,
          ),
          onPressed: () {
            Navigator.push(_context,
                MaterialPageRoute(builder: (_context) => LoginPage()));
          },
        ),
      ],
    );
  }

  Widget getCouponPointBox() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: _screenWidth,
        height: 100.0,
        child: Card(
          elevation: 4.0,
          color: Colors.grey[850],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Point",
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                width: 2.0,
                height: 50.0,
                child: Container(
                  color: Colors.white,
                ),
              ),
              Text(
                "$_couponPoint" + "P",
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getCouponPointCardTitle() {
    return Padding(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "My Coupon Point",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ));
  }

  Widget getCouponPointCard() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Card(
            color: Colors.black87,
            elevation: 4.0,
            child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.check_box, size: 30, color: Colors.white),
              ),
              title: Text(
                "$_couponPoint" + "P",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        Expanded(
            child: RaisedButton(
          elevation: 4.0,
          child: Text(
            "Release Coupon",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )),

        // register coupon button
        // FlatButton(
        //   color: Colors.black87,
        //   onPressed: () {},
        //   child: Text("Combination"),
        // ),
      ],
    );
  }

  // Widget getCouponPointCard() {
  //   return Card(
  //     elevation: 4.0,
  //     child: ListTile(
  //       title: Text(
  //         "$_couponPoint",
  //         style: TextStyle(fontSize: 20.0),
  //       ),
  //       subtitle: Text(""),
  //       trailing: IconButton(
  //         icon: Icon(Icons.chevron_right),
  //         onPressed: () {},
  //       ),
  //     ),
  //   );
  // }

  Widget getContents() {
    return Container(
        decoration: BoxDecoration(color: Colors.black87),
        padding: EdgeInsets.all(5),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            // getFriendsTitle(),
            // getFriendItem(),
            getProfileInfo(),
            getCouponPointCardTitle(),
            //getCouponPointCard(),
            getCouponPointBox(),
            // getCouponPointCardTitle(),
            // getCouponPointCard(),
            getAvailableCouponsTitle(),
            getOnDemandCouponList(),
            //getAvailableCouponItem(),
            //getFooter()
          ],
        ));
  }

  Widget getFriendsTitle() {
    return Padding(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Friends",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ));
  }

  Widget getFriendItem() {
    return Container(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircularProfileAvatar(
              null,
              child: Icon(
                Icons.person_add,
                size: 50,
              ),
              initialsText: Text(
                "AD",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              borderColor: Colors.black,
              borderWidth: 3,
              elevation: 5,
              radius: 35,
              onTap: () {
                Navigator.push(
                    _context,
                    MaterialPageRoute(
                        builder: (_context) => UserProfilePage()));
              },
            ),
          ],
        ));
  }

  Widget getAvailableCouponsTitle() {
    return Padding(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "My Coupons",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                color: Color(0xFFE0E0E0),
                size: 25.0,
              ),
              onPressed: () {
                print("My coupons button clicked");
                // go to store page
              },
            )
          ],
        ));
  }

  // Widget getAvailableCouponsList() {
  //   return ListView.builder(
  //     itemBuilder: Listvi
  //   )
  // }
//image: Image.asset(item, fit: BoxFit.cover, width: 1000.0)
  final List<Widget> imageSliders = CouponImages.images
      .map((item) => InkWell(
            onTap: () {
              print("3333");
            },
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Material(
                        child: Ink.image(
                          image: AssetImage(item),
                          fit: BoxFit.fill,
                          child: InkWell(
                            onTap: () {
                              print("aaa");
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("bbb");
                        },
                        child: Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              'coupon',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  Widget getOnDemandCouponList() {
    return Container(
      child: CarouselSlider.builder(
        itemCount: CouponImages.images.length,
        itemBuilder: (ctx, index) {
          return Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Material(
                      child: Ink.image(
                        image: AssetImage(CouponImages.images[index]),
                        fit: BoxFit.fill,
                        child: InkWell(
                          onTap: () {
                            print("aaa");
                            Navigator.push(
                                _context,
                                MaterialPageRoute(
                                    builder: (_context) =>
                                        CouponDescriptionPage()));
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print("bbb");
                      },
                      child: Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'coupon',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          );
        },
        options: CarouselOptions(
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          autoPlay: false,
        ),
      ),
    );
  }

  Widget getAvailableCouponItem() {
    // return Container(
    //   margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
    //   child: Expanded(
    //     child: CarouselSlider(
    //       options: CarouselOptions(
    //         aspectRatio: 1.0,
    //         enlargeCenterPage: true,
    //         scrollDirection: Axis.horizontal,
    //         autoPlay: false,
    //       ),
    //       items: imageSliders,
    //     ),
    //   ),
    // );
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        autoPlay: false,
      ),
      items: imageSliders,
    );
  }
}
