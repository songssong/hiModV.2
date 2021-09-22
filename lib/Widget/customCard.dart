import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String nameUser;
  final String dateTime;
  final String nameTitle;
  final String content;
  final String profileImg;
  final String contentImg;
  final double width;
  final double height;
  final Color color;
  final Function onClick;

  const CustomCard(
      {Key key,
      this.nameUser,
      this.dateTime,
      this.nameTitle,
      this.content,
      this.profileImg,
      this.contentImg,
      this.width, //ความกว้างของ Card
      this.height, //ความสูงของ Card
      this.color, //สี
      this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: InkWell(
        onTap: onClick,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(profileImg != null
                    ? NetworkImage(profileImg)
                    : 'https://shortrecap.co/wp-content/uploads/2020/05/Catcover_web.jpg'
                        .toString()),
              ),
              title: Text(nameUser ?? ""),
              subtitle: Text(dateTime),
            ),
            Padding(
                padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
                child: contentImg != null
                    ? Image(image: NetworkImage(contentImg))
                    : Container()),
            ListTile(
              title: Text(nameTitle),
              subtitle: Text(content),
            ),
          ],
        ),
      ),
    );
  }
}
