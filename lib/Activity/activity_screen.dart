import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:himod/Activity/activity_viewonlypost.dart';
import 'package:himod/Widget/_customCardActivity.dart';
import 'package:intl/intl.dart';

class Activity extends StatefulWidget {
  Activity({Key key}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Activity",
          style: TextStyle(color: Colors.white),
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Activity')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: snapshot.data.docs.map((DocumentSnapshot doc) {
                      Timestamp t = doc['timestamp'];
                      DateTime d = DateTime.fromMicrosecondsSinceEpoch(
                          t.microsecondsSinceEpoch);
                      String formatDate =
                          DateFormat('yyyy-MM-dd – kk:mm').format(d);
                      return CustomActivity(
                        onClick: () => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ViewActivity(
                              uid: doc['uid'],
                              activityId: doc.id,
                            );
                          }))
                        },
                        profileImg: doc['profileImg'],
                        nameUser: doc['student'],
                        catagory: doc['catagory'],
                        content: doc['contentText'],
                        nameTitle: doc['titleName'],
                        capacity: doc['amount'],
                        dateTime: formatDate,
                      );
                    }).toList(),
                  ),
                );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/activitydetail');
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.yellow[600],
      ),
    ));
  }
}
