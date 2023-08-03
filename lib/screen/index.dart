import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  var btncut;
  var statuswifi;
  var position;
  var statuspower;
  dynamic powerlevel;
  late Timer timer;
// ignore: deprecated_member_use
  final dbRef = FirebaseDatabase.instance.reference().child('control');
  final dbRefstatus = FirebaseDatabase.instance.reference().child('status');

  @override
  void initState() {
    setState(() {
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
        getStatus();
        getStatuswifi();
      });
      timer = Timer.periodic(Duration(seconds: 15), (Timer t) {
        createsttatuswifi();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Power Electronic25 - KMUTNB "),
      ),
      body: Container(
        color: Colors.blue[100],
        height: size.height * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 15, top: 10),
                  alignment: Alignment.centerRight,
                  height: size.height * 0.06,
                  width: size.width * 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Connection Status  :",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Icon(
                        Icons.wifi,
                        size: size.height * 0.06,
                        color: statuswifi == 1 ? Colors.green : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 15, top: 10),
                  alignment: Alignment.centerRight,
                  height: size.height * 0.06,
                  width: size.width * 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Power Levels",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.battery_saver_outlined,
                          size: size.height * 0.06,
                          color: powerlevel == 50 ? Colors.red : Colors.green,
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            ":",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 15),
                          child: Container(
                            width: size.width * 0.11,
                            child: Text(
                              '$powerlevel' " %",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    height: size.height * 0.2,
                    width: size.width * 0.33,
                  ),
                  statuspower == 1
                      ? Container(
                          color: Colors.blue[200],
                          alignment: Alignment.center,
                          height: size.height * 0.2,
                          width: size.width * 0.34,
                          child: SizedBox.fromSize(
                            size: Size(100, 100), // button width and height
                            child: Material(
                              color: position == 1
                                  ? Colors.blue[600]
                                  : Colors.blue[300], // button color
                              child: InkWell(
                                splashColor: Colors.green, // splash color

                                onTap: () async {
                                  print('front');
                                  position == 1
                                      ? createData("Position", 0)
                                      : createData("Position", 1);
                                  //createData("Left", 0);
                                  //createData("Right", 0);
                                  //createData("Reverse", 0);
                                }, // button pressed
                                enableFeedback: false,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_upward,
                                      size: size.height * 0.07,
                                    ),
                                    Text(
                                      "Front",
                                      style: TextStyle(
                                          fontSize: size.height * 0.032),
                                    ),
                                    // icon
                                    // text
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : btnfrontfalse(size),
                  Container(
                    alignment: Alignment.centerRight,
                    height: size.height * 0.2,
                    width: size.width * 0.33,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                statuspower == 1
                    ? Container(
                        color: Colors.blue[200],
                        alignment: Alignment.center,
                        height: size.height * 0.2,
                        width: size.width * 0.33,
                        child: SizedBox.fromSize(
                          size: Size(100, 100), // button width and height
                          child: Material(
                            color: position == 4
                                ? Colors.blue[600]
                                : Colors.blue[300], // button color
                            child: InkWell(
                              splashColor: Colors.green, // splash color
                              onTap: () {
                                print('front');
                                position == 4
                                    ? createData("Position", 0)
                                    : createData("Position", 4);
                                //createData("Left", 0);
                                //createData("Right", 0);
                                //createData("Reverse", 0);
                              }, // button pressed
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_back,
                                    size: size.height * 0.05,
                                  ),
                                  Text(
                                    "Left",
                                    style:
                                        TextStyle(fontSize: size.height * 0.03),
                                  ),
                                  // icon
                                  // text
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : btnleftfalse(size),
                Container(
                  alignment: Alignment.center,
                  height: size.height * 0.2,
                  width: size.width * 0.33,
                  child: SizedBox.fromSize(
                    size: Size(100, 100), // button width and height
                    child: Material(
                      color: statuspower == 1
                          ? Colors.green[200]
                          : Colors.grey, // button color
                      child: InkWell(
                        splashColor: Colors.green, // splash color
                        onTap: () {
                          createData("Position", 0);
                          //createData("Left", 0);
                          //createData("Right", 0);
                          //createData("Reverse", 0);
                          //createData("Reverse", 0);
                          createData("cut", 0);
                          statuspower == 1
                              ? createsttatuspower(0)
                              : createsttatuspower(1);
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              statuspower == 1 ? "ON" : "OFF",
                              style: TextStyle(fontSize: size.height * 0.03),
                            ),
                            Icon(
                              Icons.power_settings_new,
                              size: size.height * 0.08,
                              color:
                                  statuspower == 1 ? Colors.green : Colors.red,
                            ),

                            // icon
                            // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                statuspower == 1
                    ? Container(
                        color: Colors.blue[200],
                        alignment: Alignment.center,
                        height: size.height * 0.2,
                        width: size.width * 0.33,
                        child: SizedBox.fromSize(
                          size: Size(100, 100), // button width and height
                          child: Material(
                            color: position == 3
                                ? Colors.blue[600]
                                : Colors.blue[300], // button color
                            child: InkWell(
                              splashColor: Colors.green, // splash color
                              onTap: () {
                                print('Right');
                                position == 3
                                    ? createData("Position", 0)
                                    : createData("Position", 3);
                                //createData("Left", 0);
                                //createData("Right", 1);
                                //createData("Reverse", 0);
                              }, // button pressed
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Right",
                                    style:
                                        TextStyle(fontSize: size.height * 0.03),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: size.height * 0.05,
                                  ),

                                  // icon
                                  // text
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : btnrightfalse(size),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  height: size.height * 0.2,
                  width: size.width * 0.33,
                ),
                statuspower == 1
                    ? Container(
                        color: Colors.blue[200],
                        alignment: Alignment.center,
                        height: size.height * 0.2,
                        width: size.width * 0.34,
                        child: SizedBox.fromSize(
                          size: Size(100, 100), // button width and height
                          child: Material(
                            color: position == 2
                                ? Colors.blue[600]
                                : Colors.blue[300], // button color
                            child: InkWell(
                              splashColor: Colors.green, // splash color
                              onTap: () {
                                print('Reverse');
                                position == 2
                                    ? createData("Position", 0)
                                    : createData("Position", 2);
                                //createData("Left", 0);
                                //createData("Right", 0);
                                //createData("Reverse", 1);
                              }, // button pressed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Reverse",
                                    style: TextStyle(
                                        fontSize: size.height * 0.032),
                                  ),
                                  Icon(
                                    Icons.arrow_downward_rounded,
                                    size: size.height * 0.07,
                                  ),

                                  // icon
                                  // text
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : btnreversefalse(size),
                Container(
                  alignment: Alignment.centerRight,
                  height: size.height * 0.2,
                  width: size.width * 0.33,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'CUT',
            style: TextStyle(fontSize: size.height * 0.035),
          ),
          SizedBox(
            width: size.width * 0.03,
          ),
          statuspower == 1
              ? FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: btncut == 1 ? Colors.green : Colors.red,
                    onPressed: () {
                      btncut == 0 ? createData("cut", 1) : createData("cut", 0);
                    },
                    child: Text(
                      btncut == 1 ? 'ON' : 'OFF',
                      style: TextStyle(fontSize: size.height * 0.03),
                    ),
                  ),
                )
              : btncutfalse(size),
        ],
      ),
    );
  }

  Future<void> createData(position, val) async {
    try {
      await dbRef.update({
        position: val,
      }).then((value) async {
        print('Seccess');
      }).catchError((onError) {
        print(onError.code);
        print(onError.message);
      });
      setState(() {});
    } on FirebaseException catch (error) {
      print(error);
    }
  }

  Future<void> createsttatuswifi() async {
    try {
      await dbRefstatus.update({
        "statuswifi": 0,
      }).then((value) async {
        print('Seccess');
      }).catchError((onError) {
        print(onError.code);
        print(onError.message);
      });
      setState(() {});
    } on FirebaseException catch (error) {
      print(error);
    }
  }

  Future<void> getStatus() async {
    dbRef.once().then((DataSnapshot snapshot) async {
      setState(() {
        btncut = snapshot.value['cut'];
        position = snapshot.value['Position'];
        print(position.toString());
        print(btncut.toString());
      });
    });
  }

  Future<void> getStatuswifi() async {
    dbRefstatus.once().then((DataSnapshot snapshot) async {
      setState(() {
        statuswifi = snapshot.value['statuswifi'];
        statuspower = snapshot.value['statuspower'];
        powerlevel = snapshot.value['powerlevel'];
        powerlevel = double.parse((powerlevel).toStringAs);
        print(btncut.toString());
      });
    });
  }

  Future<void> createsttatuspower(val) async {
    try {
      await dbRefstatus.update({
        "statuspower": val,
      }).then((value) async {
        print('Seccess');
      }).catchError((onError) {
        print(onError.code);
        print(onError.message);
      });
      setState(() {});
    } on FirebaseException catch (error) {
      print(error);
    }
  }

  Widget btnfrontfalse(size) {
    return Container(
      color: Colors.grey[400],
      alignment: Alignment.center,
      height: size.height * 0.2,
      width: size.width * 0.34,
      child: SizedBox.fromSize(
        size: Size(100, 100), // button width and height
        child: Material(
          color: Colors.grey, // button color
          child: InkWell(
            splashColor: Colors.green, // splash color
            enableFeedback: false,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.arrow_upward,
                    size: size.height * 0.07,
                  ),
                  Text(
                    "Front",
                    style: TextStyle(fontSize: size.height * 0.032),
                  ),
                  // icon
                  // text
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget btnleftfalse(size) {
    return Container(
      color: Colors.grey[400],
      alignment: Alignment.center,
      height: size.height * 0.2,
      width: size.width * 0.33,
      child: SizedBox.fromSize(
        size: Size(100, 100), // button width and height
        child: Material(
          color: Colors.grey, // button color
          child: InkWell(
            splashColor: Colors.green, // splash color

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.arrow_back,
                  size: size.height * 0.05,
                ),
                Text(
                  "Left",
                  style: TextStyle(fontSize: size.height * 0.03),
                ),
                // icon
                // text
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget btnrightfalse(size) {
    return Container(
      color: Colors.grey[400],
      alignment: Alignment.center,
      height: size.height * 0.2,
      width: size.width * 0.33,
      child: SizedBox.fromSize(
        size: Size(100, 100), // button width and height
        child: Material(
          color: Colors.grey, // button color
          child: InkWell(
            splashColor: Colors.green, // splash color

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Right",
                  style: TextStyle(fontSize: size.height * 0.03),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: size.height * 0.05,
                ),

                // icon
                // text
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget btnreversefalse(size) {
    return Container(
      color: Colors.grey[400],
      alignment: Alignment.center,
      height: size.height * 0.2,
      width: size.width * 0.34,
      child: SizedBox.fromSize(
        size: Size(100, 100), // button width and height
        child: Material(
          color: Colors.grey, // button color
          child: InkWell(
            splashColor: Colors.green, // splash color

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Reverse",
                  style: TextStyle(fontSize: size.height * 0.032),
                ),
                Icon(
                  Icons.arrow_downward_rounded,
                  size: size.height * 0.07,
                ),

                // icon
                // text
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget btncutfalse(size) {
    return Container(
      height: size.height * 0.15,
      width: size.width * 0.15,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: Colors.grey,
          onPressed: () {},
          child: Text(
            btncut == 1 ? 'ON' : 'OFF',
            style: TextStyle(fontSize: size.height * 0.03),
          ),
        ),
      ),
    );
  }
}
