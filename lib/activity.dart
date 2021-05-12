import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final String name = 'Prang';
  static const name2 = 'Boss';
  num amount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity"),
        backgroundColor: Colors.orange,
        actions: [
          PopupMenuButton<String>(
            offset: Offset(0, 50),
            onSelected: (select) => print("hola $select"),
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.user),
          onPressed: () => Navigator.pushNamed(context, '/post'),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/student'),
            child: Container(
              margin: const EdgeInsets.fromLTRB(50, 50, 50, 50),
              width: 50,
              height: 50,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  )),
              child: Text('Click'),
            ),
          ),
          ExpansionTile(
            collapsedBackgroundColor: Colors.blueAccent,
            title: Text('$name'),
            children: [
              Container(
                color: Colors.blueGrey,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Container(
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Name'),
                        Text('Sun'),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Text('Date 08/09/2021'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
