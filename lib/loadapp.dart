import 'dart:async';

import 'package:flutter/material.dart';
import 'package:himod/signup.dart';
import 'package:himod/util/color.dart';

class Loginload extends StatefulWidget {
  @override
  _LoginloadState createState() => _LoginloadState();
}

class _LoginloadState extends State<Loginload> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 3000), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient
          (colors: [orange, orangelight],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter
          )
          ),
            child: Center(
              child: Image.asset('images/logonew.png',height: 325,)
              ,
          ),
    )
    );
  }
}