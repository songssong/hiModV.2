import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:himod/login.dart';
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
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
                color: Colors.grey.shade300),
          ),
          Image.asset("images/logologin.png"),
          Container(
            // child: ClipRRect(
            //   borderRadius: BorderRadius.circular(29),
            //             child: FlatButton(
            //     padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
            //     color: orange,
            //     onPressed: () {
            //       Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
            //     },
            //     child: Text("Sign in by KMUTT account", style: TextStyle(color: Colors.white),)),
            // ),
            child: AuthProviderService.instance.user == null
                ? SignInButton(
                    buttonType: ButtonType.google,
                    onPressed: () async {
                        EasyLoading.show(status: 'loading...');
                      await AuthProviderService.instance.signIn();
                      EasyLoading.dismiss();
                      setState(() {
                      });
                    },
                  )
                : Column(
                    children: [
                      Image.network(AuthProviderService.instance.user.photoURL),
                      Text(AuthProviderService.instance.user.displayName),
                      Text(AuthProviderService.instance.user.email),
                      FlatButton(
                        onPressed: () async {
                          EasyLoading.show(status: 'loading...');
                          await AuthProviderService.instance.signOut();
                          EasyLoading.dismiss();
                          setState(() {});
                        },
                        child: Text("Logout"),
                      )
                    ],
                  ),
          ),
        ],
      ),
    ));
  }
}
