import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:himod/Profile/component/body_profile.dart';
import 'package:himod/service/auth_provider_service.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference profileref =
      FirebaseFirestore.instance.collection('Student');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
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
      body: FutureBuilder<DocumentSnapshot<Object>>(
          future: profileref.doc(AuthProviderService.instance.user.uid).get(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Object>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return new Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData || !snapshot.data.exists) {
              return Text('empty data');
            }
            return Column(
              children: [
                SizedBox(height: 30),
                SizedBox(
                  height: 115,
                  width: 115,
                  child: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data['imageUrl'])),
                ),
                //StudentId
                Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(
                            'StudentID',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0.5, 20, 0),
                  child: Container(
                    height: 50,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (Text(
                          snapshot.data['studentId'].toString(),
                          style: TextStyle(color: Colors.black),
                        )),
                      ),
                    ),
                  ),
                ),
                //Student Name
                Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0.5, 20, 0),
                  child: Container(
                    height: 50,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: snapshot.data == null
                              ? Container()
                              : Text(
                                  snapshot.data['name']
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(color: Colors.black),
                                )),
                    ),
                  ),
                ),
                //Faculty
                Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(
                            'Faculty',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0.5, 20, 0),
                  child: Container(
                    height: 50,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: snapshot.data == null
                              ? Container()
                              : Text(
                                  snapshot.data['faculty']
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(color: Colors.black),
                                )),
                    ),
                  ),
                ),
                //Email
                Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0.5, 20, 0),
                  child: Container(
                    height: 50,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AuthProviderService.instance.user?.email ?? '',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    FlatButton(
                        onPressed: () async {
                          EasyLoading.show(status: 'loading...');
                          await AuthProviderService.instance.signOut();
                          EasyLoading.dismiss();
                          setState(() {
                            Navigator.popAndPushNamed(context, '/signup');
                          });
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(fontSize: 16.0, color: Colors.red),
                        )),
                  ],
                )
              ],
            );
          }),
    );
  }
}
