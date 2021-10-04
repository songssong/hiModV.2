import 'package:flutter/material.dart';

class Activity extends StatefulWidget {
  Activity({Key key}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Activity",
                style: TextStyle(color: Colors.white),
              ),
              flexibleSpace: Container(
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [
                      const Color(0xffff9e23),
                      const Color(0xffff711b),
                      const Color(0xffff4814),
                    ],
                  ),
                ),
              ),
            )));
  }
}
