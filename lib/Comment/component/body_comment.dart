import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:himod/providers/comment_provider.dart';
import 'package:himod/model/comment_validation.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:provider/provider.dart';

class BodyComment extends StatefulWidget {
  BodyComment({Key key}) : super(key: key);

  @override
  _BodyCommentState createState() => _BodyCommentState();
}

class _BodyCommentState extends State<BodyComment> {
  @override
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

  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentProvider>(context);
    final validationService = Provider.of<CommentProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Post"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.chat),
          )
        ],
        leading: TextButton(
            onPressed: () => {Navigator.pushNamed(context, '/post')},
            child: Text(
              "Back",
              style: TextStyle(color: Colors.black, fontSize: 13),
            )),
      ),
      // body:
      //     Container(
      //       height: 120.0,
      //       child: Container(
      //         color: Colors.grey,
      //         child: Stack(
      //           children: [
      //             Column(
      //               children: [
      //                 Row(
      //                   children: [
      //                     Image(
      //                       //????????? Profile User
      //                       image: NetworkImage(
      //                           'https://www.pngkey.com/png/full/335-3359725_circle-jamba-juiceorangeball-creative2017-08-08t18-woman-drinking.png'),
      //                       width: 45,
      //                       height: 45,
      //                     ),
      //                     Text(
      //                       "Chayaporn Popanom",
      //                       style: TextStyle(fontWeight: FontWeight.bold),
      //                     ),
      //                   ],
      //                 ),
      //                 Container(
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text(
      //                         "?????????????????????????????????????????????",
      //                         style: TextStyle(fontWeight: FontWeight.bold),
      //                       ),
      //                       Text(
      //                         "????????????????????????????????????????????? ???????????? 1000 ?????????",
      //                         style: TextStyle(fontWeight: FontWeight.bold),
      //                       ),
      //                     ],
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Comment").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView(
              children: snapshot.data.docs.map((document) {
            return Container(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(AuthProviderService.instance.user?.photoURL??''),
                ),
                title: Text(document['commentText']),
              ),
            );
          }).toList());
        },
      ),

      // body: Column(
      //   children: [
      //     Container(
      //       height: 120.0,
      //       child: Container(
      //         color: Colors.grey,
      //         child: Stack(
      //           children: [
      //             Column(
      //               children: [
      //                 Row(
      //                   children: [
      //                     Image(
      //                       //????????? Profile User
      //                       image: NetworkImage(
      //                           'https://www.pngkey.com/png/full/335-3359725_circle-jamba-juiceorangeball-creative2017-08-08t18-woman-drinking.png'),
      //                       width: 45,
      //                       height: 45,
      //                     ),
      //                     Text(
      //                       "Chayaporn Popanom",
      //                       style: TextStyle(fontWeight: FontWeight.bold),
      //                     ),
      //                   ],
      //                 ),
      //                 Container(
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text(
      //                         "?????????????????????????????????????????????",
      //                         style: TextStyle(fontWeight: FontWeight.bold),
      //                       ),
      //                       Text(
      //                         "????????????????????????????????????????????? ???????????? 1000 ?????????",
      //                         style: TextStyle(fontWeight: FontWeight.bold),
      //                       ),
      //                     ],
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Container(
      //       height: 80,
      //       color: Colors.pink,
      //       child: Column(
      //         children: [
      //           Row(
      //             children: [
      //               Image(
      //                 image: NetworkImage(
      //                     'https://www.pngkey.com/png/full/335-3359725_circle-jamba-juiceorangeball-creative2017-08-08t18-woman-drinking.png'),
      //                 width: 45,
      //                 height: 45,
      //               ),
      //               student_model == null
      //                   ? Container()
      //                   : Text(
      //                       student_model['name'].toString().toUpperCase(),
      //                       style: TextStyle(fontWeight: FontWeight.bold),
      //                     ),
      //             ],
      //           ),
      //           Container(
      //             margin: EdgeInsets.only(right: 200),
      //             child: Text("????????????????????????????????????"),
      //           )
      //         ],
      //       ),
      //     ),
      //   ],
      // ),

      //Bar ????????? comment ????????????????????????

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                  //   onSubmitted: ,
                  //     focusNode: ,
                  // controller: ,
                  decoration: new InputDecoration(
                      hintText: 'comment',
                      errorText: validationService.commentText.error),
                  onChanged: (String value) {
                    commentProvider.changeCommentText(value);
                  }),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              child: new IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (validationService.isValid) {
                    return commentProvider.saveCommentText();
                  }
                  return false;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
