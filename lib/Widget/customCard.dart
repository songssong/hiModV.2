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
              trailing: Container(
                padding: EdgeInsets.all(2),
                child: Text(
                  catagory,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(40.0)),
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
