import 'package:flutter/material.dart';
import 'package:himod/login.dart';
import 'package:himod/util/color.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [orange, orangelight],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Let's Get Started",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Text(
            "Get your board in KMUTT",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18, color: Colors.grey.shade300),
          ),
          Image.asset("images/logologin.png"),
          
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
                        child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                color: orange,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
                }, 
                child: Text("Sign in by KMUTT account", style: TextStyle(color: Colors.white),)),
            ),
          )
        ],
      ),
    ));
  }
}
