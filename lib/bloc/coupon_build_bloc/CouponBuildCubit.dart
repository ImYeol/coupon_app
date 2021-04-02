import 'package:coupon_app/authentication/repository/CouponItemsRepository.dart';
import 'package:coupon_app/bloc/coupon_bloc/CouponState.dart';
import 'package:coupon_app/model/Coupon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CouponBuildCubit extends Cubit<CouponState> {
  CouponBuildCubit(this._couponItemsRepository)
      : assert(_couponItemsRepository != null),
        super(const CouponItemsLoading());

  final CouponItemsRepository _couponItemsRepository;

  void buildCoupon(CouponItem item) {
    try {
      _couponItemsRepository.buildCouponItem(item);
    } on Exception {
      print("load releaseable coupon error");
    }
    emit(CouponItemsLoaded(_couponItemsRepository.getMyCoupons(),
        _couponItemsRepository.getReleasableCoupons()));
  }
}
