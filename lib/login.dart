import 'dart:io';

import 'package:flutter/material.dart';
import 'package:himod/util/color.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}


final _formKeyEmail = GlobalKey<FormState>();
final _formKeyPassword = GlobalKey<FormState>();
final _formKeySubmit = GlobalKey<FormState>();


class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(1.0, 1.0),
            end: Alignment(-1.34, 1.0),
            colors: [
              const Color(0xffff9e23),
              const Color(0xffff711b),
              const Color(0xffff4814)
            ],
            stops: [0.0, 0.427, 1.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.all(35),
              child: Column(
                children: <Widget>[
                  Image.asset("images/logonew.png"),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 350,
                      height: 50,
                      padding: EdgeInsets.only(
                          top: 0, left: 10, right: 10, bottom: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(450)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black, blurRadius: 5)
                          ]),
                      child: Form(
                        key: _formKeyEmail,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[emailTextField()],
                        ),
                      ),
                    ),
                    Container(
                      width: 350,
                      height: 50,
                      margin: EdgeInsets.only(top: 25),
                      padding: EdgeInsets.only(
                          top: 0, left: 10, right: 10, bottom: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black, blurRadius: 5)
                          ]),
                      child: Form(
                        key: _formKeyPassword,
                        child: Column(
                          children: <Widget>[passwordTextField()],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Form(
                        key: _formKeySubmit,
                          child: Column(
                        children: <Widget>[submitLogin()],
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emailTextField() {
    return new Row(
      children: <Widget>[
        SizedBox(height: 50,),
        Flexible(
            child: TextFormField(
              validator: (String input){
                if (input.isEmpty) {
                  return "pls enter email !";
                }
                return null;
              },
          decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.grey), hintText: 'Email'),
        ))
      ],
    );
  }

  Widget passwordTextField() {
    return new Row(
      children: <Widget>[
        SizedBox(height: 50,),
        Flexible(
            child: TextFormField(
              obscureText: true,
              validator: (String input){
                if (input.isEmpty) {
                  return "pls enter password !";
                }
                return null;
              },
          decoration: InputDecoration(
              icon: Icon(Icons.vpn_key, color: Colors.grey),
              hintText: 'Password'),
        ))
      ],
    );
  }

  Widget submitLogin() {
    return RaisedButton(
      color: Colors.orange[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Text(
        'login'.toUpperCase(),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        bool pass =_formKeyEmail.currentState.validate();
        bool pass1 =_formKeyPassword.currentState.validate();
      },
    );
  }
  }
