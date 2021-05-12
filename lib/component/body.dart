import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  List<Tab> _tabList = [
    Tab(
      child: Text("General"),
    ),
    Tab(
      child: Text("Promote"),
    ),
    Tab(
      child: Text("Goods"),
    ),
    Tab(
      child: Text("Club"),
    ),
  ];

  TabController _tabController;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          height: size.height * 0.12,
          child: Stack(
            children: <Widget>[
              Container(
                height: size.height * 0.12 - 27,
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
              ),
              Positioned(
                  bottom: 35,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: 30, bottom: 0, left: 120, right: 5),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Colors.orange.withOpacity(0.23),
                          )
                        ]),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Colors.orange.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ))
            ],
          ),
        )
      ],
    );
    //  TabBarView(
    //     controller: _tabController,
    //     children: [
    //       Padding(
    //         padding: EdgeInsets.all(8.0),
    //         child: Container(),
    //       ),
    //        Padding(
    //         padding: EdgeInsets.all(8.0),
    //         child: Container(),
    //       ),
    //        Padding(
    //         padding: EdgeInsets.all(8.0),
    //         child: Container(),
    //       ),
    //        Padding(
    //         padding: EdgeInsets.all(8.0),
    //         child: Container(),
    //       ),
    //     ],
    //   );
  }
}
