// import 'package:flutter/material.dart';

// class customProfile extends StatelessWidget {
//   final String nameUser;
//   final String studentId;
//   final String faculty;
//   final String email;
//   final String profile;

//   const customProfile(
//       {Key key,
//       this.nameUser,
//       this.studentId,
//       this.faculty,
//       this.email,
//       this.profile})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//           padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
//           child: new Row(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               new Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   new Text(
//                     'StudentID',
//                     style:
//                         TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(40, 0.5, 20, 0),
//           child: Container(
//             height: 50,
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: (student_model == null
//                     ? Container()
//                     : Text(
//                         student_model['studentId'].toString(),
//                         style: TextStyle(color: Colors.black),
//                       )),
//               ),
//             ),
//           ),
//         ),;
//   }
// }
