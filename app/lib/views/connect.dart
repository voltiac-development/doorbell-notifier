import 'dart:io';
import 'dart:async';

import 'package:doorbell/components/Bullet.dart';
import 'package:doorbell/transitions/EnterExitRoute.dart';
import 'package:doorbell/transitions/ExitEnterRoute.dart';
import 'package:doorbell/views/connect_select_wifi.dart';
import 'package:doorbell/views/startup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:open_settings/open_settings.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dashboard.dart';

class ConnectionPage extends StatefulWidget {
  @override
  State<ConnectionPage> createState() => ConnectionScreen();
}

class ConnectionScreen extends State<ConnectionPage> {
  final NetworkInfo _networkInfo = NetworkInfo();

  @override
  void initState() {
    super.initState();
  }

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
              padding: EdgeInsets.only(left: 10, top: 5),
            ),
            Padding(
                padding: EdgeInsets.only(left: 40, right: 40, top: 40),
                child: Column(
                  children: [
                    Text(
                      "To setup your doorbell",
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 30, right: 30),
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(41),
                        color: Theme.of(context).colorScheme.secondaryVariant,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 12),
                            child: Bullet(
                              "Go to Wi-Fi Settings",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            child: Bullet(
                              "Connect to 'Doorbell Setup'",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 20),
                            child: Bullet(
                              "Continue the setup",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                onPressed: () {
                                  OpenSettings.openWIFISetting();
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Text(
                                    "Open Wi-Fi settings",
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context)
                                      .colorScheme
                                      .primaryVariant,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(41)),
                                )))),
                    Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: SizedBox(
                            child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: SizedBox(
                                width: 140,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        ExitEnterRoute(
                                            exitPage: this.widget,
                                            enterPage: Dashboard()));
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        Theme.of(context).colorScheme.secondary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(41)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: 140,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _continue();
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      "Continue",
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        Theme.of(context).colorScheme.secondary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(41)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )))
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future<void> _getPermissions() async {
    if (Platform.isAndroid) {
      print('Checking Android permissions');
      var status = await Permission.location.status;
      // Blocked?
      if (status.isDenied || status.isRestricted) {
        // Ask the user to unblock
        if (await Permission.location.request().isGranted) {
          // Either the permission was already granted before or the user just granted it.
          print('Location permission granted');
        } else {
          print('Location permission not granted');
        }
      } else {
        print('Permission already granted (previous execution?)');
      }
    }
  }

  Future<void> _continue() async {
    await _getPermissions();

    String? wifiName;

    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
        } else {}
      } else {
        wifiName = await _networkInfo.getWifiName();
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }

    print(wifiName);

    // if (wifiName == 'Doorbell Setup') {
    Navigator.push(
        context,
        EnterExitRoute(
            exitPage: this.widget, enterPage: ConnectionSelectWifi()));
    // }
  }
}
