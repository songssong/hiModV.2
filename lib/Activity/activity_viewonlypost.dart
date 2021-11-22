import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:himod/Widget/_customViewActivity.dart';

import 'package:himod/homepage.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ViewActivity extends StatefulWidget {
  final String uid;
  final String activityId;
  final String joinActivityid;
  final String studentjoin;
  bool pressGeoON;
  ViewActivity(
      {Key key,
      this.uid,
      this.activityId,
      this.joinActivityid,
      this.pressGeoON,
      this.studentjoin})
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
  int count;
  int amount;
  bool isEnabled = true;

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  PopupMenuButton(
                    color: Colors.white,
                    itemBuilder: (context) => [
                      if (AuthProviderService.instance.user.uid == widget.uid)
                        PopupMenuItem(
                          child: Text("Delete"),
                          value: 1,
                        ),
                      if (AuthProviderService.instance.user.uid != widget.uid)
                        PopupMenuItem(
                          child: Text("Report"),
                          value: 3,
                        ),
                    ],
                    onSelected: (value) {
                      setState(() async {
                        if (value == 1) {
                          await deleteData(widget.activityId);
                          //deleteComment(commentId);
                        }
                        if (value == 3) {
                          _askUser();
                        }
                      });
                    },
                  ),
                ]),
              ],
            ),
          ),
        ),
        body: FutureBuilder<DocumentSnapshot<Object>>(
            future: activityref.doc(widget.activityId).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Object>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return new Text('Error: ${snapshot.hasError}');
                  }

                  if (snapshot.hasError) {
                    return new Text('Error: ${snapshot.hasError}');
                  }
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('JoinActivity')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Object>> snapshotjoin) {
                  if (snapshotjoin.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshotjoin.hasError) {
                    return new Text('Error: ${snapshotjoin.hasError}');
                  }

                  if (snapshotjoin.hasError) {
                    return new Text('Error: ${snapshotjoin.hasError}');
                  }
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
                      count = snapshot.data['count'];
                      amount = snapshot.data['amount'];

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
                              count: snapshot.data['count'],
                              timeStamp: formatDate,
                            ),
                            //button Join
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (count == amount)
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 10, 0),
                                      child: RaisedButton(
                                        elevation: 5,
                                        padding: EdgeInsets.all(6),
                                        color: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        onPressed: null,
                                        child: Row(
                                          children: [
                                            Text(
                                              "Full",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Mitr',
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                Container(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: RaisedButton(
                                      elevation: 5,
                                      disabledElevation: 1,
                                      padding: EdgeInsets.all(6),
                                      color: widget.pressGeoON
                                          ? Colors.red
                                          : Colors.blue[500],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      onPressed: AuthProviderService
                                                      .instance.user.uid ==
                                                  widget.uid ||
                                              (count == amount &&
                                                  !widget.pressGeoON)
                                          ? null
                                          : () async {
                                              if (widget.pressGeoON) {
                                                await unjoinActivity(
                                                    joinActivityid);
                                                print('unjoin');
                                                uncountjoin(widget.activityId);
                                                print(joinActivityid);
                                              } else {
                                                print('join');
                                                joinActivity();

                                                countjoin(widget.activityId);
                                                print(widget.activityId);
                                              }
                                              setState(() {
                                                widget.pressGeoON =
                                                    !widget.pressGeoON;
                                                isEnabled = false;
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
                                                      fontFamily: 'Mitr',
                                                      fontSize: 14),
                                                )
                                              : // SizedBox(width: 2),

                                              Text(
                                                  "Join Activity",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Mitr',
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

  Future<QuerySnapshot<Map<String, dynamic>>> countjoin(activityid) async {
    var collection = FirebaseFirestore.instance.collection('Activity');
    collection
        .doc(activityid)
        .update({'count': count + 1}) // <-- Updated data
        .then((_) => print('Success'))
        .catchError((error) => print('Failed: $error'));
  }

  Future<QuerySnapshot<Map<String, dynamic>>> uncountjoin(activityid) async {
    var collection = FirebaseFirestore.instance.collection('Activity');
    collection
        .doc(activityid)
        .update({'count': count - 1}) // <-- Updated data
        .then((_) => print('Success'))
        .catchError((error) => print('Failed: $error'));
  }

  deleteData(docID) async {
    await FirebaseFirestore.instance.collection('Activity').doc(docID).delete();

    Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  deleteComment(docID) async {
    var testCom = "N9aNJBPK3t3wytLY7Dpj";

    FirebaseFirestore.instance.collection('Comment').doc(docID).delete();
    Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  CollectionReference postreport =
      FirebaseFirestore.instance.collection('Report');
  reportData(docID) async {
    await postreport.add({
      'activityid': widget.activityId,
      'reporter': student_model['name'],
      'reporttime': DateTime.now(),
    });
  }

  var uuid2 = Uuid();
  Future _askUser() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Report'),
            children: <Widget>[
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  postreport.add({
                    'reportid': uuid2.v4(),
                    'typePost': 'Activity',
                    'report': 'ใช้คำพูดที่ไม่เหมาะสม',
                    'postid': widget.activityId,
                    'reporter': student_model['name'],
                    'reporttime': DateTime.now(),
                  });
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: const Text(
                  'ใช้คำพูดที่ไม่เหมาะสม',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  postreport.add({
                    'reportid': uuid2.v4(),
                    'typePost': 'Activity',
                    'report': 'เข้าข่ายเกี่ยวกับเรื่องลามก อนาจาร',
                    'postid': widget.activityId,
                    'reporter': student_model['name'],
                    'reporttime': DateTime.now(),
                  });
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: const Text(
                  'เข้าข่ายเกี่ยวกับเรื่องลามก อนาจาร',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  postreport.add({
                    'reportid': uuid2.v4(),
                    'typePost': 'Activity',
                    'report': 'มีการพูดในสิ่งที่ผิดกฏหมาย',
                    'postid': widget.activityId,
                    'reporter': student_model['name'],
                    'reporttime': DateTime.now(),
                  });
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: const Text(
                  'มีการพูดในสิ่งที่ผิดกฏหมาย',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  postreport.add({
                    'reportid': uuid2.v4(),
                    'typePost': 'Activity',
                    'report': 'ข้อมูลเท็จ',
                    'postid': widget.activityId,
                    'reporter': student_model['name'],
                    'reporttime': DateTime.now(),
                  });
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: const Text(
                  'ข้อมูลเท็จ',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  postreport.add({
                    'reportid': uuid2.v4(),
                    'typePost': 'Activity',
                    'report':
                        'เข้าข่ายมีข้อมูลส่วนตัวที่มีเจตนาทำให้คนผิดเสียหาย',
                    'postid': widget.activityId,
                    'reporter': student_model['name'],
                    'reporttime': DateTime.now(),
                  });
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: const Text(
                  'เข้าข่ายมีข้อมูลส่วนตัวที่มีเจตนาทำให้คนผิดเสียหาย',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        })) {
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> showStudents(joinid) async {
    return await FirebaseFirestore.instance
        .collection('JoinActivity')
        .where("joinid", isEqualTo: joinid)
        .get();
  }
}
