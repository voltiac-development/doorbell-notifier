import 'dart:ui';

import 'package:doorbell/transitions/EnterExitRoute.dart';
import 'package:doorbell/views/connect.dart';
import 'package:doorbell/views/device.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                "Devices",
                style: TextStyle(fontSize: 20),
              ),
              padding: EdgeInsets.only(top: 30, left: 25),
            ),
            Container(
                padding:
                    EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 10),
                height: 250,
                child: new ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: 10,
                    // itemExtent: 10.0,
                    // reverse: true, //makes the list appear in descending order
                    itemBuilder: (BuildContext listContext, int index) {
                      return _buildItems(listContext, index, context);
                    })),
            Padding(
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        EnterExitRoute(
                            exitPage: context.widget,
                            enterPage: ConnectionPage()));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_circle,
                        color: Theme.of(context).colorScheme.primaryVariant,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "Add device",
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.primaryVariant),
                        ),
                      )
                    ],
                  )),
              padding: EdgeInsets.only(left: 25, right: 25),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildItems(
    BuildContext ListContext, int index, BuildContext PageContext) {
  return new Container(
    width: 125,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
    margin: EdgeInsets.only(left: 20, right: 20),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        clipBehavior: Clip.hardEdge,
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  ListContext,
                  EnterExitRoute(
                      enterPage: DeviceScreen(),
                      exitPage: PageContext.widget,
                      routeSettings: RouteSettings(
                          name: "Front door " + index.toString())));
            },
            style: ElevatedButton.styleFrom(
                primary: Theme.of(PageContext).colorScheme.secondary,
                padding: EdgeInsets.all(0)),
            child: Column(
              children: [
                Container(
                  color: Colors.red,
                  height: 20,
                  margin: EdgeInsets.only(bottom: 10),
                ),
                Text(
                  "Front door",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Group #1",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.amber,
                    size: 38,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 45),
                  child: Text(
                    "Doorbell Version: v0.0.1",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(255, 255, 255, 0.5)),
                  ),
                )
              ],
            ))),
  );
}
