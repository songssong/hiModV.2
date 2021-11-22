import 'dart:math';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:himod/homepage.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:himod/post.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'LostAndFound/lostandfound_screen.dart';

// ignore: camel_case_types
class lostnfounddetail extends StatefulWidget {
  lostnfounddetail({Key key}) : super(key: key);

  @override
  _lostnfounddetailState createState() => _lostnfounddetailState();
}

class LostnfoundDes {
  String title;
  String description;
  String lostnfoundId;
  String type = 'Lost';
  String catagory = 'General';
  String contact;
  String userId;
  String urlImage;
}

// ignore: camel_case_types
class _lostnfounddetailState extends State<lostnfounddetail> {
  CollectionReference _lostCollection =
      FirebaseFirestore.instance.collection('LostandFound');

  final ImagePicker _picker = ImagePicker();
  File file;
  String downloadurl;

  getImage() async {
    final _temp = await _picker.pickImage(
        source: ImageSource.gallery, maxHeight: 800, maxWidth: 800);
    // final image = await _picker.getImage(
    //     source: ImageSource.gallery, maxHeight: 800, maxWidth: 800);

    setState(() {
      file = File(_temp.path);
    });
  }

  Future<void> UploadtoStorage() async {
    FirebaseStorage _storage = FirebaseStorage.instance;

    // dynamic urlImage;

    Random random = Random();
    int i = random.nextInt(100000);

    var Imageupload = await _storage
        .ref()
        .child('LostandFound/lostnfound$i.jpg')
        .putFile(file);
    var downloadurl = await (Imageupload).ref.getDownloadURL();

    _lostdes.urlImage = downloadurl;
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
  LostnfoundDes _lostdes = LostnfoundDes();
  var uuid = Uuid();
  var uid = AuthProviderService.instance.user?.uid ?? '';

  @override
  void initState() {
    readDataStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Lost",
              style: TextStyle(
                color: Colors.white,
              )),
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
          actions: [
            TextButton(
              onPressed: () async {
                print('Done');

                if (file != null) {
                  await UploadtoStorage();
                }
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  await _addToDatabase(_lostdes.title);
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }
              },
              child: Text("Done",
                  style: TextStyle(
                    color: Colors.white,
                  )),
            )
          ],
          leading: TextButton(
              onPressed: () => {
                    Navigator.pop(context,
                        MaterialPageRoute(builder: (context) => HomePage()))
                  },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.white, fontSize: 13),
              )),
        ),
        body: Container(
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment(1.0, 1.0),
            //    // end: Alignment(-1.34, 1.0),
            //     // colors: [
            //     //   const Color(0xffff9e23),
            //     //   const Color(0xffff711b),
            //     //   const Color(0xffff4814)
            //     // ]

            //     ) ,
            //     ),
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: size.height * 0.45,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.15 - 27,
                      decoration: BoxDecoration(
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
                                    _lostdes.title = title;
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
                                    _lostdes.description = description;
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
                ),
              ),
// type and catagory
              Container(
                height: size.height * 0.3,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.15 - 27,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              // bottomLeft: Radius.circular(36),
                              // bottomRight: Radius.circular(36),
                              )),
                    ),
                    Positioned(
                        top: 10,
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
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Select type",
                                          //style:

                                          //  TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 100),
                                        DropdownButton(
                                            value: _lostdes.type,
                                            isDense: true,
                                            items: [
                                              DropdownMenuItem(
                                                child: Text("Lost"),
                                                value: 'Lost',
                                              ),
                                              DropdownMenuItem(
                                                child: Text("Found"),
                                                value: 'Found',
                                              ),
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                _lostdes.type = value;
                                              });
                                            }),
                                      ],
                                    )),
                                Container(
                                    padding: EdgeInsets.only(bottom: 15.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Select category",
                                          //  style:
                                          //  TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 55),
                                        DropdownButton(
                                            value: _lostdes.catagory,
                                            items: [
                                              DropdownMenuItem(
                                                child: Text("General"),
                                                value: 'General',
                                              ),
                                              DropdownMenuItem(
                                                child: Text("Electric"),
                                                value: 'Electric',
                                              ),
                                              DropdownMenuItem(
                                                child: Text("Education"),
                                                value: 'Education',
                                              ),
                                              DropdownMenuItem(
                                                child: Text("Other"),
                                                value: 'Other',
                                              ),
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                _lostdes.catagory = value;

                                                _lostdes.catagory =
                                                    _lostdes.catagory;
                                              });
                                            }),
                                      ],
                                    )),
                                Container(
                                  //  padding: EdgeInsets.all(20.0),
                                  child: Row(children: [
                                    Text(
                                      "Contract",
                                      //  style:
                                      //  TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Container(
                                          padding: EdgeInsets.only(left: 40),
                                          child: ConstrainedBox(
                                            constraints:
                                                BoxConstraints.tightFor(
                                                    width: 200, height: 30),
                                            child: TextField(
                                              onChanged: (String contact) {
                                                _lostdes.contact = contact;
                                              },
                                              decoration: new InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    bottom: 12.0,
                                                    left: 10.0,
                                                    right: 10.0),
                                                hintText:
                                                    ('Enter your phone number'),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                                LengthLimitingTextInputFormatter(
                                                    10),
                                              ],
                                            ),
                                          )),
                                    )
                                  ]),
                                ),
                              ]),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: size.height * 0.3,
                child: Ink(
                  color: Colors.grey[300],
                  child: InkWell(
                    onTap: () async {
                      await getImage();
                      print('image path: ${file}');

                      print('image path: ${_lostdes.urlImage}');
                    },
                    child: file != null
                        ? Image.file(file)
                        : Container(
                            height: 150,
                            child: Center(child: Text("Upload a photo")),
                          ),
                  ),
                ),
              ),
            ],
          ),
        )));
  }

  _addToDatabase(String name) {
    List<String> splitList = name.split(" ");
    List<String> indexList = [];
    for (int i = 0; i < splitList.length; i++) {
      for (int y = 1; y < splitList[i].length + 1; y++) {
        indexList.add(splitList[i].substring(0, y).toLowerCase());
      }
    }

    print(indexList);
    FirebaseFirestore.instance.collection('LostandFound').doc().set({
      'titleName': name,
      'searchIndex': indexList,
      'contentText': _lostdes.description,
      'typeName': _lostdes.type,
      'catagory': _lostdes.catagory,
      'uid': uid,
      'lostandfoundid': uuid.v4(),
      'contact': _lostdes.contact,
      'urlImage': _lostdes.urlImage,
      'student': student_model['name'],
      'profileImg': student_model['imageUrl'],
      'timestamp': DateTime.now(),
    });
  }
}
