import 'package:flutter/material.dart';

class TestContainer extends StatelessWidget {
  final String name;

  const TestContainer({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green, child: Text(name));
  }
}
