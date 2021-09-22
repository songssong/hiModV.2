import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:himod/Widget/customCard.dart';

class BodyLost extends StatefulWidget {
  BodyLost({Key key}) : super(key: key);

  @override
  _BodyLostState createState() => _BodyLostState();
}

class _BodyLostState extends State<BodyLost> {
  @override
  // void initState() {
  //   super.initState();
  //   readDataLostAndFound();
  // }

  // dynamic student_model;

  // Future<Null> readDataLostAndFound() async {
  //   await FirebaseFirestore.instance
  //       .collection('Student')
  //       .doc()
  //       .get()
  //       .then((value) {
  //     setState(()  {
  //       student_model = value.data();
  //     });
  //   });
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('LostandFound').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot doc) {
                print(doc.data());
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      CustomCard(
                        onClick: () => {print('object')},
                        nameUser: doc['student'] ?? 'student_name',
                        // profileImg: student_model['imageUrl'].toString() ?? Container(),
                        // dateTime: doc['timestamp'],
                        contentImg: doc['urlImage'],
                        nameTitle: doc['titleName'],
                        content: doc['contentText'],
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
