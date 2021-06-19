import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:himod/model/comment_model.dart';
import 'package:himod/model/student_model.dart';
import 'package:himod/service/auth_provider_service.dart';

class FirestoreService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String uid = AuthProviderService.instance.user?.uid ?? '';

  Future<void> saveComment(CommentModel comment) {
    return db.collection('Comment').doc(comment.commentId).set(comment.toMap());
  }
  
}
