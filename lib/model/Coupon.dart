import 'package:equatable/equatable.dart';

enum CouponType { none, myCoupon, releaseableCoupon }

class Coupon {
  final List<CouponItem> items;

  const Coupon({this.items});

  List<CouponItem> get couponItems => items;
}

class CouponItem extends Equatable {
  String image;
  String name;
  String description;
  int type;
  int count;

  static final int RELEASEABLE_COUPON = 0;
  static final int MY_COUPON = 1;

  CouponItem(
      {this.image,
      this.name,
      this.description = " ",
      this.type = 0,
      this.count = 0});

  @override
  String toString() {
    // TODO: implement toString
    return this.image +
        " " +
        this.name +
        " " +
        this.description +
        " " +
        this.count.toString();
  }

  void addCouponItem(int count) {
    this.count += count;
  }

  @override
  // TODO: implement props
  List<Object> get props => [image, name, description];
}
