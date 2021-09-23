import 'package:flutter/material.dart';
import 'package:himod/post.dart';

import 'LostAndFound/lostandfound_screen.dart';
import 'Profile/profile_screen.dart';
import 'lostnfounddetail.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  int currentIndex = 0;
  final screens = [
    Post(),
    Center(child: Text('Activity', style: TextStyle(fontSize: 55))),
    LostAndFoundScreen(),
    Center(child: Text('Notification', style: TextStyle(fontSize: 55))),
    ProfileScreen(),
  ];
  List<Widget> _screen = [
    Post(),
    Center(child: Text('Activity', style: TextStyle(fontSize: 55))),
    LostAndFoundScreen(),
    lostnfounddetail(),
    // Center(child: Text('Notification', style: TextStyle(fontSize: 55))),
    ProfileScreen(),
  ];

  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _itemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: _createBottomNavigationBar(),
    );
  }

  Widget _createBottomNavigationBar() {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            const Color(0xffff9e23),
            const Color(0xffff711b),
            const Color(0xffff4814),
          ],
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        showSelectedLabels: true,
        backgroundColor: Colors.transparent,
        showUnselectedLabels: false,
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("images/Home.png")),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("images/Activity.png")),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("images/Mod.png")),
            label: 'Lost&Found',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("images/Notification.png")),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("images/user.png")),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
            // bottomNavigationBar: BottomNavigationBar(
            //   type: BottomNavigationBarType.fixed,
            //   backgroundColor: Colors.red,
            //   selectedItemColor: Colors.white,
            //   showSelectedLabels: false,
            //   showUnselectedLabels: false,
            //   onTap: _itemTapped,
            //   items: [
            //     BottomNavigationBarItem(
            //       icon: ImageIcon(AssetImage("images/Home.png")),
            //       label: 'Home',
            //       backgroundColor: Colors.orange,
            //     ),
            //     BottomNavigationBarItem(
            //       icon: ImageIcon(AssetImage("images/Activity.png")),
            //       label: 'Activity',
            //       backgroundColor: Colors.orange,
            //     ),
            //     BottomNavigationBarItem(
            //       icon: ImageIcon(AssetImage("images/Mod.png")),
            //       label: 'Lost&Found',
            //       backgroundColor: Colors.orange,
            //     ),
            //     BottomNavigationBarItem(
            //       icon: ImageIcon(AssetImage("images/Notification.png")),
            //       label: 'Notification',
            //       backgroundColor: Colors.orange,
            //     ),
            //     BottomNavigationBarItem(
            //       icon: ImageIcon(AssetImage("images/user.png")),
            //       label: 'User',
            //       backgroundColor: Colors.orange,
            //     ),
            //   ],
            // )
