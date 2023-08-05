import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class CheckConnection extends StatefulWidget {
  const CheckConnection({super.key});

  @override
  State createState() {
    return _CheckConnection();
  }
}

class _CheckConnection extends State {
  late StreamSubscription internetconnection;
  bool isoffline = false;

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
        padding: const EdgeInsets.all(10.00),
        margin: const EdgeInsets.only(bottom: 10.00),
        color: Colors.red,
        child: Row(children: [
          Container(
            margin: const EdgeInsets.only(right: 6.00),
            child: const Icon(Icons.info, color: Colors.white),
          ),
          const Text(
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
