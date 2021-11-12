import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:himod/homepage.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:uuid/uuid.dart';

class Activitydetail extends StatefulWidget {
  @override
  _ActivitydetailState createState() => _ActivitydetailState();
}

class ActivitydDes {
  String title;
  String description;
  String activityId;
  String catagory;
  String contact;
  String userId;
  DateTime activitydate;
  int amount;
  TimeOfDay activitytime;
  String date;
  String time;
  Timestamp timeofday;

  ActivitydDes({this.title, this.description});

  static fromSnapshot(tripSnapshot) {}
}

class _ActivitydetailState extends State<Activitydetail> {
  CollectionReference _ActCollection =
      FirebaseFirestore.instance.collection('Activity');

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
  ActivitydDes _activitydes = ActivitydDes();
  var uuid = Uuid();
  var uid = AuthProviderService.instance.user?.uid ?? '';
  String catagory = 'General';
  int val = 1;

  String test;
  String test2;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Activity",
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
                  print(test);
                  // if (_activitydes.activitydate != null &&
                  //     _activitydes.activitytime != null) {
                  //   Gettimestamptest();
                  // }
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await _ActCollection.add({
                      'titleName': _activitydes.title.toLowerCase().trim(),
                      'contentText': _activitydes.description,
                      'uid': uid.toString(),
                      'postid': uuid.v4(),
                      'student': student_model['name'],
                      'catagory': _activitydes.catagory,
                      'profileImg': student_model['imageUrl'],
                      'timestamp': DateTime.now(),
                      'contact': _activitydes.contact,
                      'amount': _activitydes.amount,
                      'date': _activitydes.date,
                      'time': _activitydes.time,
                    });
                    Navigator.pop(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
                child: Text(
                  "Done",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ))
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
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
          Container(
            height: size.height * 0.45,
            child: Stack(
              children: <Widget>[
                Container(
                  height: size.height * 0.15 - 27,
                  decoration: BoxDecoration(borderRadius: BorderRadius.only()),
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
                      child: Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
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
                                    _activitydes.title = title;
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
                                    _activitydes.description = description;
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //container2
          Container(
              height: size.height * 0.15,
              child: Stack(children: <Widget>[
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
                            ),
                          ],
                        ),
                        child: Form(
                            child: SingleChildScrollView(
                                child: Column(children: <Widget>[
                          Container(
                            //  padding: EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                Text(
                                  "Select category",
                                  //  style:
                                  //  TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 55),
                                DropdownButton(
                                    value: catagory,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text("General"),
                                        value: 'General',
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Sports"),
                                        value: 'Sports',
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Games"),
                                        value: 'Games',
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Study"),
                                        value: 'Study',
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Other"),
                                        value: 'Other',
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        catagory = (value);

                                        _activitydes.catagory = catagory;
                                      });
                                    })
                              ],
                            ),
                          ),
                          Container(
                              //  padding: EdgeInsets.all(20.0),
                              child: Row(
                            children: [
                              Text(
                                "Contract",
                                //  style:
                                //  TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Container(
                                    padding: EdgeInsets.only(left: 40),
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints.tightFor(
                                          width: 200, height: 30),
                                      child: TextField(
                                        onChanged: (String contact) {
                                          _activitydes.contact = contact;
                                        },
                                        decoration: new InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              bottom: 12.0,
                                              left: 10.0,
                                              right: 10.0),
                                          hintText: ('Enter your phone number'),
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]')),
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                      ),
                                    )),
                              )
                            ],
                          )),
                        ])))))
              ])),

          //Container3
          Container(
            height: size.height * 0.25,
            child: Stack(children: <Widget>[
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
                          ),
                        ],
                      ),
                      child: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                //  padding: EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Date",
                                      //  style:
                                      //  TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 55),
                                    RaisedButton(
                                      color: Colors.white,
                                      child: Text(getDate(),
                                          style:
                                              TextStyle(color: Colors.black)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate:
                                                    DateTime(2021, 12, 31))
                                            .then((date) {
                                          setState(() {
                                            _activitydes.activitydate = date;
                                            Getdatestamp();
                                          });
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 8.5),
                                child: Row(
                                  children: [
                                    Text(
                                      "Time",
                                    ),
                                    SizedBox(width: 55),
                                    RaisedButton(
                                      color: Colors.white,
                                      child: Text(
                                        getTime(),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      //     side:
                                      //         BorderSide(color: Colors.orange)),
                                      onPressed: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay(
                                                    hour: 9, minute: 0))
                                            .then((time) {
                                          setState(() {
                                            _activitydes.activitytime = time;
                                            Gettimestamp();
                                          });
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  padding:
                                      EdgeInsets.only(top: 8.5, right: 0.1),
                                  child: Row(children: [
                                    Text(
                                      "Amount",
                                      //  style:
                                      //  TextStyle(gf: FontWeight.bold),
                                    ),
                                    SizedBox(width: 55),
                                    Container(
                                      child: Text(
                                        val.toString(),
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ])),
                              Container(
                                  padding: EdgeInsets.only(right: 0.1),
                                  child: SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        activeTrackColor: Colors.red[700],
                                        inactiveTrackColor: Colors.red[100],
                                        trackShape:
                                            RoundedRectSliderTrackShape(),
                                        trackHeight: 5.0,
                                        thumbShape: RoundSliderThumbShape(
                                            enabledThumbRadius: 12.0),
                                        thumbColor: Colors.redAccent,
                                        overlayColor: Colors.red.withAlpha(32),
                                        overlayShape: RoundSliderOverlayShape(
                                            overlayRadius: 28.0),
                                        tickMarkShape:
                                            RoundSliderTickMarkShape(),
                                        activeTickMarkColor: Colors.red[700],
                                        inactiveTickMarkColor: Colors.red[100],
                                        valueIndicatorShape:
                                            PaddleSliderValueIndicatorShape(),
                                        valueIndicatorColor: Colors.redAccent,
                                        valueIndicatorTextStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: Slider(
                                        min: 1,
                                        max: 50,
                                        divisions: 50,
                                        value: val.toDouble(),
                                        label: val.round().toString(),
                                        activeColor: Colors.orange,
                                        inactiveColor: Colors.red,
                                        onChanged: (double newValue) {
                                          setState(() {
                                            val = newValue.round();
                                            _activitydes.amount = val;
                                          });
                                        },
                                      )))
                            ],
                          ),
                        ),
                      )))
            ]),
          ),
          SizedBox(
            height: 20,
          ),
        ]))));
  }

  String getDate() {
    if (_activitydes.activitydate == null) {
      return 'Select Date';
    } else {
      return '${_activitydes.activitydate.day}/${_activitydes.activitydate.month}/${_activitydes.activitydate.year}';
    }
  }

  String getTime() {
    if (_activitydes.activitytime == null) {
      return 'Select Time';
    } else {
      final hours = _activitydes.activitytime.hour.toString().padLeft(2, '0');
      final minutes =
          _activitydes.activitytime.minute.toString().padLeft(2, '0');

      return '${hours}.${minutes}';
    }
  }

  Future<void> Getdatestamp() async {
    var activitydate = Jiffy(DateTime(
      _activitydes.activitydate.year,
      _activitydes.activitydate.month,
      _activitydes.activitydate.day,
    )).format("dd-MM-yyyy");

    _activitydes.date = activitydate;
  }

  Future<void> Gettimestamp() async {
    var activitytime = Jiffy({
      "hour": _activitydes.activitytime.hour,
      "minute": _activitydes.activitytime.minute,
    }).format("h:mm a");
    _activitydes.time = activitytime;
  }
}
