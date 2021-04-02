import 'dart:async';

import 'package:coupon_app/model/Coupon.dart';
import 'package:coupon_app/model/UserInfo.dart';
import 'package:meta/meta.dart';

class CouponItemsLoadFailure implements Exception {}

class CouponItemNotFound implements Exception {}

class CouponItemNotUseable implements Exception {}

class CouponItemsRepository {
  List<CouponItem> releasableCoupons = [
    CouponItem(
        count: 1,
        description: "test1",
        image: "images/big_out_of_trap.PNG",
        name: "big out of trap",
        type: CouponItem.RELEASEABLE_COUPON),
    CouponItem(
        count: 1,
        description: "test2",
        image: "images/small_out_of_trap.PNG",
        name: "small out of trap",
        type: CouponItem.RELEASEABLE_COUPON),
    CouponItem(
        count: 1,
        description: "test3",
        image: "images/great_coupon.jpg",
        name: "great coupon",
        type: CouponItem.RELEASEABLE_COUPON),
  ];

  List<CouponItem> myCoupons = [];

  CouponItemsRepository();

  Coupon loadReleasableCoupons() {
    // load from server
    Coupon coupon = Coupon(items: releasableCoupons);
    return coupon;
  }

  Coupon loadMyCoupons() {
    // load from server
    Coupon coupon = Coupon(items: myCoupons);
    return coupon;
  }

  Coupon getReleasableCoupons() {
    // load from server
    Coupon coupon = Coupon(items: releasableCoupons);
    return coupon;
  }

  Coupon getMyCoupons() {
    // load from server
    Coupon coupon = Coupon(items: myCoupons);
    return coupon;
  }

  void useCoupon(CouponItem item) {
    int index = myCoupons.indexOf(item);
    if (index == -1 || (myCoupons[index].count <= 0)) {
      throw CouponItemNotUseable();
    }
    myCoupons[index].count = --item.count;

    if (myCoupons[index].count == 0) {
      myCoupons.removeAt(index);
    }
    index = releasableCoupons.indexOf(item);
    if (index == -1) {
      item.type = CouponItem.RELEASEABLE_COUPON;
      releasableCoupons.add(item);
    }
    // notify to server
  }

  void receiveCoupon(CouponItem item) {
    int index = myCoupons.indexOf(item);
    if (index == -1) {
      item.count = 1;
      myCoupons.add(item);
      index = releasableCoupons.indexOf(item);
      if (index == -1) {
        item.type = CouponItem.RELEASEABLE_COUPON;
        releasableCoupons.add(item);
      }
    } else {
      myCoupons[index].count += 1;
      index = releasableCoupons.indexOf(item);
    }
    // notify to server
  }

  void releaseCoupon(CouponItem item, UserInfo targetUser) {
    //post item to server with userinfo
    int index = releasableCoupons.indexOf(item);
    if (index == -1) {
      item.type = CouponItem.RELEASEABLE_COUPON;
      releasableCoupons.add(item);
    }
  }

  void buildCouponItem(CouponItem item) {
    releasableCoupons.add(item);
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
  // Future<void> signUp({
  //   @required String email,
  //   @required String password,
  // }) async {
  //   assert(email != null && password != null);
  //   try {
  //     await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //   } on Exception {
  //     throw SignUpFailure();
  //   }
  // }

  // /// Signs in with the provided [email] and [password].
  // ///
  // /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  // Future<void> logInWithEmailAndPassword({
  //   @required String email,
  //   @required String password,
  // }) async {
  //   assert(email != null && password != null);
  //   try {
  //     await _firebaseAuth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //   } on Exception {
  //     throw LogInWithEmailAndPasswordFailure();
  //   }
  // }
}
