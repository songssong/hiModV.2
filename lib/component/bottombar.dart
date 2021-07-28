import 'package:flutter/material.dart';
import 'package:himod/LostAndFound/lostandfound_screen.dart';
import 'package:himod/activity.dart';
import 'package:himod/notification.dart';
import 'package:himod/post.dart';


class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentTab = 0;
  final List<Widget> screens = [
    Post(),
    Activity(),
    LostAndFoundScreen(),
    Noti(),
  ];

  Widget currentScreen = Post();

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.orangeAccent,
        onPressed: () {},

      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          child: Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Post();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.post_add, color: currentTab == 0 ? Colors.blue : Colors.grey ,),
                        Text('Post', style: TextStyle(color: currentTab == 0 ? Colors.blue : Colors.grey ,),)
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
