import 'package:flutter/material.dart';
import 'package:test1/views/layout/widgets/comment.dart';
import 'package:test1/views/layout/widgets/tag.dart';

import 'widgets/action_tag.dart';

class LayoutState extends StatefulWidget {
  const LayoutState({super.key});

  @override
  LayoutScreen createState() => LayoutScreen();
}

class LayoutScreen extends State<LayoutState> {
  bool isEnable = false;

  @override
  Widget build(BuildContext context) {
    final String data = 'hello' * 6;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //header
            Row(
              crossAxisAlignment: data.length > 30 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
              children: [
                const CircleAvatar(radius: 22, backgroundImage: NetworkImage('https://i.pravatar.cc/150')),
                const SizedBox(width: 12),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(data.toString(), style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isEnable ? Colors.deepPurple : Colors.purple.shade50.withValues(alpha: 0.8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onPressed: () {
                    setState(() {
                      isEnable = !isEnable;
                    });
                  },
                  child: Text('hello', style: TextStyle(color: isEnable ? Colors.white : Colors.deepPurple)),
                ),
              ],
            ),
            const SizedBox(height: 25),
            //tags
            const Tags(),
            const SizedBox(height: 15),
            //action
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const ActionTag(label: 'Share'),
                const SizedBox(width: 10),
                const ActionTag(label: 'Share'),
              ],
            ),
            const SizedBox(height: 30),
            //comment box
            CommentBox(),
          ],
        ),
      ),
    );
  }
}
