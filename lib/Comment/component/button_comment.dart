

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:uuid/uuid.dart';

class ButtonComment extends StatefulWidget {
  final String postid;
  final String uid;
  final String postdocumentid;
  final String postTitleName;
  

  ButtonComment({
    Key key,
    this.postid,
    this.uid,
    this.postdocumentid,
    this.postTitleName,
  }) : super(key: key);

  @override
  _ButtonCommentState createState() => _ButtonCommentState();
}

class Comment {
  String contentComment;
  String commentId;
  String postId;
}

class _ButtonCommentState extends State<ButtonComment> {
  CollectionReference commentref =
      FirebaseFirestore.instance.collection('Comment');
  final TextEditingController _textController = new TextEditingController();

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
  Comment _commentdes = Comment();
  var uuid = Uuid();
  var uid = AuthProviderService.instance.user?.uid ?? '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Form(
        key: _formKey,
        child: TextFormField(
          autofocus: false,
          controller: _textController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Your Comment",
            suffixIcon: InkWell(
              child: Icon(Icons.send),
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  await commentref.add({
                    'contentText': _commentdes.contentComment,
                    'uid': uid,
                    'postid': widget.postid,
                    'commentid': uuid.v4(),
                    'student': student_model['name'],
                    'profileImg': student_model['imageUrl'],
                    'timestamp': DateTime.now(),
                    'type' : "post",
                    
                  });
                  setState(() async {
                    _textController.clear();
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    if (AuthProviderService.instance.user.uid != widget.uid) {
                      await addnotification();
                    }
                  });
                }
                
              },
              
            ),
          ),
          onSaved: (String contentComment) {
            _commentdes.contentComment = contentComment;
          },
          validator: RequiredValidator(errorText: "Please enter comment"),
        ),
      ),
    );
  }

  CollectionReference notificationref =
      FirebaseFirestore.instance.collection('Notification');
  Future<Null> addnotification() async {
    await notificationref.add({
      'notificationId': uuid.v4(),
      'uid': uid,
      'posttitlename': widget.postTitleName,
      'postauthoruid': widget.uid,
      'postid': widget.postid,
      'postdocumentid': widget.postdocumentid,
      'student': student_model['name'],
      'timestamp': DateTime.now(),
       'type' : "post",

    });
  }
}
