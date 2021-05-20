import 'package:flutter/material.dart';
import 'package:himod/post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Comment extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Post"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.chat),
          )
        ],
        leading: TextButton(
            onPressed: () => {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Post()))
                },
            child: Text(
              "Back",
              style: TextStyle(color: Colors.black, fontSize: 13),
            )),
      ),
      body: Column(
        children: [
          Container(
            height: 120.0,
            child: Container(
              color: Colors.grey,
              child: Stack(
                children: [
                  Row(
                    children: <Widget>[
                      Image(
                        image: NetworkImage(
                            'https://www.pngkey.com/png/full/335-3359725_circle-jamba-juiceorangeball-creative2017-08-08t18-woman-drinking.png'),
                        width: 45,
                        height: 45,
                      ),
                      Text(
                        "Wanna Roemrui",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Image(
                            image: NetworkImage(
                                'https://www.pngkey.com/png/full/335-3359725_circle-jamba-juiceorangeball-creative2017-08-08t18-woman-drinking.png'),
                            width: 45,
                            height: 45,
                          ),
                          Text(
                            "Wanna Roemrui",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ลิปสติ๊กสีแดงสด",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "ลิปสติ๊กสีแดงสด ราคา 1000 บาท",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            color: Colors.pink,
            child: Column(
              children: [
                Row(
                  children: [
                    Image(
                      image: NetworkImage(
                          'https://www.pngkey.com/png/full/335-3359725_circle-jamba-juiceorangeball-creative2017-08-08t18-woman-drinking.png'),
                      width: 45,
                      height: 45,
                    ),
                    Text(
                      "Teerachai Wongsripisan",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 200),
                  child: Text("ปังมากพี่นัท"),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          suffix:IconButton(onPressed:()=> Post(), icon : Icon(Icons.send,color: Colors.pink,)),
            hintText: "comment",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(3))),
      ),
    );
  }
}
