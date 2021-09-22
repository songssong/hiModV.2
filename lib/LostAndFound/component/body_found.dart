import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:himod/Profile/component/profile_pic.dart';
import 'package:himod/Widget/customCard.dart';
import 'package:himod/post.dart';
import 'package:himod/service/auth_provider_service.dart';

class BodyFound extends StatefulWidget {
  BodyFound({Key key}) : super(key: key);

  @override
  _BodyFoundState createState() => _BodyFoundState();
}

// String url = AuthProviderService.instance.user?.photoURL ?? '';

class _BodyFoundState extends State<BodyFound> {
  @override
  void initState() {
    super.initState();
    // readDataLostAndFound();
  }

  // dynamic data_found;

  // Future<Null> readDataLostAndFound() async {
  //   await FirebaseFirestore.instance
  //       .collection('LostandFound')
  //       .doc(AuthProviderService.instance.user.uid)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       data_found = value.data();
  //     });
  //   });
  // }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          CustomCard(
            onClick: () => {print('object')},
            nameUser: "Thanapat Roemruai",
            dateTime: "10 sep 21",
            contentImg:
                "https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-800x825.jpg",
            content:
                "หมาหายช่วยด้วยยยยยยยยยยยยยยย ไอสัสหน้าหี โปรเจคคคคคคคคคคคคคคคคค",
            nameTitle: "หมาหาย!",
          ),
          
        ],
      ),
    );
  }
}
