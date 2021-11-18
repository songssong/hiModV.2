import 'package:flutter/material.dart';
import 'package:himod/Widget/_imageDialog.dart';

class CustomViewPost extends StatelessWidget {
  final String nameUser;
  final String profileImg;
  final String contentImg;
  final String dateTime;
  final String nameTitle;
  final String content;
  final String category;
  final Function onClick;

  const CustomViewPost(
      {Key key,
      this.nameUser,
      this.profileImg,
      this.contentImg,
      this.dateTime,
      this.nameTitle,
      this.content,
      this.category,
      this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        children: [
          InkWell(
            child: contentImg != null
                ? ClipRRect(
                    // borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      image: NetworkImage(contentImg),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(),
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageDialog(
                            contentImg: contentImg,
                          )));
            },
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 6,
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(profileImg) ?? ""),
                    title: Text(
                          nameUser,
                          style: TextStyle(
                              fontFamily: 'Mitr', fontWeight: FontWeight.bold),
                        ) ??
                        "",
                    subtitle: Text(
                      dateTime,
                      style: TextStyle(
                        fontFamily: 'Mitr',
                      ),
                    ),
                    trailing: Container(
                      padding: EdgeInsets.all(2),
                      child: Text(
                        category, // ใส่ category ของสิ
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40.0)),
                        gradient: new LinearGradient(
                          colors: [
                            const Color(0xffff9e23),
                            const Color(0xffff711b),
                            const Color(0xffff4814),
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 2,
                              offset: Offset(1, 1)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(1, 0, 1, 7),
                      child: ListTile(
                        title: Text(
                              nameTitle,
                              style: TextStyle(
                                  fontFamily: 'Mitr',
                                  fontWeight: FontWeight.w500),
                              textScaleFactor: 1.3,
                            ) ??
                            "",
                        subtitle: Text(
                              content,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Mitr',
                              ),
                            ) ??
                            "",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
