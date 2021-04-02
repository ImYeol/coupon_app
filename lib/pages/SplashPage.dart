import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Image.asset(
          'images/coupon_icon.png',
          key: const Key('splash_bloc_image'),
          width: 150,
        ),
      ),
    );
  }
}
