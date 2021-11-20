import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:himod/Activity/activity_viewonlypost.dart';
import 'package:himod/Widget/_customCardActivity.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:intl/intl.dart';

class Activity extends StatefulWidget {
  Activity({Key key}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

enum Type { All, General, Sports, Games, Study, Other }

class _ActivityState extends State<Activity> {
  String _value = "";
  void _setValue(String value) => setState(() => _value = value);

  bool pressGeoON;
  Future _askUser() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select category'),
            children: <Widget>[
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  Navigator.pop(context, Type.All);
                },
                child: const Text(
                  'All',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  Navigator.pop(context, Type.General);
                },
                child: const Text(
                  'General',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  Navigator.pop(context, Type.Sports);
                },
                child: const Text(
                  'Sport',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  Navigator.pop(context, Type.Games);
                },
                child: const Text(
                  'Games',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  Navigator.pop(context, Type.Study);
                },
                child: const Text(
                  'Study',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  Navigator.pop(context, Type.Other);
                },
                child: const Text(
                  'Other',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        })) {
      case Type.All:
        _setValue('');
        break;
      case Type.General:
        _setValue('General');
        break;
      case Type.Sports:
        _setValue('Sports');
        break;
      case Type.Games:
        _setValue('Games');
        break;
      case Type.Study:
        _setValue('Study');
        print(_value);
        break;
      case Type.Other:
        _setValue('Other');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Activity",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Mitr',
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => _askUser(),
          icon: Icon(
            Icons.filter_list_alt,
            color: Colors.white,
            size: 30,
          ),
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
      body: StreamBuilder<QuerySnapshot>(
          stream: _value != ""
              ? FirebaseFirestore.instance
                  .collection('Activity')
                  // .doc(AuthProviderService.instance.user.uid)
                  // .collection('titleName')
                  .where("catagory", isEqualTo: _value)
                  .orderBy('timestamp', descending: true)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection("Activity")
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: snapshot.data.docs.map((DocumentSnapshot doc) {
                      Timestamp t = doc['timestamp'];
                      DateTime d = DateTime.fromMicrosecondsSinceEpoch(
                          t.microsecondsSinceEpoch);
                      String formatDate =
                          DateFormat('yyyy-MM-dd – kk:mm').format(d);
                      return CustomActivity(
                        onClick: () async {
                          print("aaaaaaaaaaaaaa");
                          print(doc.id);

                          var x = await checkStudent(
                              doc.id, AuthProviderService.instance.user.uid);

                          print(x.size);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            if (x.size > 0) {
                              pressGeoON = true;
                              print(pressGeoON);
                            } else
                              pressGeoON = false;

                            print(pressGeoON);

                            return ViewActivity(
                              uid: doc['uid'],
                              activityId: doc.id,
                              pressGeoON: pressGeoON,
                            );
                          }));
                        },
                        nameUser: doc['student'],
                        content: doc['contentText'],
                        nameTitle: doc['titleName'],
                        profileImg: doc['profileImg'],
                        capacity: doc['amount'],
                        catagory: doc['catagory'],
                        dateTime: formatDate,
                      );
                    }).toList(),
                  ),
                );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/activitydetail');
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.yellow[600],
      ),
    ));
  }

  String checkStudents;
  Future<QuerySnapshot<Map<String, dynamic>>> checkStudent(
      join, studentjoin) async {
    return await FirebaseFirestore.instance
        .collection('JoinActivity')
        .where("joinid", isEqualTo: join)
        .where("studentuid", isEqualTo: studentjoin)
        .get();
//return checkStudents;
  }
}
