import 'package:flutter/material.dart';
import 'package:test1/views/layout/widgets/floatting_comment_box.dart';
import 'package:test1/model/comment_manager.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return LayoutState();
  }
}

class LayoutState extends State<LayoutScreen> {
  bool isLiked = false;
  int likeCount = 376;
  late CommentManager commentManager;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    commentManager = CommentManager();
    // Lắng nghe khi có comment mới được thêm
    commentManager.onCommentAdded = (newCount) {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Bài viết',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
                bottom: 100.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Text(
                    "Kiếm Lai | Giới thiệu, Thiết lập, Nhân vật và Đánh giá",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Category badge and date
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF9C27B0), Color(0xFF3F51B5)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'VIP12',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '15:29',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Kiếm Lai (剑来 – Jian Lai – Sword Of Coming) là một tiểu thuyết mạng tiên hiệp cổ điển dài tập của tác giả Phong Hỏa Hí Chư Hầu, chủ yếu kể về Trần Bình An, một thiếu niên ở ngõ Bùn Chai, thị trấn trong Lệ Châu động thiên, sau khi mồ côi cha mẹ từ năm 5 tuổi, đã phải vật lộn để kiếm sống, từ việc học việc ở lò rồng làm đồ gốm sứ, đến khi được Tề Tĩnh Xuân (đồ đệ của Văn Thánh) chọn làm người thay sư phụ thu nhận đồ đệ, cậu không ngừng du lịch khắp thiên hạ, nâng cao thực lực của bản thân, từng bước trưởng thành thành đệ tử ruột đắc ý của Văn Thánh, ẩn quan cuối cùng của Kiếm Khí Trường Thành, tông chủ của Lạc Phách sơn',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://thuvienanime.net/wp-content/uploads/2023/03/kiem-lai-sword-of-coming-thuvienanime-thumb-1024x656.jpg',
                      width: double.infinity,
                      height: 280,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 280,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image,
                            size: 80,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Article content - Paragraph 3
                  const Text(
                    'Tháng 8 năm 2017, Himalaya bắt đầu phát sóng sách nói Kiếm Lai: Thượng, tính đến ngày 8 tháng 4 năm 2023, sách nói này đạt 9,5 điểm, với hơn 1,3 tỷ lượt phát.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Link
                  Text(
                    'https://thuvienanime.net/kiem-lai/',
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),

          // Floating Comment Box - luôn hiển thị ở dưới cùng
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: FloatCommentBox(
              commentManager: commentManager,
              commentController: _commentController,
              onSend: () {
                if (_commentController.text.trim().isNotEmpty) {
                  _commentController.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
