import 'package:doorbell/views/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartupPage extends StatefulWidget {
  @override
  State<StartupPage> createState() => StartupScreen();
}

class StartupScreen extends State<StartupPage> {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
        backgroundColor: Theme.of(buildContext).colorScheme.background,
        body: SafeArea(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: MediaQuery.of(buildContext).size.width * 0.6,
              image: AssetImage("assets/images/logo.png"),
            ),
            Text(
              "Doorbell",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 150,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    buildContext,
                    EnterExitRoute(
                        exitPage: this.widget, enterPage: LoginPage()));
              },
              child: SizedBox(
                child: Padding(
                  child: Center(
                      child: Text(
                    "Login",
                    style: TextStyle(fontSize: 21),
                  )),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                ),
                width: MediaQuery.of(buildContext).size.width * 0.6,
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(41)),
                  primary: Theme.of(buildContext).colorScheme.secondary),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    buildContext,
                    EnterExitRoute(
                        exitPage: this.widget, enterPage: LoginPage()));
              },
              child: SizedBox(
                child: Padding(
                  child: Center(
                      child: Text(
                    "Register",
                    style: TextStyle(fontSize: 21),
                  )),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                ),
                width: MediaQuery.of(buildContext).size.width * 0.6,
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(41)),
                  primary: Theme.of(buildContext).colorScheme.secondary),
            )
          ],
        ))));
  }
}

class EnterExitRoute extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;
  final RouteSettings? routeSettings;
  EnterExitRoute(
      {required this.exitPage, required this.enterPage, this.routeSettings})
      : super(
            transitionDuration: Duration(milliseconds: 250),
            reverseTransitionDuration: Duration(milliseconds: 250),
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                enterPage,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                Stack(
                  children: <Widget>[
                    SlideTransition(
                      position: new Tween<Offset>(
                        begin: const Offset(0.0, 0.0),
                        end: const Offset(-1.0, 0.0),
                      )
                          .chain(CurveTween(curve: Curves.ease))
                          .animate(animation),
                      child: exitPage,
                    ),
                    SlideTransition(
                      position: new Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      )
                          .chain(CurveTween(curve: Curves.ease))
                          .animate(animation),
                      child: enterPage,
                    )
                  ],
                ),
            settings: routeSettings);
}
