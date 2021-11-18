import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:himod/Comment/component/button_comment.dart';
import 'package:himod/LostAndFound/lostandfound_screen.dart';
import 'package:himod/Widget/_customBodyComment.dart';
import 'package:himod/Widget/_customViewPost.dart';
import 'package:himod/homepage.dart';
import 'package:himod/lostnfounddetail.dart';
import 'package:himod/post.dart';
import 'package:himod/postdetail.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ViewPost extends StatefulWidget {
  final String uid;
  final String postid;

  ViewPost({Key key, this.postid, this.uid}) : super(key: key);

  @override
  _ViewPostState createState() => _ViewPostState();
}

class Comment {
  String contentComment;
  String commentId;
  String postId;
}

class _ViewPostState extends State<ViewPost> {
  DateTime dateTime;
  VoidCallback onDelete;
  List<String> actions = <String>['Edit', 'Delete', 'Report'];

  var uuid;
  var uid;
  String commentId;
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

//  showDeleteConfirmation() {
//       Widget cancelButton = FlatButton(
//         child: Text('Cancel'),
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//       );
//       Widget deleteButton = FlatButton(
//         color: Colors.red,
//         child: Text('Delete'),
//         onPressed: () async {
//           await ContactsService.deleteContact(widget.contact.postId);
//           widget.onContactDelete(widget.contact);
//           Navigator.of(context).pop();
//         },
//       );
//       AlertDialog alert= AlertDialog(
//         title: Text('Delete contact?'),
//         content: Text('Are you sure you want to delete this contact?'),
//         actions: <Widget>[
//           cancelButton,
//           deleteButton
//         ],
//       );

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       }
//     );

//   }

  onAction(String action) async {
    switch (action) {
      // case 'Edit':
      //   try {
      //     Contact updatedContact = await ContactsService.openExistingContact(widget.);
      //     setState(() {
      //       widget.contact.info = updatedContact;
      //     });
      //     widget.onContactUpdate(widget.contact);
      //   } on FormOperationException catch (e) {
      //     switch(e.errorCode) {
      //       case FormOperationErrorCode.FORM_OPERATION_CANCELED:
      //       case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
      //       case FormOperationErrorCode.FORM_OPERATION_UNKNOWN_ERROR:
      //         print(e.toString());
      //     }
      //   }
      //   break;
      case 'Delete':
        await deleteData(widget.postid);

        break;
    }
    // print(documentID);
  }

  CollectionReference postref = FirebaseFirestore.instance.collection('Post');
  CollectionReference commentref =
      FirebaseFirestore.instance.collection('Comment');
  // CollectionReference _delcommentref =
  //     FirebaseFirestore.instance.collection('Comment').where('').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Post",
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
                        await deleteData(widget.postid);
                        deleteComment(commentId);
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
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot<Object>>(
            future: postref.doc(widget.postid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Object>> snapshot_post) {
              if (snapshot_post.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot_post.hasError) {
                return new Text('Error: ${snapshot_post.hasError}');
              }

              if (!snapshot_post.hasData || !snapshot_post.data.exists) {
                return Text('empty data');
              }

              return StreamBuilder<QuerySnapshot>(
                stream: commentref
                    .where('postid', isEqualTo: widget.postid)
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
                  Timestamp t = snapshot_post.data['timestamp'];
                  DateTime d = DateTime.fromMicrosecondsSinceEpoch(
                      t.microsecondsSinceEpoch);
                  String formatDate =
                      DateFormat('yyyy-MM-dd – kk:mm').format(d);
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomViewPost(
                          nameUser: snapshot_post.data['student'],
                          profileImg: snapshot_post.data['profileImg'],
                          contentImg: snapshot_post.data['urlImage'],
                          nameTitle: snapshot_post.data['titleName'],
                          content: snapshot_post.data['contentText'],
                          category: snapshot_post.data['catagory'],
                          dateTime: formatDate,
                        ),
                        Column(
                          children: [
                            Text(
                              'comment',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
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
                                  commentId = doc.id;
                                  DateTime d =
                                      DateTime.fromMicrosecondsSinceEpoch(
                                          t.microsecondsSinceEpoch);
                                  String formatDate =
                                      DateFormat('yyyy-MM-dd – kk:mm')
                                          .format(d);
                                  return BodyComment(
                                    nameUser: doc['student'],
                                    profileImg: doc['profileImg'],
                                    content: doc['contentText'],
                                    dateTime: formatDate,
                                  );
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
                },
              );
            }),
      ),
      bottomSheet: ButtonComment(
        postid: widget.postid,
      ),
    );
  }

  Future editPost() async {}

  deleteData(docID) async {
    var testCom = "N9aNJBPK3t3wytLY7Dpj";
    await FirebaseFirestore.instance.collection('Post').doc(docID).delete();

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
      'postid': widget.postid,
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
                    'typePost': 'Post',
                    'report': 'ใช้คำพูดที่ไม่เหมาะสม',
                    'postid': widget.postid,
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
                    'typePost': 'Post',
                    'report': 'เข้าข่ายเกี่ยวกับเรื่องลามก อนาจาร',
                    'postid': widget.postid,
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
                    'typePost': 'Post',
                    'report': 'มีการพูดในสิ่งที่ผิดกฏหมาย',
                    'postid': widget.postid,
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
                    'typePost': 'Post',
                    'report': 'ข้อมูลเท็จ',
                    'postid': widget.postid,
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
                    'typePost': 'Post',
                    'report':
                        'เข้าข่ายมีข้อมูลส่วนตัวที่มีเจตนาทำให้คนผิดเสียหาย',
                    'postid': widget.postid,
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
