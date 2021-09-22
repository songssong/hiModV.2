import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:himod/LostAndFound/component/body_found.dart';
import 'package:himod/LostAndFound/component/body_lost.dart';

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

class _LostAndFoundScreenState extends State<LostAndFoundScreen>
    with SingleTickerProviderStateMixin {
  List<MyTabView> _myTabViews = [];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _myTabViews.add(MyTabView('LOST', BodyLost()));
    _myTabViews.add(
      MyTabView('FOUND', BodyFound()),
    );

    _tabController = TabController(vsync: this, length: _myTabViews.length);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "LostAndFound",
              style: TextStyle(color: Colors.white),
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
                  children: _myTabViews.map((e) => e.screen).toList(),
                ),
              ],
            ),
          )),
    );
  }
}
