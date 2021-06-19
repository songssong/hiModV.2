class CommentModel {
  final String commentText;
  final String commentId;
  final String userId;
  

  CommentModel({this.commentText,this.commentId,this.userId});

  Map<String,dynamic>toMap(){
    return{
      'commentText' : commentText,
      'commentId' : commentId,
      'uid' : userId,
    };
  }
}