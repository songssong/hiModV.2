import 'package:flutter/material.dart';
import 'package:himod/component/appbar.dart';
import 'package:himod/component/body.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:himod/component/bottombar.dart';
import 'package:himod/postdetail.dart';
import 'package:himod/component/appbar.dart';


class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> with SingleTickerProviderStateMixin {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: _tabList.length);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.comments),
            onPressed: () => {},
          ),
        ],
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.user),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: Container(
            child: TabBar(
              indicatorColor: Colors.black,
              isScrollable: true,
              labelColor: Colors.black,
              controller: _tabController,
              tabs: _tabList,
            ),
          ),
        ),
      ),
      body: Column(
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
                    )),
                // ListView.builder(
                //https://www.youtube.com/watch?v=swI6ROQm3ww&list=WL&index=21&t=1286s
                // )

                // child: Row(
                //   children: <Widget>[
                //     Container(
                //       width: 90.0,
                //       height: 90.0,
                //       margin:
                //           EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                //       child: Stack(
                //         children: <Widget>[
                //           Positioned(
                //             top : 0.0,
                //             left: 0.0,
                //             right: 12.0,
                //             bottom: 12.0,
                //             child: ClipRRect(
                //               borderRadius: BorderRadius.circular(12.0),
                //               // child: Image.asset(backend.xxxx),
                //               child: Image(image: NetworkImage('https://www.yslbeautyth.com/media/catalog/product/cache/6495e6845d1923fbbf69f79e5d373778/t/v/tvc216-3614272942660_2.jpg'),
                //               fit: BoxFit.cover,),
                //             )
                //           )
                //         ],
                //       ),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
          Container(
            height: 120.0,
            margin: EdgeInsets.symmetric(horizontal: 13.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              children: <Widget>[
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
                    IconButton(
                      icon: const Icon(Icons.chat),
                      onPressed: () => print('do not chat e ka toey'),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    height: 120.0,
                  ),
                ),
                Expanded(
                  child: Row(children: <Widget>[
                    Image(
                      image: NetworkImage(
                          'https://www.shiseido.co.th/dw/image/v2/BCSK_PRD/on/demandware.static/-/Sites-itemmaster_shiseido/default/dwd4a76f60/images/products/16427/16427_S_1.jpg'),
                      width: 120,
                      height: 120,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "ลิปสติ๊กสีแดงสด",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "ลิปสติ๊กสีแดงสด ราคา 1000 บาท ซื้อมาแล้วไม่ชอบ แชทมา",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Postdetail()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.yellow[600],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.notes,
                  size: 40.0,
                  color: Colors.white,
                ),
                Icon(
                  Icons.sports_esports,
                  size: 40.0,
                  color: Colors.white,
                ),
                SizedBox.shrink(),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.question,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                Icon(
                  Icons.notifications,
                  size: 40.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
