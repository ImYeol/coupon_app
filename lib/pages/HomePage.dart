import 'package:coupon_app/authentication/repository/AuthenticationRepository.dart';
import 'package:coupon_app/authentication/repository/CouponItemsRepository.dart';
import 'package:coupon_app/bloc/coupon_bloc/CouponCubit.dart';
import 'package:coupon_app/bloc/coupon_bloc/CouponState.dart';
import 'package:coupon_app/components/BasicTitle.dart';
import 'package:coupon_app/components/FlatBottomButton.dart';
import 'package:coupon_app/components/HorzontalCouponListView.dart';
import 'package:coupon_app/model/Coupon.dart';
import 'package:coupon_app/model/UserInfo.dart';
import 'package:coupon_app/pages/CouponBuildPage.dart';
import 'package:coupon_app/pages/CouponDescriptionPage.dart';
import 'package:coupon_app/pages/QRScanPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

//https://medium.com/flutterdevs/firebase-storage-in-flutter-1f06742472b1
class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  final UserInfo userInfo;
  final CouponItemsRepository couponItemsRepository;

  const HomePage({Key key, this.couponItemsRepository, this.userInfo})
      : super(key: key);

  static Route route(
      CouponItemsRepository couponItemsRepository, UserInfo userInfo) {
    return MaterialPageRoute<void>(
        builder: (_) => HomePage(
            couponItemsRepository: couponItemsRepository, userInfo: userInfo));
  }

  @override
  Widget build(BuildContext context) {
    print("HomePage build");
    return RepositoryProvider.value(
      value: couponItemsRepository,
      child: BlocProvider(
        create: (_) => CouponCubit(
            couponItemsRepository, context.read<AuthenticationRepository>())
          ..loadCoupons(),
        child: HomePageView(
          userInfo: userInfo,
        ),
      ),
    );
  }
}

class HomePageView extends StatelessWidget {
  final UserInfo userInfo;

  //CouponImages repository = CouponImages();

  const HomePageView({Key key, this.userInfo});

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    print("HomePageView build");
    //context.watch<CouponCubit>().loadCoupons();
    return BlocListener<CouponCubit, CouponState>(
        listener: (context, state) {
          if (state is CouponItemsLoadFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Server is not available')),
              );
          }
          print("bloc listener called");
        },
        child: Scaffold(
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
                        child: getProfileInfo(
                            _screenWidth - 200.0, _screenHeight / 3 - 50),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      //coupon list area (my coupon, releaseable coupon list)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: BasicTitle(text: "My Coupons"),
                      ),
                      //getHorizontalCouponListView(),
                      getMyCouponListView(context),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
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
                                buildCouponItem(context)
                                    .then((CouponItem item) {
                                  context.read<CouponCubit>().buildCoupon(item);
                                });
                              }),
                        ),
                      ),
                      getReleasableListView(context),
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
                })));
  }

  Future<CouponItem> buildCouponItem(BuildContext context) async {
    CouponItem item = await Navigator.push(
        context, CouponbuildPage.route(context.read<CouponItemsRepository>()));
    return item;
  }

  Widget getMyCouponListView(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<CouponCubit, CouponState>(
        //buildWhen: (previous, current) => current is CouponItemsLoaded,
        builder: (context, state) {
      if (state is CouponItemsLoading) {
        return CircularProgressIndicator();
      } else if (state is CouponItemsLoaded) {
        print("getMyCouponListView CouponItemsLoaded");
        Coupon coupon = state.myCoupon;
        if (coupon == null || coupon.couponItems.length == 0) {
          return Text(
            "Empty",
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        }
      }
      return Center(
          child: Text(
        "load failed",
        style: TextStyle(
            fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ));
    });
  }

  Widget getReleasableListView(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<CouponCubit, CouponState>(
        //buildWhen: (previous, current) => current is CouponItemsLoaded,
        builder: (context, state) {
      if (state is CouponItemsLoading) {
        return CircularProgressIndicator();
      } else if (state is CouponItemsLoaded) {
        Coupon coupon = state.releasableCoupon;
        if (coupon == null || coupon.couponItems.length == 0) {
          return Text(
            "Empty",
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        } else {
          print("getReleasableListView CouponItemsLoaded " +
              coupon.couponItems.length.toString());
          return HorizontalCouponListView(
            height: _screenHeight / 5,
            bottomColor: Colors.grey[850],
            coupons: coupon.couponItems,
            onTap: () => (ctx, index) {
              print("item selected");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => CouponDescriptionPage(
                            couponItem: coupon.couponItems[index],
                          )));
            },
          );
        }
      }
      return Center(
          child: Text(
        "load failed",
        style: TextStyle(
            fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ));
    });
  }

  Widget getProfileInfo(double width, double height) {
    return Container(
      height: height,
      width: width,
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
            userInfo.email == null ? "null" : "${userInfo.email}",
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
            "3 point",
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
