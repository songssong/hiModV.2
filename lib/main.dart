import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:himod/LostAndFound/lostandfound_screen.dart';
import 'package:himod/Profile/profile_screen.dart';
import 'package:himod/Activity/activity_screen.dart';
import 'package:himod/Activity/activity_detail.dart';
import 'package:himod/homepage.dart';
import 'package:himod/loadapp.dart';
import 'package:himod/lostnfounddetail.dart';
import 'package:himod/post.dart';
import 'package:himod/postdetail.dart';
import 'package:himod/providers/comment_provider.dart';
import 'package:himod/signup.dart';
import 'package:provider/provider.dart';

String initialRoute = '/loginload';

Future<Null> main() async {
  //เช็คการเข้าถึงว่า อุปกรณ์นี้เคยมีการ login ไว้แล้วไหม ถ้ามีการ login ไว้แล้วจะส่งไปที่หน้า post ทันที แต่ถ้าไม่จะใช้ค่าเดิมของ initialRoute
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        initialRoute = '/homepage';
      }
      runApp(MyApp());
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CommentProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.white, scaffoldBackgroundColor: Colors.white),
        initialRoute: initialRoute,
        routes: {
          '/loginload': (context) => Loginload(),
          '/post': (context) => Post(),
          '/profile': (context) => ProfileScreen(),
          '/activity': (context) => Activity(),
          '/postdetail': (context) => Postdetail(),
          '/signup': (context) => Signup(),
          '/lostnfound': (context) => LostAndFoundScreen(),
          '/lostnfounddetail': (context) => lostnfounddetail(),
          '/homepage': (context) => HomePage(),
          '/activitydetail': (context) => Activitydetail(),
        },
        builder: EasyLoading.init(),
      ),
    );
  }
}
