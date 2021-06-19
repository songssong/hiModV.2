import 'package:flutter/material.dart';
import 'package:himod/Comment/component/body_comment.dart';

class CommentScreen extends StatefulWidget {
  CommentScreen({Key key}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: BodyComment(),
    );
  }
}