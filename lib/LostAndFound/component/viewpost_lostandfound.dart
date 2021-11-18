import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:himod/Widget/customViewLostAndFound.dart';
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
                  style: TextStyle(color: Colors.white),
                )
              : Text(
                  "Lost",
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
                      if (AuthProviderService.instance.user.uid == widget.uid)
                        PopupMenuItem(
                          child: Text("Edit"),
                          value: 2,
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
                AsyncSnapshot<DocumentSnapshot<Object>> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  Timestamp t = snapshot.data['timestamp'];
                  DateTime d = DateTime.fromMicrosecondsSinceEpoch(
                      t.microsecondsSinceEpoch);
                  String formatDate =
                      DateFormat('yyyy-MM-dd – kk:mm').format(d);
                  // print(doc.data());
                  return CustomViewLostAndFound(
                    nameUser: snapshot.data['student'],
                    profileImg: snapshot.data['profileImg'],
                    contentImg: snapshot.data['urlImage'],
                    nameTitle: snapshot.data['titleName'],
                    content: snapshot.data['contentText'],
                    contact: snapshot.data['contact'],
                    category: snapshot.data['catagory'],
                    type: snapshot.data['typeName'],
                    dateTime: formatDate,
                  );
              }
            }),
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

  CollectionReference postreport =
      FirebaseFirestore.instance.collection('Report');
  reportData(docID) async {
    await postreport.add({
      'postid': widget.lostandfoundid,
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
                    'postid': widget.lostandfoundid,
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
                    'postid': widget.lostandfoundid,
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
                    'postid': widget.lostandfoundid,
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
                    'postid': widget.lostandfoundid,
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
                    'postid': widget.lostandfoundid,
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
