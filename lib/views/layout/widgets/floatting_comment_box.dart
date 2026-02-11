import 'package:flutter/material.dart';
import 'package:test1/views/layout/widgets/comment_sheet.dart';
import 'package:test1/model/comment_manager.dart';

class FloatCommentBox extends StatelessWidget {
  final TextEditingController commentController;
  final CommentManager commentManager;
  final VoidCallback onSend;
  
  void _showCommentsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      scrollControlDisabledMaxHeightRatio: MediaQuery.of(context).size.height,
      useSafeArea: true,
      builder:
          (context) => CommentSheet(
            commentManager: commentManager,
            commentController: commentController,
          ),
    );
  }

  const FloatCommentBox({
    super.key,
    required this.commentController,
    required this.commentManager,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(1, 3),
                ),
              ],
            ),
            child: TextField(
              controller: commentController,
              decoration: const InputDecoration(
                hintText: 'Viết bình luận...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
        const SizedBox(width: 12),

        GestureDetector(
          onTap: () => _showCommentsSheet(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(1, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.chat_bubble, size: 18),
                const SizedBox(width: 6),
                Text(
                  '${commentManager.commentCount}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
