import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:himod/login.dart';
import 'package:himod/post.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:himod/util/color.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

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
          gradient: LinearGradient(colors: [
        const Color(0xffff9e23),
        const Color(0xffff711b),
        const Color(0xffff4814)
      ], end: Alignment.bottomCenter, begin: Alignment.topCenter)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Let's Get Started",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Text(
            "Get your board in KMUTT",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
                color: Colors.grey.shade300),
          ),
          Image.asset("images/logologin.png"),
          Container(
            child: SignInButton(
                buttonType: ButtonType.google,
                onPressed: () async {
                  EasyLoading.show(status: 'loading...');
                  await AuthProviderService.instance.signIn();
                  EasyLoading.dismiss();
                  //เมื่อ login ครั้งแรกเสร็จแล้วให้ส่งไปที่หน้า Post
                  Navigator.pushReplacementNamed(context, '/homepage');
                }),
          ),
        ],
      ),
    ));
  }
}
