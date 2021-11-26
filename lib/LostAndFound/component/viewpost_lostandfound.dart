import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:himod/Comment/component/button_comment_lostnfound.dart';
import 'package:himod/Widget/_customBodyComment.dart';
import 'package:himod/Widget/_customViewLostAndFound.dart';

import 'package:himod/homepage.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ViewOnlyPost extends StatefulWidget {
  const ViewOnlyPost({Key key, this.uid, this.lostandfoundid, this.type})
      : super(key: key);

  final String uid;
  final String lostandfoundid;
  final String type;

  @override
  _ViewOnlyPostState createState() => _ViewOnlyPostState();
}

class _ViewOnlyPostState extends State<ViewOnlyPost> {
  DateTime dateTime;

  CollectionReference lostref =
      FirebaseFirestore.instance.collection('LostandFound');

  var uuid;
  var uid;

  void initState() {
    super.initState();
    readDataStudent();
  }

  dynamic student_model;
  Future<Null> readDataStudent() async {
    await FirebaseFirestore.instance
        .collection('Student')
        .doc(AuthProviderService.instance.user.uid)
        .get()
        .then((value) {
      setState(() {
        student_model = value.data();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: widget.type != "lost"
              ? Text(
                  "Found",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Mitr',
                      fontWeight: FontWeight.bold),
                )
              : Text(
                  "Lost",
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
                          await print(widget.lostandfoundid);
                          deleteData(widget.lostandfoundid);
                          await deleteAllComment(widget.lostandfoundid);
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
            future: lostref.doc(widget.lostandfoundid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Object>> snapshot_lost) {
              if (snapshot_lost.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot_lost.hasError) {
                return new Text('Error: ${snapshot_lost.hasError}');
              }
              if (!snapshot_lost.hasData || !snapshot_lost.data.exists) {
                return Text('empty data');
              }
              return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Comment')
                      .where('postid', isEqualTo: widget.lostandfoundid)
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Object>> snapshot_comment) {
                    if (snapshot_comment.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot_comment.hasError) {
                      return new Text('Error: ${snapshot_comment.hasError}');
                    }
                    Timestamp t = snapshot_lost.data['timestamp'];
                    DateTime d = DateTime.fromMicrosecondsSinceEpoch(
                        t.microsecondsSinceEpoch);
                    String formatDate =
                        DateFormat('yyyy-MM-dd – kk:mm').format(d);
                    // print(doc.data());
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomViewLostAndFound(
                            nameUser: snapshot_lost.data['student'],
                            profileImg: snapshot_lost.data['profileImg'],
                            contentImg: snapshot_lost.data['urlImage'],
                            nameTitle: snapshot_lost.data['titleName'],
                            content: snapshot_lost.data['contentText'],
                            contact: snapshot_lost.data['contact'],
                            category: snapshot_lost.data['catagory'],
                            type: snapshot_lost.data['typeName'],
                            dateTime: formatDate,
                          ),
                          Column(
                            children: [
                              Text(
                                'comment',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontFamily: 'Mitr',
                                ),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              ListView(
                                shrinkWrap: true,
                                children: snapshot_comment.data.docs
                                    .map((DocumentSnapshot doc) {
                                  if (doc != null) {
                                    Timestamp t = doc['timestamp'];
                                    DateTime d =
                                        DateTime.fromMicrosecondsSinceEpoch(
                                            t.microsecondsSinceEpoch);
                                    String formatDate =
                                        DateFormat('yyyy-MM-dd – kk:mm')
                                            .format(d);
                                    return InkWell(
                                        child: BodyComment(
                                          nameUser: doc['student'],
                                          profileImg: doc['profileImg'],
                                          content: doc['contentText'],
                                          dateTime: formatDate,
                                        ),
                                        onTap: AuthProviderService
                                                    .instance.user.uid ==
                                                doc['uid']
                                            ? () => showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'Are you sure to delete ?'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Cancel'),
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          await deleteComment(
                                                              doc.id);
                                                          Navigator.pop(
                                                              context, 'OK');
                                                        },
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                            : null);
                                  }
                                  return Container();
                                }).toList(),
                              ),
                              SizedBox(
                                height: 60,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            }),
        bottomSheet: ButtonCommentLostnfound(
          lostandfoundid: widget.lostandfoundid,
        ),
      ),
    );
  }

  deleteData(docID) async {
    await FirebaseFirestore.instance
        .collection('LostandFound')
        .doc(docID)
        .delete();
    Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  deleteComment(docID) async {
    await FirebaseFirestore.instance.collection('Comment').doc(docID).delete();
  }

  Future<void> deleteAllComment(docID) async {
    Stream<QuerySnapshot> snapshots = FirebaseFirestore.instance
        .collection('Comment')
        .where('postid', isEqualTo: docID)
        .snapshots();
    Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));

    return snapshots.forEach((snapshot) =>
        snapshot.docs.forEach((document) => document.reference.delete()));
  }

  CollectionReference postreport =
      FirebaseFirestore.instance.collection('Report');
  reportData(docID) async {
    await postreport.add({
      'lostandfoundid': widget.lostandfoundid,
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
                    'typePost': 'Lostandfound',
                    'report': 'ใช้คำพูดที่ไม่เหมาะสม',
                    'lostandfoundid': widget.lostandfoundid,
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
                    'typePost': 'Lostandfound',
                    'report': 'เข้าข่ายเกี่ยวกับเรื่องลามก อนาจาร',
                    'lostandfoundid': widget.lostandfoundid,
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
                    'typePost': 'Lostandfound',
                    'report': 'มีการพูดในสิ่งที่ผิดกฏหมาย',
                    'lostandfoundid': widget.lostandfoundid,
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
                    'typePost': 'Lostandfound',
                    'report': 'ข้อมูลเท็จ',
                    'lostandfoundid': widget.lostandfoundid,
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
                    'typePost': 'Lostandfound',
                    'report':
                        'เข้าข่ายมีข้อมูลส่วนตัวที่มีเจตนาทำให้คนผิดเสียหาย',
                    'lostandfoundid': widget.lostandfoundid,
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
}
