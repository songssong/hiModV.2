import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:himod/Widget/customViewActivity.dart';
import 'package:intl/intl.dart';

class ViewActivity extends StatefulWidget {
  final String uid;
  final String activityId;
  ViewActivity({Key key, this.uid, this.activityId}) : super(key: key);

  @override
  _ViewActivityState createState() => _ViewActivityState();
}

class _ViewActivityState extends State<ViewActivity> {
  CollectionReference activityref =
      FirebaseFirestore.instance.collection('Activity');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
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
      body: FutureBuilder<DocumentSnapshot<Object>>(
        future: activityref.doc(widget.activityId).get(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Object>> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              Timestamp t = snapshot.data['timestamp'];
              DateTime d =
                  DateTime.fromMicrosecondsSinceEpoch(t.microsecondsSinceEpoch);
              String formatDate = DateFormat('yyyy-MM-dd – kk:mm').format(d);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CustomViewActivity(
                      nameUser: snapshot.data['student'],
                      profileImg: snapshot.data['profileImg'],
                      nameTitle: snapshot.data['titleName'],
                      content: snapshot.data['contentText'],
                      category: snapshot.data['catagory'],
                      contact: snapshot.data['contact'],
                      capacity: snapshot.data['amount'],
                      select_date: snapshot.data['date'],
                      select_time: snapshot.data['time'],
                      timeStamp: formatDate,
                    ),
                    //button Join
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: RaisedButton(
                              elevation: 5,
                              padding: EdgeInsets.all(6),
                              color: Colors.blue[500],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: () {
                                print("ปุ่ม join อยู่นี้จ้า");
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add_circle_rounded,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "Join Activity",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
