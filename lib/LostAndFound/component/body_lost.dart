import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:himod/LostAndFound/component/viewpost_lostandfound.dart';
import 'package:himod/Widget/customCard.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:intl/intl.dart';

class BodyLost extends StatefulWidget {
  BodyLost({Key key, this.type_filter}) : super(key: key);

  final String type_filter;

  @override
  _BodyLostState createState() => _BodyLostState();
}

class _BodyLostState extends State<BodyLost> {
  DateTime dateTime;
  String type = "Lost";

  void initState() {
    print(widget.type_filter.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('lost ${widget.type_filter}');
    return Scaffold(
      body: StreamBuilder(
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
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot doc) {
                    // print(doc.data());
                    Timestamp t = doc['timestamp'];
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewOnlyPost(
                                        uid: doc['uid'],
                                        lostandfoundid: doc['lostandfoundid'],
                                        type: "lost"),
                                  ))
                            },
                            nameUser: doc['student'],
                            profileImg: doc['profileImg'],
                            dateTime: formatDate,
                            contentImg: doc['urlImage'],
                            nameTitle: doc['titleName'],
                            content: doc['contentText'],
                            catagory: doc['catagory'],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
            }
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
