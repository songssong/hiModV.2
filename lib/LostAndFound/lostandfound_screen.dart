import 'package:flutter/material.dart';
import 'package:himod/LostAndFound/component/body_lostandfound.dart';

class LostAndFoundScreen extends StatefulWidget {
  LostAndFoundScreen({Key key}) : super(key: key);

  @override
  _LostAndFoundScreenState createState() => _LostAndFoundScreenState();
}

class _LostAndFoundScreenState extends State<LostAndFoundScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyLostAndFound(),
    );
  }
}