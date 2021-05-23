import 'package:flutter/cupertino.dart';
import 'package:himod/model/comment_model.dart';
import 'package:himod/service/auth_provider_service.dart';
import 'package:himod/service/firestore_service.dart';
import 'package:uuid/uuid.dart';

class CommentProvider with ChangeNotifier {

  final firestoreService = FirestoreService();

  String _commentText;
  String _commentId;
  String _userId;
  
  var uuid = Uuid();
  var uid = AuthProviderService.instance.user?.uid ?? '';

  //getter
  String get commentText => _commentText;
  
  
  //setter
  changeCommentText(String value){
    _commentText = value;
    notifyListeners();
  }

  saveCommentText(){
    var newComment = CommentModel(commentText: commentText, commentId: uuid.v4(),userId: uid);
    firestoreService.saveComment(newComment);
  }
}