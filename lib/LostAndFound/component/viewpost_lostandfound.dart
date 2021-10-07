import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:himod/Widget/customViewPost_LostAndFound.dart';
import 'package:intl/intl.dart';

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
          ),
        ),
        body: FutureBuilder(
            future: lostref
                .where('lostandfoundid', isEqualTo: widget.lostandfoundid)
                .get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  return ListView(
                    children: snapshot.data.docs.map((DocumentSnapshot doc) {
                      Timestamp t = doc['timestamp'];
                      DateTime d = DateTime.fromMicrosecondsSinceEpoch(
                          t.microsecondsSinceEpoch);
                      String formatDate =
                          DateFormat('yyyy-MM-dd – kk:mm').format(d);
                      // print(doc.data());
                      return CustomViewPost(
                        nameUser: doc['student'],
                        profileImg: doc['profileImg'],
                        contentImg: doc['urlImage'],
                        nameTitle: doc['titleName'],
                        content: doc['contentText'],
                        contact: doc['contact'],
                        category: doc['catagory'],
                        type: doc['typeName'],
                        dateTime: formatDate,
                      );
                    }).toList(),
                  );
              }
            }),
      ),
    );
  }
}
