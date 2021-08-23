import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:himod/post.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:uuid/uuid.dart';
//import 'package:form_field_validator/form_field_validator.dart';

class Postdetail extends StatefulWidget {
  @override
  _PostdetailState createState() => _PostdetailState();
}

class PostDes {
  String title;
  String description;
  String postId;
  String userId;
  
  PostDes({this.title, this.description,this.userId});
   //ดึงข้อมูล

   //var db = await this.openDatabase();
  
  

  }


class _PostdetailState extends State<Postdetail> {
  CollectionReference _postCollection =
      FirebaseFirestore.instance.collection('Post');
      
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

  final _formKey = GlobalKey<FormState>();
  PostDes _postdes = PostDes();
  var uuid = Uuid();
  var uid = AuthProviderService.instance.user?.uid ?? '';
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Post",
              style: TextStyle(
                color: Colors.white,
              )),

          backgroundColor:
              // const Color(0xffff9e23),
              const Color(0xffff711b),
          
        actions: [
          TextButton(
            onPressed: () async {
              print('Done');

              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                await _postCollection.add({
                  'titleName': _postdes.title,
                  'contentText': _postdes.description,
                   'uid' :  uid.toString(),
                   'postid' : uuid.v4(),
                  'student':   student_model['name'],
                });
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Post()));
              }
            },
            child: Text("Done",
                style: TextStyle(color: Colors.white, fontSize: 13),
          )
          )],
        leading: TextButton(
            onPressed: () => {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Post()))
                },
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 13),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: size.height * 0.6,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.15 - 27,
                      decoration: BoxDecoration(
                        //  color: Colors.orange,
                          borderRadius: BorderRadius.only(
                              // bottomLeft: Radius.circular(36),
                              // bottomRight: Radius.circular(36),
                              )),
                    ),
                    Positioned(
                      top: 25,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        height: size.height * 0.59,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Colors.black.withOpacity(0.23),
                            )
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(children: <Widget>[
                              Container(
                                height: size.height * 0.05,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white),
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  onSaved: (String title) {
                                    _postdes.title = title;
                                  },
                                  validator: RequiredValidator(
                                      errorText: 'title not complete'),
                                  decoration: InputDecoration(
                                    hintText: "Title..",
                                    hintStyle: TextStyle(
                                        fontSize: 16.0, color: Colors.grey),
                                  ),
                                ),
                              ),
                              Container(
                                height: size.height * 1.5,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white),
                                margin: EdgeInsets.only(top: 20),
                                padding: EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  onSaved: (String description) {
                                    _postdes.description = description;
                                  },
                                  validator: RequiredValidator(
                                      errorText: 'Description not complete'),
                                  decoration: InputDecoration(
                                    hintText: " ' Type Description '",
                                    hintStyle: TextStyle(
                                        fontSize: 12.0, color: Colors.grey),
                                  ),
                                  maxLines: 7,
                                  maxLength: 250,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
