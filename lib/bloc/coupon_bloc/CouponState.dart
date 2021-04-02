import 'package:coupon_app/model/Coupon.dart';
import 'package:equatable/equatable.dart';

abstract class CouponState {
  const CouponState();
}

class CouponItemsLoading extends CouponState {
  const CouponItemsLoading();
}

class CouponItemsLoaded extends CouponState {
  final Coupon myCoupon;
  final Coupon releasableCoupon;

  const CouponItemsLoaded(this.myCoupon, this.releasableCoupon);
}

class CouponItemBuild extends CouponState {
  const CouponItemBuild();
}

// class MyCouponItemsLoading extends CouponState {
//   const MyCouponItemsLoading();
// }

// class MyCouponItemsLoaded extends CouponState {
//   final Coupon coupon;
//   const MyCouponItemsLoaded(this.coupon);
// }

// class ReleaseableCouponItemsLoading extends CouponState {
//   const ReleaseableCouponItemsLoading();
// }

// class ReleaseableCouponItemsLoaded extends CouponState {
//   final Coupon coupon;
//   const ReleaseableCouponItemsLoaded(this.coupon);
// }
