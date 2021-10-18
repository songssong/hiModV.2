import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:himod/Widget/customViewPost.dart';
import 'package:intl/intl.dart';

class ViewPost extends StatefulWidget {
  final String uid;
  final String postid;

  ViewPost({Key key, this.uid, this.postid}) : super(key: key);

  @override
  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  DateTime dateTime;

  CollectionReference postref = FirebaseFirestore.instance.collection('Post');
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              PopupMenuButton(
                  color: Colors.white,
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("First"),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text("Second"),
                          value: 2,
                        ),
                      ]),
            ]),
          ),
        ),
        body: FutureBuilder(
            future: postref.where('postid', isEqualTo: widget.postid).get(),
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
                        category: doc['catagory'],
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
