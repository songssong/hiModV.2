import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:himod/model/comment_model.dart';
import 'package:himod/model/comment_validation.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:himod/service/firestore_service.dart';
import 'package:uuid/uuid.dart';

class CommentProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  // String _commentText;
  String _commentId;
  String _userId;
  var uuid = Uuid();
  var uid = AuthProviderService.instance.user?.uid ?? '';
  ValidationItem _commentText = ValidationItem(null, null);

  //getter
  ValidationItem get commentText => _commentText;
  bool get isValid {
    if (_commentText.value != null) {
      return true;
    }
    return false;
  }

  //setter
  changeCommentText(String value) {
    if (value.isEmpty || value.length == 0) {
      _commentText = ValidationItem(null, "Pls Enter Text");
    } else {
      _commentText = ValidationItem(value, null);
    }
    notifyListeners();
  }

  saveCommentText() {
    var newComment = CommentModel(
        commentText: commentText.value, commentId: uuid.v4(), userId: uid);
    firestoreService.saveComment(newComment);
  }
}
