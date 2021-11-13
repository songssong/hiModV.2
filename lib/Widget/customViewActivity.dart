import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomViewActivity extends StatelessWidget {
  final String nameUser;
  final String profileImg;
  final String select_date;
  final String select_time;
  final String timeStamp;
  final String nameTitle;
  final String content;
  final String contact;
  final String category;
  final int capacity;
  final Function onClick;
  const CustomViewActivity(
      {Key key,
      this.nameUser,
      this.profileImg,
      this.select_date,
      this.select_time,
      this.timeStamp,
      this.nameTitle,
      this.content,
      this.category,
      this.capacity,
      this.onClick,
      this.contact})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          // Custom Card for Activity
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 6,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(profileImg) ?? ""),
                  title: Text(nameUser) ?? "",
                  subtitle: Text(timeStamp),
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
                    padding: const EdgeInsets.all(1.0),
                    child: ListTile(
                      title: Text(
                            nameTitle,
                            textScaleFactor: 1.5,
                          ) ??
                          "",
                      subtitle: Text(
                            content,
                            style: TextStyle(fontSize: 16),
                          ) ??
                          "",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(17, 10, 20, 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Text(
                          //   "Start-Date : ",
                          // ),
                          Icon(Icons.date_range_outlined),
                          SizedBox(
                            width: 1,
                          ),
                          Text("${select_date}"),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          // Text(
                          //   "Start-Date : ",
                          // ),
                          Icon(Icons.access_time),
                          SizedBox(
                            width: 1,
                          ),
                          Text("${select_time}"),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          // Text(
                          //   "Capacity : ",
                          // ),
                          Icon(Icons.people_alt_rounded),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                              "1/${capacity}"), //ดึงจำนวนคนที่ join มาใส่ข้างหน้า แทนค่าแทนเลข 1
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          // Text(
                          //   "Capacity : ",
                          // ),
                          contact != null ? Icon(Icons.phone) : Container(),
                          SizedBox(
                            width: 1,
                          ),
                          contact != null
                              ? InkWell(
                                  onTap: () async {
                                    await launch("tel:${contact}");
                                    print(contact);
                                  },
                                  child: Text(
                                    contact,
                                    style: TextStyle(color: Colors.blue[900]),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
