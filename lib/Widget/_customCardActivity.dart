import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomActivity extends StatelessWidget {
  final String nameUser;
  final String dateTime;
  final String nameTitle;
  final String content;
  final String profileImg;
  final int capacity;
  final Function onClick;
  final String catagory;

  const CustomActivity(
      {Key key,
      this.nameUser,
      this.dateTime,
      this.nameTitle,
      this.content,
      this.onClick,
      this.catagory,
      this.profileImg,
      this.capacity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: InkWell(
        onTap: onClick,
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.access_time_sharp,
                      size: 14,
                      color: Colors.grey,
                    ),
                    Text(
                      dateTime,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    child: Image.asset(
                      imgaeActivity(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                child: Text(
                  nameTitle,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Divider(color: Colors.grey[350]),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: Container(
                        child: Text(
                          catagory,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Container(width: 1, color: Colors.grey[350]),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        child: Text(
                          "1/${capacity}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String imgaeActivity() {
    switch (catagory) {
      case "General":
        return 'images/General.png';
        break;
      case "Sports":
        return 'images/Sports.png';
        break;
      case "Games":
        return 'images/Game.png';
        break;
      case "Study":
        return 'images/Study.png';
        break;
      default:
        return 'images/Other.png';
    }
  }
}