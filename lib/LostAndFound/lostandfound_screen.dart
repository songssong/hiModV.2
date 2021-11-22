import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:himod/LostAndFound/component/body_found.dart';
import 'package:himod/LostAndFound/component/body_lost.dart';
import 'package:himod/service/auth_provider_service.dart';

class MyTabView {
  final String titleName;
  final Widget screen;
  MyTabView(this.titleName, this.screen);
}

class LostAndFoundScreen extends StatefulWidget {
  LostAndFoundScreen({Key key}) : super(key: key);

  @override
  _LostAndFoundScreenState createState() => _LostAndFoundScreenState();
}

enum Type { All, General, Electric, Education, Other }

class _LostAndFoundScreenState extends State<LostAndFoundScreen>
    with SingleTickerProviderStateMixin {
  String _value = "";
  String _filter = '';
  
  void _setValue(String value) => setState(() => _value = value);

  Future _askuser() async {
    print(_tabController.index);
    if (_tabController.index == 0) {
      _asklost();
      //initiateSearch(name);
    }
    if (_tabController.index == 1) {
      _askfound();
    }
  }

  Future _askfound() async {
    // print('ask found');
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select category'),
            children: <Widget>[
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  Navigator.pop(context, Type.All);
                },
                child: const Text(
                  'All',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  Navigator.pop(context, Type.General);
                },
                child: const Text(
                  'General',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  Navigator.pop(context, Type.Electric);
                },
                child: const Text(
                  'Electric',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  Navigator.pop(context, Type.Education);
                },
                child: const Text(
                  'Education',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  Navigator.pop(context, Type.Other);
                },
                child: const Text(
                  'Other',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        })) {
      case Type.All:
        setState(() {
          _filter = '';
        });
        _setValue('');
        break;
      case Type.General:
        setState(() {
          _filter = 'General';
        });
        _setValue('General');
        break;
      case Type.Electric:
        setState(() {
          _filter = 'Electric';
        });
        _setValue('Electric');
        break;
      case Type.Education:
        setState(() {
          _filter = 'Education';
        });
        _setValue('Education');
        break;
      case Type.Other:
        setState(() {
          _filter = 'Other';
        });
        _setValue('Other');
        print(_value);
        break;
    }
  }
  




  Future _asklost() async {
    // print('ask lost');
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select category'),
            children: <Widget>[
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  Navigator.pop(context, Type.All);
                },
                child: const Text(
                  'All',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  Navigator.pop(context, Type.General);
                },
                child: const Text(
                  'General',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  Navigator.pop(context, Type.Electric);
                },
                child: const Text(
                  'Electric',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  Navigator.pop(context, Type.Education);
                },
                child: const Text(
                  'Education',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                onPressed: () {
                  Navigator.pop(context, Type.Other);
                },
                child: const Text(
                  'Other',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        })) {
      case Type.All:
        setState(() {
          _filter = '';
        });
        _setValue('');
        break;
      case Type.General:
        setState(() {
          _filter = 'General';
        });
        _setValue('General');
        break;
      case Type.Electric:
        setState(() {
          _filter = 'Electric';
        });
        _setValue('Electric');
        break;
      case Type.Education:
        setState(() {
          _filter = 'Education';
        });
        _setValue('Education');
        break;
      case Type.Other:
        setState(() {
          _filter = 'Other';
        });
        _setValue('Other');
        print(_value);
        break;
    }
  }

  List<MyTabView> _myTabViews = [];
  TabController _tabController;

  @override
  void initState() {
    _myTabViews.add(MyTabView(
        'LOST',
        BodyLost(
          type_filter: _filter,
          name: name,
        )));
    _myTabViews.add(
      MyTabView(
          'FOUND',
          BodyFound(
            type_filter: _filter,
            name : name,
          )),
    );

    _tabController = TabController(vsync: this, length: _myTabViews.length);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  

  @override
  Icon customIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );
  Icon customIcon2 = const Icon(
    Icons.cancel,
    color: Colors.white,
  );
  Widget customSearchBar = const Text(
    'LostAndFound',
    style: TextStyle(color: Colors.white),
  );
  String name = "";
  DateTime dateTime;
  
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
             title: customSearchBar,
            centerTitle: true,
            leading: IconButton(
              onPressed: _askuser,
              icon: Icon(
                Icons.filter_list_alt,
                color: Colors.white,
                size: 30,
              ),
            ),
          
            flexibleSpace: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: [
                    const Color(0xffff9e23),
                    const Color(0xffff711b),
                    const Color(0xffff4814),
                  ],
                ),
              ),
            ),


           automaticallyImplyLeading: false,
        actions: [
          IconButton(
            //  icon: const Icon(Icons.search),
            onPressed: () {
               if (customIcon2.icon == Icons.cancel)
                   name= "";
              setState(() {
                if (customIcon.icon == Icons.search) {
                 
                  customIcon = Icon(
                    Icons.cancel,
                    color: Colors.white,
                  
                  );
                  
                  customSearchBar = ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.grey[200],
                      size: 28,
                    ),
                    title: TextField(
                      onChanged: (val) => initiateSearch(val),
                      decoration: InputDecoration(
                        hintText: 'search',
                        hintStyle: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                } else {
                  customIcon = Icon(
                    Icons.search,
                    color: Colors.white,
                  );
                  customSearchBar = Text(
                    'LostAndFound',
                    style: TextStyle(
                        fontFamily: 'Mitr',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  );
                }
              });
            },
            icon: customIcon,
          ),
        ],
      ),
          body: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Container(
                child: Stack(
                  children: [
                    TabBar(
                      controller: _tabController,
                      labelColor: Color(0xffff4814),
                      indicatorColor: Color(0xffff4814),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 2,
                      unselectedLabelColor: Colors.black,
                      tabs: _myTabViews.map((e) {
                        return Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("${e.titleName}"),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            body: Stack(
              children: [
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 5,
                          offset: Offset(0, 0.8)),
                    ],
                  ),
                ),
                TabBarView(
                  controller: _tabController,
                  children: [
                    MyTabView(
                        'LOST',
                        BodyLost(
                          type_filter: _filter,
                          name :name
                        )).screen,
                    MyTabView(
                        'FOUND',
                        BodyFound(
                          type_filter: _filter,
                          name : name,
                        )).screen,
                  ],
                )
              ],
            ),
          )),
    );
  }
  void initiateSearch(String val) {
    setState(() {
      name = val.toLowerCase().trim();
    });
  }
}
