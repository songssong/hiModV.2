import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:himod/component/body.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:himod/viewpost_post.dart';
import 'package:intl/intl.dart';

class Noti extends StatefulWidget {
  @override
  _NotiState createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  @override
  void initState() {
    super.initState();
    // readDataPost();
    // print(data_post);

    ///
    // FirebaseMessaging.instance.getInitialMessage().then((message) {
    //   if (message != null) {
    //     final routeFromMessage = message.data["route"];
    //     Navigator.of(context).pushNamed(routeFromMessage);
    //     // print(routeFromMessage);
    //   }
    // });

    //forground work
    // FirebaseMessaging.onMessage.listen((message) {
    //   if (message.notification != null) {
    //     print(message.notification.body);
    //     print(message.notification.title);
    //   }
    // });

    ///ทำงานเมื่อแอปทำงานพื้นหลังแต่เปิดเมื่อผู้ใช้กดที่การแจ้งเตือน
    ///ส่งหน้าเมื่อผู้ใช้กดที่การแจ้งเตือนเพื่อนส่งไปยังหน้าอื่น
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   final routeFromMessage = message.data["route"];
    //   Navigator.of(context).pushNamed(routeFromMessage);
    //   // print(routeFromMessage);
    // });
  }

  CollectionReference notificationref =
      FirebaseFirestore.instance.collection('Notification');
  CollectionReference postref = FirebaseFirestore.instance.collection('Post');

  // var uid = AuthProviderService.instance.user?.uid??"";
  String postid;
  bool _hasBeenPressed = true;

  // dynamic data_post;
  // Future<Null> readDataPost() async {
  //   await notificationref.where('uid', isNotEqualTo: uid).get().then((value) {
  //     setState(() {
  //       data_post = value;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Notification",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Mitr',
              fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                const Color(0xffff9e23),
                const Color(0xffff711b),
                const Color(0xffff4814),
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: notificationref
              .where('postauthoruid',
                  isEqualTo: AuthProviderService.instance.user.uid)
              .where('uid', isNotEqualTo: AuthProviderService.instance.user.uid)
              // .orderBy('postauthoruid')
              .orderBy('uid')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Object>> snapshotnoti) {
            if (snapshotnoti.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshotnoti.hasError) {
              return new Text('Error: ${snapshotnoti.hasError}');
            }
            // print('uidGu--------------------------------');
            // print(AuthProviderService.instance.user.uid);
            return ListView(
              shrinkWrap: true,
              children: snapshotnoti.data.docs.map((DocumentSnapshot docnoti) {
                Timestamp t = docnoti['timestamp'];
                DateTime d = DateTime.fromMicrosecondsSinceEpoch(
                    t.microsecondsSinceEpoch);
                String formatDate = DateFormat('yyyy-MM-dd – kk:mm').format(d);
                return InkWell(
                  child: Card(
                    color: _hasBeenPressed ? Colors.white : Colors.grey,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('images/Noti.png'),
                          ),
                          title: Text(docnoti['posttitlename']) ?? "",
                          subtitle: Text(
                              "${docnoti['student']} Comment on your post"),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    // print(docnoti['postdocumentid']);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ViewPost(
                          postid: docnoti['postid'],
                          postdocumentid: docnoti['postdocumentid'],
                          uid: AuthProviderService.instance.user.uid,
                        );
                      }),
                    );
                    _hasBeenPressed = !_hasBeenPressed;
                  },
                );
              }).toList(),
            );
          }),
    );
  }
}
