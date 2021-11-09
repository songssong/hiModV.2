import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:himod/LostAndFound/lostandfound_screen.dart';
import 'package:himod/Widget/customViewPost.dart';
import 'package:himod/homepage.dart';
import 'package:himod/lostnfounddetail.dart';
import 'package:himod/post.dart';
import 'package:himod/postdetail.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ViewPost extends StatefulWidget {
  final String uid;
  final String postid;


  ViewPost(
      {Key key, this.postid,  this.uid})
      : super(key: key);

  @override
  _ViewPostState createState() => _ViewPostState();
}

class Comment {
  String contentComment;
  String commentId;
  String postId;
}

class _ViewPostState extends State<ViewPost> {
  DateTime dateTime;
  VoidCallback onDelete;
  List<String> actions = <String>['Edit', 'Delete', 'Report'];

  var uuid;
  var uid;

//  showDeleteConfirmation() {
//       Widget cancelButton = FlatButton(
//         child: Text('Cancel'),
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//       );
//       Widget deleteButton = FlatButton(
//         color: Colors.red,
//         child: Text('Delete'),
//         onPressed: () async {
//           await ContactsService.deleteContact(widget.contact.postId);
//           widget.onContactDelete(widget.contact);
//           Navigator.of(context).pop();
//         },
//       );
//       AlertDialog alert= AlertDialog(
//         title: Text('Delete contact?'),
//         content: Text('Are you sure you want to delete this contact?'),
//         actions: <Widget>[
//           cancelButton,
//           deleteButton
//         ],
//       );

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       }
//     );

//   }

  onAction(String action) async {
    switch (action) {
      // case 'Edit':
      //   try {
      //     Contact updatedContact = await ContactsService.openExistingContact(widget.);
      //     setState(() {
      //       widget.contact.info = updatedContact;
      //     });
      //     widget.onContactUpdate(widget.contact);
      //   } on FormOperationException catch (e) {
      //     switch(e.errorCode) {
      //       case FormOperationErrorCode.FORM_OPERATION_CANCELED:
      //       case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
      //       case FormOperationErrorCode.FORM_OPERATION_UNKNOWN_ERROR:
      //         print(e.toString());
      //     }
      //   }
      //   break;
      case 'Delete':
        await deleteData(widget.postid);

        break;
    }
    // print(documentID);
  }

  CollectionReference postref = FirebaseFirestore.instance.collection('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Post",
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                PopupMenuButton(
                  color: Colors.white,
                  itemBuilder: (context) => [
                    if (AuthProviderService.instance.user.uid == widget.uid)
                      PopupMenuItem(
                        child: Text("Delete"),
                        value: 1,
                      ),
                       if (AuthProviderService.instance.user.uid == widget.uid)
                    PopupMenuItem(
                      child: Text("Edit"),
                      value: 2, 
                    ),
                    if (AuthProviderService.instance.user.uid != widget.uid)
                    PopupMenuItem(
                      child: Text("Report"),
                      value: 3, 
                    ),
                  ],
                  onSelected: (value) {
                    setState(() async{
                      if (value == 1) 
                      await  deleteData(widget.postid);
                    });
                  },
                ),
              ]),
            ],
          ),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot<Object>>(
        future: postref.doc(widget.postid).get(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Object>> snapshot) {
          print(snapshot.data);
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              Timestamp t = snapshot.data['timestamp'];
              DateTime d =
                  DateTime.fromMicrosecondsSinceEpoch(t.microsecondsSinceEpoch);
              String formatDate = DateFormat('yyyy-MM-dd – kk:mm').format(d);
              return SingleChildScrollView(
                child: CustomViewPost(
                  // onClick: deleteData(snapshot.data.docs),
                  nameUser: snapshot.data['student'],
                  profileImg: snapshot.data['profileImg'],
                  contentImg: snapshot.data['urlImage'],
                  nameTitle: snapshot.data['titleName'],
                  content: snapshot.data['contentText'],
                  category: snapshot.data['catagory'],
                  dateTime: formatDate,
                ),
              );
          }
        },
      ),
      
    );
  }

  
  Future editPost() async {
    
  }

  deleteData(docID) async {
    await FirebaseFirestore.instance.collection('Post').doc(docID).delete();
    Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));
  }


}
