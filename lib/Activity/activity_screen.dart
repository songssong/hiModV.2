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

enum Type {All, General, Sports, Games, Study, Other }

class _ActivityState extends State<Activity> {
  String _value = "";

  void _setValue(String value) => setState(() => _value = value);

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
                  'Sports',
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



  bool pressGeoON;
  @override
  Icon customIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );
  Icon customIcon2 = const Icon(
    Icons.cancel,
    color: Colors.white,
  );
  Widget customSearchBar = const Text(
    'Activity',
    style: TextStyle(color: Colors.white),
  );
  String name = "";
  DateTime dateTime;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: customSearchBar,
      
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
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            //  icon: const Icon(Icons.search),
            onPressed: () {
               if (customIcon2.icon == Icons.cancel)
                   name= "";
              setState(() {
                if (customIcon.icon == Icons.search) {
                 
                  customIcon = Icon(
                    Icons.cancel,
                    color: Colors.white,
                  
                  );
                  
                  customSearchBar = ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.grey[200],
                      size: 28,
                    ),
                    title: TextField(
                      onChanged: (val) => initiateSearch(val),
                      decoration: InputDecoration(
                        hintText: 'search',
                        hintStyle: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                } else {
                  customIcon = Icon(
                    Icons.search,
                    color: Colors.white,
                  );
                  customSearchBar = Text(
                    'Activity',
                    style: TextStyle(
                        fontFamily: 'Mitr',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  );
                }
              });
            },
            icon: customIcon,
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
                
          stream: _value != ""
              ? FirebaseFirestore.instance
                  .collection('Activity')
                  .where("catagory", isEqualTo: _value)
                  .orderBy('timestamp', descending: true)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection("Activity")
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          stream: name != "" && name != null
                    ? FirebaseFirestore.instance
                        .collection('Activity')
                        .where("searchIndex", arrayContains: name)
                       // .orderBy('timestamp', descending: true)
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection("Activity")
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
            } {
              

            if (snapshot.hasError) {
              return new Text('Error: ${snapshot.hasError}');
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:

                if(_value != "") {
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
                        profileImg: doc['profileImg'],
                        nameUser: doc['student'],
                        catagory: doc['catagory'],
                        content: doc['contentText'],
                        nameTitle: doc['titleName'],
                        capacity: doc['amount'],
                        count : doc['count'],
                        dateTime: formatDate,
                      );
                    }).toList(),
                  ),
                );
            }
            if (name != ""){ return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: snapshot1.data.docs.map((DocumentSnapshot doc) {
                      Timestamp t = doc['timestamp'];
                      DateTime d = DateTime.fromMicrosecondsSinceEpoch(
                          t.microsecondsSinceEpoch);
                      String formatDate =
                          DateFormat('yyyy-MM-dd – kk:mm').format(d);
                      return CustomActivity(
                        onClick: () async {
                          
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
                        profileImg: doc['profileImg'],
                        nameUser: doc['student'],
                        catagory: doc['catagory'],
                        content: doc['contentText'],
                        nameTitle: doc['titleName'],
                        capacity: doc['amount'],
                        count : doc['count'],
                        dateTime: formatDate,
                      );
                    }).toList(),
                  ),
                );}
              

            }
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
                        profileImg: doc['profileImg'],
                        nameUser: doc['student'],
                        catagory: doc['catagory'],
                        content: doc['contentText'],
                        nameTitle: doc['titleName'],
                        capacity: doc['amount'],
                        count : doc['count'],
                        dateTime: formatDate,
                      );
                    }).toList(),
                  ),
                );
          }});}),
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
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> checkStudent(
      join, studentjoin) async {
    return await FirebaseFirestore.instance
        .collection('JoinActivity')
        .where("joinid", isEqualTo: join)
        .where("studentuid", isEqualTo: studentjoin)
        .get();

  }


  

  void initiateSearch(String val) {
    setState(() {
      name = val.toLowerCase().trim();
    });
  }
}
