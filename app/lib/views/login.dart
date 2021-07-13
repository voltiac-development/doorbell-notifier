import 'dart:math';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => LoginScreen();
}

class LoginScreen extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Center(
            child: Icon(Icons.wifi),
          ),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: max(250, MediaQuery.of(context).size.width * 0.50),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'E-mail',
                      icon: Icon(Icons.mail_outline),
                      contentPadding: EdgeInsets.all(8),
                      isDense: true),
                )),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context).colorScheme.background),
                child: Text('go to conn'),
                onPressed: () => Navigator.of(context).pushNamed('addDevice'))
          ],
        )));
  }
}
