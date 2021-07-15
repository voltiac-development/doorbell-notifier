import 'dart:math';

import 'package:doorbell/views/dashboard.dart';
import 'package:doorbell/views/startup.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => RegisterScreen();
}

class RegisterScreen extends State<RegisterPage> {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
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
              height: 45,
            ),
            RegisterForm(),
            SizedBox(
              height: 55,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    buildContext,
                    EnterExitRoute(
                        exitPage: this.widget, enterPage: Dashboard()));
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

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            child: Theme(
              data: ThemeData(),
              child: TextField(
                // style: TextStyle(
                //   color: Colors.black,
                //   decorationColor: Colors.black,
                // ),
                textAlign: TextAlign.center,
                cursorColor: Theme.of(context).colorScheme.secondary,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 35,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[600]),
                  focusedBorder: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(90.0),
                    ),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2.0,
                    ),
                  ),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(90.0),
                    ),
                  ),
                ),
              ),
            )),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            child: Theme(
              data: ThemeData(),
              child: TextField(
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                // style: TextStyle(
                //   color: Colors.black,
                //   decorationColor: Colors.black,
                // ),
                textAlign: TextAlign.center,
                cursorColor: Theme.of(context).colorScheme.secondary,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(
                    Icons.vpn_key_sharp,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 30,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[600]),
                  focusedBorder: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(90.0),
                    ),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2.0,
                    ),
                  ),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(90.0),
                    ),
                  ),
                ),
              ),
            )),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            child: Theme(
              data: ThemeData(),
              child: TextField(
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                // style: TextStyle(
                //   color: Colors.black,
                //   decorationColor: Colors.black,
                // ),
                textAlign: TextAlign.center,
                cursorColor: Theme.of(context).colorScheme.secondary,
                decoration: InputDecoration(
                  hintText: 'Confirm password',
                  prefixIcon: Icon(
                    Icons.vpn_key_sharp,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 30,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[600]),
                  focusedBorder: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(90.0),
                    ),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2.0,
                    ),
                  ),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(90.0),
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
