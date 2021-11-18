import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:himod/Widget/customViewActivity.dart';
import 'package:himod/homepage.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:intl/intl.dart';

class ViewActivity extends StatefulWidget {
  final String uid;
  final String activityId;
  final String joinActivityid;
  bool pressGeoON;
  ViewActivity(
      {Key key,
      this.uid,
      this.activityId,
      this.joinActivityid,
      this.pressGeoON})
      : super(key: key);

  @override
  _ViewActivityState createState() => _ViewActivityState();
}

class _ViewActivityState extends State<ViewActivity> {
  CollectionReference activityref =
      FirebaseFirestore.instance.collection('Activity');
  //bool pressGeoON = false;
  bool cmbscritta = false;

  String joinActivityid;

  void initState() {
    super.initState();
    calljoinid();

    readDataStudent();
  }

  var uid = AuthProviderService.instance.user?.uid ?? '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Activity",
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
        body: FutureBuilder<DocumentSnapshot<Object>>(
            future: activityref.doc(widget.activityId).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Object>> snapshot) {
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('JoinActivity')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Object>> snapshotjoin) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      ListView(
                        shrinkWrap: true,
                        children:
                            snapshotjoin.data.docs.map((DocumentSnapshot doc) {
                          if (doc != null) {
                            joinActivityid = doc.id;
                          }
                          return Container();
                        }).toList(),
                      );

                      Timestamp t = snapshot.data['timestamp'];
                      DateTime d = DateTime.fromMicrosecondsSinceEpoch(
                          t.microsecondsSinceEpoch);
                      String formatDate =
                          DateFormat('yyyy-MM-dd – kk:mm').format(d);

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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: RaisedButton(
                                      elevation: 5,
                                      padding: EdgeInsets.all(6),
                                      color: widget.pressGeoON
                                          ? Colors.red
                                          : Colors.blue[500],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      onPressed: () async {
                                        if (widget.pressGeoON) {
                                          await unjoinActivity(joinActivityid);
                                          print('unjoin');
                                          // print(widget.activityId);
                                          print(joinActivityid);
                                        } else {
                                          print('join');
                                          joinActivity();
                                          print(joinActivityid);
                                        }
                                        setState(() {
                                          widget.pressGeoON =
                                              !widget.pressGeoON;
                                        });
                                      },

                                      // );

                                      child: Row(
                                        children: [
                                          widget.pressGeoON
                                              ? Text(
                                                  "UnJoin Activity",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                )
                                              : // SizedBox(width: 2),

                                              Text(
                                                  "Join Activity",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                )
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
              );
            }));
  }

  CollectionReference _joinCollection =
      FirebaseFirestore.instance.collection('JoinActivity');

  Stream<QuerySnapshot<Map<String, dynamic>>> _joinCollection2 =
      FirebaseFirestore.instance.collection('JoinActivity').snapshots();

  // DocumentReference<Object> _joinCollection1 =
  //     FirebaseFirestore.instance.collection('JoinActivity').doc();
  // //DocumentSnapshot<Object> doc = _joinCollection1.get()
  //List ;
  // List student_join;
  // Future<Null> studentJoin() async {
  //   await FirebaseFirestore.instance
  //       .collection('Student')
  //       .doc('studentjoin')
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       student_join = value.data[];
  //     });
  //   });
  // }

  dynamic student_model;
  Future<Null> readDataStudent() async {
    await FirebaseFirestore.instance
        .collection('Student')
        .doc(AuthProviderService.instance.user.uid)
        .get()
        .then((value) {
      {
        student_model = value.data();
      }
      ;
    });
  }

  showStudent(docID) async {
    String joinid;
    await FirebaseFirestore.instance
        .collection('JoinActivity')
        .doc(joinid = 'joinid');

    //for (var i = 0; i < ; i++) {

    //   }
  }

  joinActivity() async {
    await _joinCollection.add({
      'joinid': widget.activityId,
      'timestamp': DateTime.now(),
      'student': student_model['name'],
      'studentuid': uid.toString(),
    });
  }

  String joinid2;
  calljoinid() async {}

  unjoinActivity(docid) async {
    await FirebaseFirestore.instance
        .collection('JoinActivity')
        .doc(docid)
        .delete();
  }
}
