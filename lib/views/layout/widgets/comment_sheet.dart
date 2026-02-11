// Comment Item Widget
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test1/model/comment_data.dart';
import 'package:test1/model/comment_manager.dart';

class CommentSheet extends StatefulWidget {
  final CommentManager commentManager;
  final TextEditingController commentController;
  const CommentSheet({
    super.key,
    required this.commentManager,
    required this.commentController,
  });

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  late final TextEditingController _commentController;
  late final ScrollController _listViewController;
  bool isEnabled = false;
  bool isLoading = false;
  bool hasErrorText = false;
  bool _showScrollButton = false;
  double _sheetHeight = 0;
  double _minHeight = 0;
  double _maxHeight = 0;
  final int _maxLengh = 50;

  String get defaultUsername => 'Tôi';

  void _scrollToBottom() {
    if (_listViewController.hasClients) {
      _listViewController.animateTo(
        _listViewController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _updateScrollButtonVisibility() {
    if (_listViewController.hasClients) {
      final isAtBottom =
          _listViewController.offset >=
          _listViewController.position.maxScrollExtent - 100;
      if (_showScrollButton == isAtBottom) {
        setState(() {
          _showScrollButton = !isAtBottom;
        });
      }
    }
  }

  Future<void> _send() async {
    final commentText = _commentController.text.trim();

    if (commentText.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 800));

    final now = DateTime.now();
    final time =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    final newComment = CommentData(
      username: defaultUsername,
      time: time,
      comment: commentText,
    );

    if (mounted) {
      widget.commentManager.addComment(newComment);

      setState(() {
        _commentController.clear();
        isEnabled = false;
        isLoading = false;
      });

      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    }
  }

  @override
  void initState() {
    super.initState();
    _commentController = widget.commentController;
    _listViewController = ScrollController();
    _listViewController.addListener(_updateScrollButtonVisibility);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_listViewController.hasClients) {
        _listViewController.jumpTo(
          _listViewController.position.maxScrollExtent,
        );
      }
    });
  }

  @override
  void dispose() {
    _listViewController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_sheetHeight == 0) {
      final screenHeight = MediaQuery.of(context).size.height;
      _minHeight = screenHeight * 0.4;
      _maxHeight = screenHeight * 0.95;
      _sheetHeight = screenHeight * 0.5;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          _sheetHeight -= details.delta.dy;
          _sheetHeight = _sheetHeight.clamp(_minHeight, _maxHeight);
        });
      },
      child: Container(
        height: _sheetHeight,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                // Header with drag handle
                MouseRegion(
                  cursor: SystemMouseCursors.resizeRow,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      children: [
                        // Drag handle
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),

                        // Header row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Bình luận ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        widget.commentManager.commentCount
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Close button
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const Divider(height: 1),

                Expanded(
                  child:
                      widget.commentManager.comments.isEmpty
                          ? Center(
                            child: Text(
                              'Không có bình luận nào',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                          )
                          : Stack(
                            children: [
                              ListView.builder(
                                controller: _listViewController,
                                padding: EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  top: 8,
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom +
                                      75,
                                ),
                                itemCount:
                                    widget.commentManager.comments.length,
                                itemBuilder: (context, index) {
                                  return CommentItem(
                                    comment:
                                        widget.commentManager.comments[index],
                                  );
                                },
                              ),
                              if (_showScrollButton)
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 100,
                                  child: Center(
                                    child: FloatingActionButton(
                                      mini: true,
                                      shape: CircleBorder(),
                                      onPressed: _scrollToBottom,
                                      backgroundColor: Colors.purple,
                                      child: const Icon(
                                        Icons.arrow_downward,
                                        color: Colors.white,
                                        size: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                ),
              ],
            ),

            // Comment input mới
            Positioned(
              left: 0,
              right: 0,
              bottom: 12,
              child: Container(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 12,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(1, 3),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _commentController,
                          onChanged: (value) {
                            final hasError = value.length > _maxLengh;
                            final enable = value.isNotEmpty && !hasError && !isLoading;
                            if (enable != isEnabled ||
                                hasError != hasErrorText) {
                              setState(() {
                                isEnabled = enable;
                                hasErrorText = hasError;
                              });
                            }
                          },
                          minLines: 1,
                          maxLines: 3,
                          maxLength: _maxLengh,

                          maxLengthEnforcement: MaxLengthEnforcement.none,
                          decoration: InputDecoration(
                            hintText: 'Viết bình luận...',
                            counterText: '',
                            counter: ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _commentController,
                              builder: (_, value, __) {
                                final length = value.text.length;
                                final isOver = length > _maxLengh;

                                if (!isOver) return const SizedBox.shrink();

                                return Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    '$length / $_maxLengh',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              },
                            ),
                            errorText:
                                hasErrorText
                                    ? 'Đã vượt quá $_maxLengh ký tự'
                                    : null,
                            errorStyle: const TextStyle(color: Colors.red),
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.85),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(1, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon:
                            isLoading
                                ? Center(child: CircularProgressIndicator())
                                : Icon(
                                  Icons.send,
                                  color:
                                      isEnabled
                                          ? Colors.black
                                          : Colors.grey,
                                ),
                        onPressed: isEnabled ? _send : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final CommentData comment;

  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      comment.time,
                      style: TextStyle(color: Colors.grey[600], fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comment.comment,
                  style: const TextStyle(fontSize: 14, height: 1.4),
                ),
              ],
            ),
          ),
          Icon(Icons.more_vert, size: 18, color: Colors.grey[400]),
        ],
      ),
    );
  }
}
