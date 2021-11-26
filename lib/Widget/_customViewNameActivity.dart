import 'package:flutter/material.dart';

class CustomViewName extends StatelessWidget {
  final List<String> nameUserJoin;
  const CustomViewName({Key key, this.nameUserJoin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: nameUserJoin.isEmpty
                ? Container()
                : Container(
                    width: double.infinity,
                    height: 200,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("รายชื่อผู้เข้าร่วม",
                                      style: TextStyle(
                                          fontFamily: 'Mitr',
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: nameUserJoin.length,
                                itemBuilder: (context, index) {
                                  return Text(
                                    nameUserJoin[index],
                                    style: TextStyle(
                                      fontFamily: 'Mitr',
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
      ],
    );
  }
}
