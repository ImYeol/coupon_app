import 'package:coupon_app/authentication/repository/AuthenticationRepository.dart';
import 'package:coupon_app/authentication/repository/CouponItemsRepository.dart';
import 'package:coupon_app/bloc/coupon_bloc/CouponState.dart';
import 'package:coupon_app/bloc/login_bloc/LoginState.dart';
import 'package:coupon_app/model/Coupon.dart';
import 'package:coupon_app/model/Coupon.dart';
import 'package:coupon_app/model/Email.dart';
import 'package:coupon_app/model/Password.dart';
import 'package:coupon_app/model/UserInfo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class CouponCubit extends Cubit<CouponState> {
  CouponCubit(this._couponItemsRepository, this._authenticationRepository)
      : assert(_couponItemsRepository != null),
        assert(_authenticationRepository != null),
        super(const CouponItemsLoading());

  final CouponItemsRepository _couponItemsRepository;
  final AuthenticationRepository _authenticationRepository;

  void loadCoupons() {
    Coupon myCoupon;
    Coupon releasableCoupon;
    try {
      myCoupon = _couponItemsRepository.loadMyCoupons();
      releasableCoupon = _couponItemsRepository.loadReleasableCoupons();
    } on Exception {
      print("load releaseable coupon error");
    }
    emit(CouponItemsLoaded(myCoupon, releasableCoupon));
  }

  // void loadReleasableCoupons() {
  //   Coupon coupon;
  //   try {
  //     coupon = _couponItemsRepository.loadReleasableCoupons();
  //   } on Exception {
  //     print("load releaseable coupon error");
  //   }
  //   emit(ReleaseableCouponItemsLoaded(coupon));
  // }

  // void loadMyCoupons() {
  //   Coupon coupon;
  //   try {
  //     coupon = _couponItemsRepository.loadMyCoupons();
  //   } on Exception {
  //     print("load releaseable coupon error");
  //   }
  //   emit(MyCouponItemsLoaded(coupon));
  // }

  Coupon getReleaseableCoupons() {
    return _couponItemsRepository.getReleasableCoupons();
  }

  Coupon getMyCoupons() {
    return _couponItemsRepository.getMyCoupons();
  }

  void useCoupon(CouponItem item) {
    emit(CouponItemsLoading());
    try {
      _couponItemsRepository.useCoupon(item);
    } on Exception {
      print("useCoupon error");
    }
    loadCoupons();
    // notify to server
  }

  void receiveCoupon(CouponItem item) {
    emit(CouponItemsLoading());
    try {
      _couponItemsRepository.receiveCoupon(item);
    } on Exception {
      print("useCoupon error");
    }
    loadCoupons();
    // notify to server
  }

  void buildCoupon(CouponItem item) {
    try {
      _couponItemsRepository.releaseCoupon(item, UserInfo.empty);
    } on Exception {
      print("useCoupon error");
    }
    loadCoupons();
    //emit(CouponItemBuild());
  }

  void releaseCoupon(CouponItem item, UserInfo targetUser) {
    emit(CouponItemsLoading());
    try {
      _couponItemsRepository.releaseCoupon(item, targetUser);
    } on Exception {
      print("useCoupon error");
    }
    loadCoupons();
    // emit(MyCouponItemsLoaded(_couponItemsRepository.getMyCoupons()));
    // emit(ReleaseableCouponItemsLoaded(
    //     _couponItemsRepository.getReleasableCoupons()));
    //post item to server with userinfo
  }
  // Future<void> loadAllCouponItems() async {
  //   if (state is CouponItemsLoading) return;
  //   emit(CouponItemsLoading());
  //   try {
  //     await _authenticationRepository.logInWithEmailAndPassword(
  //       email: state.email.value,
  //       password: state.password.value,
  //     );
  //     emit(state.copyWith(status: FormzStatus.submissionSuccess));
  //   } on Exception {
  //     emit(state.copyWith(status: FormzStatus.submissionFailure));
  //   }
  // }

  // Future<void> logInWithGoogle() async {
  //   emit(state.copyWith(status: FormzStatus.submissionInProgress));
  //   try {
  //     await _authenticationRepository.logInWithGoogle();
  //     emit(state.copyWith(status: FormzStatus.submissionSuccess));
  //   } on Exception {
  //     emit(state.copyWith(status: FormzStatus.submissionFailure));
  //   } on NoSuchMethodError {
  //     emit(state.copyWith(status: FormzStatus.pure));
  //   }
  // }
}
