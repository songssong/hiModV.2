import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:himod/component/body.dart';


class Noti extends StatefulWidget {
  @override
  _NotiState createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Text("Notification"),
            backgroundColor: Colors.orange,
            actions: [
                IconButton(icon: FaIcon(FontAwesomeIcons.comments), 
                onPressed: () => {} ,
                ),],
                leading: IconButton(icon: FaIcon(FontAwesomeIcons.user), 
                onPressed: () => {}),
              
    ),
    body: Body(),
    );
  }
}