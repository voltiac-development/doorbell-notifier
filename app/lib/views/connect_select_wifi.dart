import 'package:doorbell/components/HeroDialogRoute.dart';
import 'package:doorbell/transitions/ExitEnterRoute.dart';
import 'package:doorbell/transitions/Morph.dart';
import 'package:doorbell/views/connect.dart';
import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

class ConnectionSelectWifi extends StatefulWidget {
  @override
  State<ConnectionSelectWifi> createState() => _ConnectionSelectWifi();
}

class _ConnectionSelectWifi extends State<ConnectionSelectWifi> {
  late List<WifiNetwork> networks = [];

  _ConnectionSelectWifi() {
    test();
  }

  Future<void> test() async {
    this.networks = await WiFiForIoTPlugin.loadWifiList();

    if (this.mounted) {
      setState(() {});
    }
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
                    "Select the correct WiFi network",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                      clipBehavior: Clip.hardEdge,
                      margin: EdgeInsets.only(top: 50),
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(41),
                        color: Theme.of(context).colorScheme.secondaryVariant,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...this.networks.map((e) => Hero(
                                  tag: "BONK",
                                  child: GestureDetector(
                                    onTap: () {
                                      print(e.ssid);
                                      // Send API call to doorbell with network name.

                                      Navigator.of(context).push(HeroDialogRoute(
                                          builder: (context) => Center(
                                                child: AskPass(),
                                              )));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                          child: Row(
                                            children: [
                                              Icon(Icons.wifi),
                                              Padding(padding: EdgeInsets.only(left: 15)),
                                              Text(e.ssid ?? "No network name found"),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1,
                                          height: 2,
                                          color: Theme.of(context).colorScheme.primaryVariant,
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, ExitEnterRoute(exitPage: this.widget, enterPage: ConnectionPage()));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          "Previous",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(41)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AskPass extends StatelessWidget {
  const AskPass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'BONK',
      createRectTween: (begin, end) {
        return Morph(begin: begin!, end: end!);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.secondary,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("REEE")],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
