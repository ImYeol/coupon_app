import 'package:flutter/material.dart';

class CouponLogo extends StatelessWidget {
  final double width;
  final double height;

  const CouponLogo({Key key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("images/coupon_icon.png"),
          )),
    );
  }
}
