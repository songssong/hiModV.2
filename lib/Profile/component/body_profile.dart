import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:himod/service/auth_provider_service.dart';

import 'profile_pic.dart';

class BodyProfile extends StatelessWidget {
  const BodyProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        ProfilePic(),
        //StudentId
        Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(
                    'StudentID',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0.5, 20, 0),
          child: Container(
            height: 50,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AuthProviderService.instance.user.uid,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(20)),
            //     border: Border.all(width: 1.0, color: Colors.black)),
          ),
        ),
        //Student Name
        Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(
                    'Name',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0.5, 20, 0),
          child: Container(
            height: 50,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AuthProviderService.instance.user.displayName.toUpperCase(),
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(20)),
            //     border: Border.all(width: 1.0, color: Colors.black)),
          ),
        ),
        //Faculty
        Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(
                    'Faculty',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0.5, 20, 0),
          child: Container(
            height: 50,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '-',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(20)),
            //     border: Border.all(width: 1.0, color: Colors.black)),
          ),
        ),
        //Email
        Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(
                    'Email',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0.5, 20, 0),
          child: Container(
            height: 50,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AuthProviderService.instance.user.email,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(20)),
            //     border: Border.all(width: 1.0, color: Colors.black)),
          ),
        ),
        Column(
          children: <Widget>[
            FlatButton(
                onPressed: () async {
                  Navigator.pushNamed(context, '/signup');
                  EasyLoading.show(status: 'loading...');
                  await AuthProviderService.instance.signOut();
                  EasyLoading.dismiss();
                  // setState() {}
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.red
                    ),
                )
                ),
          ],
        )
      ],
    );
  }
}
