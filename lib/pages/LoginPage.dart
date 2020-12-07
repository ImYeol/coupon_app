import 'package:coupon_app/components/CouponLogo.dart';
import 'package:coupon_app/pages/HomePage.dart';
import 'package:flutter/material.dart';

//https://bloclibrary.dev/#/flutterfirebaselogintutorial
//https://github.com/bizz84/starter_architecture_flutter_firebase
//https://medium.com/@SebastianEngel/easy-push-notifications-with-flutter-and-firebase-cloud-messaging-d96084f5954f
//https://flutterawesome.com/smart-course-app-built-in-flutter/
class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idTextInputController = TextEditingController();
  TextEditingController pwTextInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CouponLogo(width: 200.0, height: 150.0),
            SizedBox(
              height: 30.0,
            ),
            getInputWidget(false, "ID", idTextInputController),
            SizedBox(
              height: 10.0,
            ),
            getInputWidget(false, "PW", pwTextInputController),
            SizedBox(
              height: 30.0,
            ),
            //getGoogleSignInButton()
            getSimpleLoginButton(context)
          ],
        ),
      ),
    );
  }

  Widget getInputWidget(
      bool audofocus, String Tag, TextEditingController textController) {
    return Container(
      width: 300.0,
      height: 50.0,
      child: Expanded(
        child: TextField(
            textAlign: TextAlign.start,
            controller: textController,
            autofocus: audofocus,
            style: TextStyle(fontSize: 20, color: Colors.white),
            decoration: InputDecoration(
                hintText: Tag,
                hintStyle: TextStyle(fontSize: 20, color: Colors.white30),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)))),
      ),
    );
  }

  Widget getSimpleLoginButton(BuildContext context) {
    return Container(
      width: 300.0,
      height: 60.0,
      child: FlatButton(
          color: Theme.of(context).primaryColor,
          splashColor: Colors.grey,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => HomePage(
                          userId: idTextInputController.text,
                        )));
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          // highlightElevation: 0,
          // borderSide: BorderSide(color: Colors.grey),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'ENTER',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          )),
    );
  }

  Widget getGoogleSignInButton() {
    return FlatButton(
      color: Colors.white,
      splashColor: Colors.grey,
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      // highlightElevation: 0,
      // borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("images/google_logo.jpg"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
