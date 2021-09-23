import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:himod/LostAndFound/lostandfound_screen.dart';
import 'package:himod/Profile/profile_screen.dart';
import 'package:himod/component/appbar.dart';
import 'package:himod/component/body.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:himod/component/bottombar.dart';
import 'package:himod/main.dart';
import 'package:himod/postdetail.dart';
import 'package:himod/component/appbar.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:himod/signup.dart';
import 'package:provider/provider.dart';
import 'dart:math';

//void main() => runApp(MyApp());
class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> with SingleTickerProviderStateMixin {
  Future<Null> readdataPost() async {}

  final TextEditingController _controller = new TextEditingController();
  Icon customIcon = const Icon(Icons.search);
  Icon customIcon2 = const Icon(Icons.cancel);
  Widget customSearchBar = const Text('Post');
  String name = "";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: customSearchBar,
        //   TextField(
        //     onChanged: (val) => initiateSearch(val),
        //  ),
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
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = Icon(Icons.cancel);
                  if (customIcon2.icon == Icons.cancel) {
                    name = "";
                  }

                  ///  if(customIcon.icon == Icons.cancel)

                  customSearchBar = ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 28,
                    ),
                    title: TextField(
                      onChanged: (val) => initiateSearch(val),
                      decoration: InputDecoration(
                        hintText: 'search',
                        hintStyle: TextStyle(
                          color: Colors.black,
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
                  customIcon = Icon(Icons.search);
                  customSearchBar = Text('Post');
                }
              });
            },
            icon: customIcon,
          ),
        ],

        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(30.0),
        //   child: Container(
        //     child: TabBar(
        //       indicatorColor: Colors.black,
        //       isScrollable: true,
        //       labelColor: Colors.black,
        //    //   controller: _tabController,
        //    //   tabs: _tabList,
        //     ),
        //   ),
        // ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: name != "" && name != null
              ? FirebaseFirestore.instance
                  .collection('Post')
                  // .doc(uid)
                  // .collection('titleName')
                  .where("titleName", isEqualTo: name)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection("Post")
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return ListView(
                  children: snapshot.data.docs.map((document) {
                    print('log: ${document.data()}');
                    return Card(
                      child: ListTile(
                        leading: FlutterLogo(size: 72.0),
                        // leading: CircleAvatar(backgroundColor: ),

                        title: Text(document["student"]),
                        subtitle: Text(document["titleName"]),

                        isThreeLine: true,
                      ),
                    );
                  }).toList(),
                );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/postdetail', (route) => false);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.yellow[600],
      ),
      //
    );
  }

  void initiateSearch(String val) {
    setState(() {
      name = val.toLowerCase().trim();
    });
  }
}
