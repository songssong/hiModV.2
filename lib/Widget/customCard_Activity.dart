import 'package:flutter/material.dart';

class CustomActivity extends StatelessWidget {
  final String nameUser;
  final String dateTime;
  final String nameTitle;
  final String content;
  final String profileImg;
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
      this.profileImg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: InkWell(
        onTap: onClick,
        child: Container(
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImg),
                ),
                Text(dateTime),
              ],
            ),
          
          ),
        ),
      ),
    );
  }
}
