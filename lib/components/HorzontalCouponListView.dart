import 'dart:io';

import 'package:coupon_app/model/Coupon.dart';
import 'package:coupon_app/pages/CouponDescriptionPage.dart';
import 'package:flutter/material.dart';

class HorizontalCouponListView extends StatelessWidget {
  final List<dynamic> coupons;
  final double width;
  final double height;
  final Color bottomColor;
  final Function onTap;

  const HorizontalCouponListView(
      {Key key,
      this.coupons,
      this.width = double.infinity,
      @required this.height,
      this.bottomColor,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      width: double.infinity,
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: coupons.length,
        itemBuilder: (ctx, index) {
          return InkWell(
            child: HorizontalCouponListViewItem(
                couponItem: coupons[index], height: height),
            onTap: //() => onTap(ctx, index),
                () {
              print("item selected");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CouponDescriptionPage(
                            couponItem: coupons[index],
                          )));
            },
          );
        },
      ),
    );
  }
}

class HorizontalCouponListViewItem extends StatelessWidget {
  final CouponItem couponItem;
  final double width;
  final double height;
  const HorizontalCouponListViewItem(
      {Key key, this.couponItem, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 5.0),
        child: Card(
          elevation: 10.0,
          color: Colors.grey[800],
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: height * 2 / 3,
                child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Hero(
                      tag: couponItem.image + couponItem.type.toString(),
                      child: couponItem.image.substring(0, 7) == "images/"
                          ? Image.asset(couponItem.image,
                              //package: product.assetPackage,
                              fit: BoxFit.fill)
                          : Image.file(
                              File(couponItem.image),
                              fit: BoxFit.fill,
                            ),
                    )),
              ),
              Expanded(
                  child: Center(
                child: Text(
                  couponItem.name,
                  style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
              ))
            ],
          ),
        ));
  }
}
