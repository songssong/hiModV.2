import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:himod/activity.dart';
import 'package:himod/comment.dart';
import 'package:himod/component/body.dart';
import 'package:himod/loadapp.dart';
import 'package:himod/login.dart';
import 'package:himod/post.dart';
import 'package:himod/postdetail.dart';


void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'himod',
      theme: ThemeData(
          primaryColor: Colors.white, scaffoldBackgroundColor: Colors.white),
      initialRoute: '/comment',
      routes: {
        '/post': (context) => Post(),
        '/activity': (context) => Activity(),
        '/loginload': (context) => Loginload(),
        '/comment' : (context) => Comment(),
      },
      builder: EasyLoading.init(),
    );

  }
}