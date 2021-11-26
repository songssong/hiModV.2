import 'package:flutter/material.dart';

class BodyComment extends StatelessWidget {
  final String nameUser;
  final String profileImg;
  final String dateTime;
  final String content;
  final String category;

  const BodyComment({
    Key key,
    this.nameUser,
    this.profileImg,
    this.dateTime,
    this.content,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: [
              Container(
                // shape: RoundedRectangleBorder(
                //     borderRadius:
                //         BorderRadius.circular(15)),
                // elevation: 1,
                color: Colors.grey[100],
                child: ListTile(
                  leading: SizedBox(
                    height: 150,
                    child: CircleAvatar(
                      backgroundImage: profileImg != null
                          ? NetworkImage(profileImg)
                          : Container(),
                    ),
                  ),
                  title: nameUser != null
                      ? Text(
                          nameUser,
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Mitr',
                              fontWeight: FontWeight.bold),
                        )
                      : Container(),
                  subtitle: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: content != null
                        ? Text(
                            "$content",
                            style: TextStyle(
                              fontFamily: 'Mitr',
                              fontSize: 16,
                            ),
                          )
                        : Container(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
