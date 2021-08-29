import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:himod/LostAndFound/component/body_found.dart';

class LostAndFoundScreen extends StatefulWidget {
  LostAndFoundScreen({Key key}) : super(key: key);

  @override
  _LostAndFoundScreenState createState() => _LostAndFoundScreenState();
}

class _LostAndFoundScreenState extends State<LostAndFoundScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.search)),
                Tab(icon: Icon(Icons.directions_transit)),
              ],
            ),
            centerTitle: true,
            title: const Text("LostAndFound"),
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
          body: SafeArea(
            child: TabBarView(
              children: <Widget>[
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: BodyLostAndFound(),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        new Text(
                          "data",
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            
          ),
        ),
      ),
    );
  }
}
