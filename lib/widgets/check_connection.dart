import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CheckConnection extends StatefulWidget {
  @override
  State createState() {
    return _CheckConnection();
  }
}

class _CheckConnection extends State {
  StreamSubscription internetconnection;
  bool isoffline = false;
  //set variable for Connectivity subscription listiner

  @override
  void initState() {
    internetconnection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }
    });

    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    internetconnection.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (isoffline) {
      return Container(
        padding: EdgeInsets.all(10.00),
        margin: EdgeInsets.only(bottom: 10.00),
        color: Colors.red,
        child: Row(children: [
          Container(
            margin: EdgeInsets.only(right: 6.00),
            child: Icon(Icons.info, color: Colors.white),
          ),
          Text(
            "No internet",
            style: TextStyle(color: Colors.white),
          ),
        ]),
      );
    } else {
      return Container();
    }
  }
}
