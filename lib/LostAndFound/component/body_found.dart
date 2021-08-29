import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:himod/Profile/component/profile_pic.dart';
import 'package:himod/post.dart';
import 'package:himod/service/auth_provider_service.dart';

class BodyLostAndFound extends StatefulWidget {
  BodyLostAndFound({Key key}) : super(key: key);

  @override
  _BodyLostAndFoundState createState() => _BodyLostAndFoundState();
}

String url = AuthProviderService.instance.user?.photoURL ?? '';

class _BodyLostAndFoundState extends State<BodyLostAndFound> {
  @override
  void initState() {
    super.initState();
    readDataLostAndFound();
  }

  dynamic data_found;

  Future<Null> readDataLostAndFound() async {
    await FirebaseFirestore.instance
        .collection('LostandFound')
        .doc(AuthProviderService.instance.user.uid)
        .get()
        .then((value) {
      setState(() {
        data_found = value.data();
      });
    });
  }

  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {
        print('object');
      },
      child: Container(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://scontent.fbkk13-2.fna.fbcdn.net/v/t1.6435-9/67321834_1249275281918784_905296475120992256_n.jpg?_nc_cat=106&ccb=1-4&_nc_sid=cdbe9c&_nc_eui2=AeEC27y1ezLgjKL6DnkjbiGts_BRO-sFqyqz8FE76wWrKr1Znk7T4HK3_mReBLEYH81A11e2egU6n7TxpV1-oKOi&_nc_ohc=DAlpy7PZdNEAX8QtUSS&_nc_ht=scontent.fbkk13-2.fna&oh=eef81e9ca6f019efaab79b2754b3173f&oe=613ACAB2'),
                  ),
                  title: Text('Thanapat Roemruai'),
                  subtitle: Text('2 min'), //insert timestemp
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Image(
                      image: NetworkImage(
                          'https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_cool_summer_slideshow/1800x1200_dog_cool_summer_other.jpg'),
                      width: 85,
                      height: 85,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("find dog!!!",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(
                              "หมาฉันหายไปไหนไม่รู้เมื่อวันก่อน ฉันเสียใจมากเลยแต่ฉันก็ไม่ดีใจ ฉันเป็นอะไร",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
