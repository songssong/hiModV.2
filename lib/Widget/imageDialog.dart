import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String contentImg;

  const ImageDialog({Key key, this.contentImg}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Dialog(
        elevation: 6,
        insetPadding: EdgeInsets.all(8.0),
        child: ClipRRect(
          child: Image(
            image: contentImg != null ? NetworkImage(contentImg) : "",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
