import 'package:flutter/material.dart';
import 'package:himod/activity.dart';
import 'package:himod/component/body.dart';
import 'package:himod/loadapp.dart';
import 'package:himod/login.dart';
import 'package:himod/post.dart';
import 'package:himod/postdetail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'himod',
      theme: ThemeData(
          primaryColor: Colors.white, scaffoldBackgroundColor: Colors.white),
      initialRoute: '/Post',
      routes: {
        '/post': (context) => Post(),
        '/activity': (context) => Activity(),
      },
    );
  }
}
