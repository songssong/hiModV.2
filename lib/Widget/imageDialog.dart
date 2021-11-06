import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String contentImg;

  ImageDialog({Key key, this.contentImg}) : super(key: key);

  final _transformationController = TransformationController();
  TapDownDetails _doubleTapDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: _handleDoubleTapDown,
      onDoubleTap: _handleDoubleTap,
      child: Dialog(
        elevation: 1,
        insetPadding: EdgeInsets.all(1.0),
        child: ClipRRect(
          child: InteractiveViewer(
            transformationController: _transformationController,
            panEnabled: false,
            scaleEnabled: true,
            maxScale: 20,
            child: Image(
              image: contentImg != null ? NetworkImage(contentImg) : "",
              // fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
      // backgroundColor: Colors.black,
    );
  }
  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }
  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);
    }
  }
}
