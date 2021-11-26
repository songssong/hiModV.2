import 'package:flutter/material.dart';
import 'package:himod/Widget/_imageDialog.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomViewLostAndFound extends StatelessWidget {
  final String nameUser;
  final String profileImg;
  final String contentImg;
  final String dateTime;
  final String nameTitle;
  final String content;
  final String contact;
  final String category;
  final String type;

  CustomViewLostAndFound(
      {Key key,
      this.nameUser,
      this.profileImg,
      this.contentImg,
      this.dateTime,
      this.nameTitle,
      this.content,
      this.contact,
      this.category,
      this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        children: [
          InkWell(
            child: contentImg != null
                ? Image(
                    image: NetworkImage(contentImg),
                    width: double.infinity,
                    fit: BoxFit.cover,
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
          ListTile(
            leading:
                CircleAvatar(backgroundImage: NetworkImage(profileImg) ?? ""),
            title: Text(
                  nameUser,
                  style: TextStyle(
                      fontFamily: 'Mitr', fontWeight: FontWeight.bold),
                ) ??
                "",
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                          child: Text(
                                category, // ใส่ category ของที่หาย
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ) ??
                              "",
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
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                          child: Text(
                                type, // ประเภท lost or found
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ) ??
                              "",
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
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.access_time_sharp,
                              size: 15,
                              color: Colors.grey,
                            ),
                            Text(
                              dateTime, //ใส่ DateTime
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: 'Mitr',
                              ),
                            ),
                          ],
                        )),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Column(
                        children: [
                          ListTile(
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        contact != null
                            ? IconButton(
                                icon: Image.asset('images/Phone.png'),
                                onPressed: () async {
                                  await launch("tel:${contact}");
                                  print(contact);
                                },
                              )
                            : Container(),
                        contact != null
                            ? Text(
                                contact,
                                style: TextStyle(
                                  fontFamily: 'Mitr',
                                ),
                              )
                            : Container(
                                child: Text(
                                'No Contact',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Mitr',
                                ),
                              )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
