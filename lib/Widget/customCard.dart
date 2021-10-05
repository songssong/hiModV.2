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
  final String catagory;

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
      this.color,
      this.catagory, //สี
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
            new ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(profileImg)),
              title: Text(nameUser) != null ? Text(nameUser) : 'name',
              subtitle: Text(dateTime),
              trailing: Text(
                catagory,
                style: TextStyle(
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1
                    ..color = Colors.orange,
                  fontSize: 10,
                  letterSpacing: 1.5,
                  height: 1,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
                child: contentImg != null
                    ? Image(
                        image: NetworkImage(contentImg),
                        width: 300,
                        fit: BoxFit.cover,
                      )
                    : Container()),
            ListTile(
              title: Text(nameTitle) ?? "",
              subtitle: Text(content) ?? "",
            ),
          ],
        ),
      ),
    );
  }
}
