import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:himod/component/body.dart';


class Lostnfound extends StatefulWidget {
  @override
  _LostnfoundState createState() => _LostnfoundState();
}

class _LostnfoundState extends State<Lostnfound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Text("LostandFound"),
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