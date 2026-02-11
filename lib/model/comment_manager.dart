import 'package:test1/model/comment_data.dart';

class CommentManager {
  final List<CommentData> comments = [
    CommentData(comment: "Comment 1", username: "User 1", time: "12:00"),
    CommentData(comment: "Comment 2", username: "User 2", time: "13:00"),
    CommentData(comment: "Comment 3", username: "User 3", time: "14:00"),
    CommentData(comment: "Comment 4", username: "User 4", time: "15:00"),
    CommentData(comment: "Comment 5", username: "User 5", time: "16:00"),
    CommentData(comment: "Comment 6", username: "User 6", time: "17:00"),
    CommentData(comment: "Comment 7", username: "User 7", time: "18:00"),
  ];

  Function(int)? onCommentAdded;

  int get commentCount => comments.length;

  void addComment(CommentData comment) {
    comments.add(comment);
    onCommentAdded?.call(commentCount);
  }
}
