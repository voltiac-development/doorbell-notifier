import 'package:flutter/material.dart';

class ConnectionPage extends StatefulWidget {
  @override
  State<ConnectionPage> createState() => ConnectionScreen();
}

class ConnectionScreen extends State<ConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                child: Image(
                  width: 150,
                  image: AssetImage("assets/images/logo.png"),
                ),
                padding: EdgeInsets.only(top: 10, left: 10)),
            Padding(
              child: Text(
                "Add device",
                style: TextStyle(fontSize: 20),
              ),
              padding: EdgeInsets.only(top: 30, left: 25),
            ),
          ],
        ),
      ),
    );
  }
}
