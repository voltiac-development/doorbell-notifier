import 'package:flutter/material.dart';

class DeviceScreen extends StatefulWidget {
  DeviceScreen({Key? key}) : super(key: key);

  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  @override
  Widget build(BuildContext context) {
    final String name = ModalRoute.of(context)!.settings.name as String;
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
                name,
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
