import 'package:doorbell/transitions/EnterExitRoute.dart';
import 'package:doorbell/views/login.dart';
import 'package:doorbell/views/register.dart';
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
              width: MediaQuery.of(buildContext).size.width * 0.75,
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
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                ),
                width: MediaQuery.of(buildContext).size.width * 0.75,
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
                        exitPage: this.widget, enterPage: RegisterPage()));
              },
              child: SizedBox(
                child: Padding(
                  child: Center(
                      child: Text(
                    "Register",
                    style: TextStyle(fontSize: 21),
                  )),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                ),
                width: MediaQuery.of(buildContext).size.width * 0.75,
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
