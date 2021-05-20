import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:himod/Profile/profile_screen.dart';
import 'package:himod/activity.dart';
import 'package:himod/comment.dart';
import 'package:himod/component/body.dart';
import 'package:himod/loadapp.dart';
import 'package:himod/login.dart';
import 'package:himod/post.dart';
import 'package:himod/postdetail.dart';
import 'package:himod/service/service_locator.dart';
import 'package:himod/signup.dart';

import 'Profile/component/profile_pic.dart';


String initialRoute = '/loginload';

Future<Null> main() async {
  //เช็คการเข้าถึงว่า อุปกรณ์นี้เคยมีการ login ไว้แล้วไหม ถ้ามีการ login ไว้แล้วจะส่งไปที่หน้า post ทันที แต่ถ้าไม่จะใช้ค่าเดิมของ initialRoute
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) { 
      if (event != null) {
        initialRoute='/post';
      }
      runApp(MyApp());
    });
  });
  setupLocator();
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.white, scaffoldBackgroundColor: Colors.white),
      // onGenerateRoute: (settings) {
      //   switch (settings.name) {
      //     case 'loginload':
      //       return MaterialPageRoute(builder: (context) => Loginload());
      //     case 'post':
      //     default:
      //       return MaterialPageRoute(builder: (context) => Post());
      //   }
      // },
      initialRoute: initialRoute,
      routes: {
        '/post': (context) => Post(),
        '/activity': (context) => Activity(),
        '/loginload': (context) => Loginload(),
        '/postdetail': (context) => Postdetail(),
        '/signup': (context) => Signup(),
        '/profile': (context) => ProfileScreen(),
        '/profilepic': (context) => ProfilePic(),
        '/comment': (context) => Comment(),
      },
      builder: EasyLoading.init(),
    );
  }
}