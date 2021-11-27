import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:himod/LostAndFound/component/viewpost_lostandfound.dart';
import 'package:himod/Profile/component/profile_pic.dart';
import 'package:himod/Widget/_customCard.dart';

import 'package:himod/post.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:intl/intl.dart';

class BodyFound extends StatefulWidget {
  BodyFound({Key key, this.type_filter, this.name}) : super(key: key);

  final String type_filter;
  final String name;

  @override
  _BodyFoundState createState() => _BodyFoundState();
}

// String url = AuthProviderService.instance.user?.photoURL ?? '';

class _BodyFoundState extends State<BodyFound> {
  // final String type = "Found";
  DateTime dateTime;
  String type = "Found";

  @override
  Widget build(BuildContext context) {
    print('found ${widget.type_filter}');
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: widget.type_filter != ""
              ? FirebaseFirestore.instance
                  .collection('LostandFound')
                  .where('typeName', isEqualTo: type)
                  .where('catagory', isEqualTo: widget.type_filter)
                  .orderBy('timestamp', descending: true)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection("LostandFound")
                  .where('typeName', isEqualTo: type)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
            if (snapshot1.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot1.hasError) {
              return new Text('Error: ${snapshot1.hasError}');
            }

            if (snapshot1.hasError) {
              return new Text('Error: ${snapshot1.hasError}');
            }
            print('found ${widget.name}');
            return StreamBuilder<QuerySnapshot>(
                stream: widget.name != "" && widget.name != null
                    ? FirebaseFirestore.instance
                        .collection('LostandFound')
                        .where('typeName', isEqualTo: type)
                        .where("searchIndex", arrayContains: widget.name)
                        // .orderBy('timestamp', descending: true)
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection("LostandFound")
                        .where('typeName', isEqualTo: type)
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot2) {
                  if (snapshot2.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot2.hasError) {
                    return new Text('Error: ${snapshot2.hasError}');
                  }

                  if (snapshot2.hasError) {
                    return new Text('Error: ${snapshot2.hasError}');
                  }
                  if (widget.type_filter != "") {
                    return ListView(
                      children:
                          snapshot1.data.docs.map((DocumentSnapshot document) {
                        // print(doc.data());
                        Timestamp t = document['timestamp'];
                        DateTime d = DateTime.fromMicrosecondsSinceEpoch(
                            t.microsecondsSinceEpoch);
                        String formatDate =
                            DateFormat('yyyy-MM-dd – kk:mm').format(d);
                        // print(d);
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              CustomCard(
                                onClick: () => {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ViewOnlyPost(
                                        uid: document['uid'],
                                        lostandfoundid:
                                        document['lostandfoundid'],
                                        postdocumentid: document.id,
                                        postTitleName: document['titleName'],
                                        type: "found");
                                  }))
                                },
                                nameUser: document['student'],
                                profileImg: document['profileImg'],
                                dateTime: formatDate,
                                contentImg: document['urlImage'],
                                nameTitle: document['titleName'],
                                content: document['contentText'],
                                catagory: document['catagory'],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }
                  if (widget.name != "") {
                    return ListView(
                      children:
                          snapshot2.data.docs.map((DocumentSnapshot document) {
                        // print(doc.data());
                        Timestamp t = document['timestamp'];
                        DateTime d = DateTime.fromMicrosecondsSinceEpoch(
                            t.microsecondsSinceEpoch);
                        String formatDate =
                            DateFormat('yyyy-MM-dd – kk:mm').format(d);
                        // print(d);
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              CustomCard(
                                onClick: () => {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ViewOnlyPost(
                                        uid: document['uid'],
                                        lostandfoundid:
                                            document['lostandfoundid'],
                                        postdocumentid: document.id,
                                        postTitleName: document['titleName'],
                                        type: "found");
                                  }))
                                },
                                nameUser: document['student'],
                                profileImg: document['profileImg'],
                                dateTime: formatDate,
                                contentImg: document['urlImage'],
                                nameTitle: document['titleName'],
                                content: document['contentText'],
                                catagory: document['catagory'],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }
                  return ListView(
                    children:
                        snapshot1.data.docs.map((DocumentSnapshot document) {
                      // print(doc.data());
                      Timestamp t = document['timestamp'];
                      DateTime d = DateTime.fromMicrosecondsSinceEpoch(
                          t.microsecondsSinceEpoch);
                      String formatDate =
                          DateFormat('yyyy-MM-dd – kk:mm').format(d);
                      // print(d);
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            CustomCard(
                              onClick: () => {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ViewOnlyPost(
                                      uid: document['uid'],
                                      lostandfoundid:
                                          document['lostandfoundid'],
                                      postdocumentid: document.id,
                                      postTitleName: document['titleName'],
                                      type: "found");
                                }))
                              },
                              nameUser: document['student'],
                              profileImg: document['profileImg'],
                              dateTime: formatDate,
                              contentImg: document['urlImage'],
                              nameTitle: document['titleName'],
                              content: document['contentText'],
                              catagory: document['catagory'],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/lostnfounddetail');
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.yellow[600],
      ),
    );
  }
}
