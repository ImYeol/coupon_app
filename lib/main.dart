import 'package:coupon_app/authentication/bloc/AuthenticationBloc.dart';
import 'package:coupon_app/authentication/bloc/AuthenticationState.dart';
import 'package:coupon_app/authentication/repository/CouponItemsRepository.dart';
import 'package:coupon_app/bloc/BasicBlocObserver.dart';
import 'package:coupon_app/pages/LogInPage.dart';
import 'package:coupon_app/authentication/repository/AuthenticationRepository.dart';
import 'package:coupon_app/pages/SplashPage.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = BasicBlocObserver();
  runApp(MyApp(
    authenticationRepository: AuthenticationRepository(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AuthenticationRepository authenticationRepository;

  const MyApp({Key key, @required this.authenticationRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.grey,
        primaryColor: Colors.grey[800],
        accentColor: Colors.brown,
        backgroundColor: Colors.brown[900],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(CouponItemsRepository(), state.user),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      //The SplashPage is shown while the application determines the authentication state of the user
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
