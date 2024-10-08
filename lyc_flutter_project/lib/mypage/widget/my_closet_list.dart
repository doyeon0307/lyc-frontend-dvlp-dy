import 'package:flutter/material.dart';
import 'package:lyc_flutter_project/mypage/model/mypage_posting_preview.dart';
import 'package:lyc_flutter_project/mypage/widget/closet_element.dart';
import 'package:lyc_flutter_project/posting/screen/add_clothes_posting_screen.dart';
import 'package:lyc_flutter_project/posting/screen/posting_detail_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class MyClosetList extends StatelessWidget {
  final List<ClosetPostingPreview> postings;

  const MyClosetList({super.key, required this.postings});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: postings.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return GestureDetector(
            onTap: () => pushWithoutNavBar(
              context,
              MaterialPageRoute(
                builder: (context) => const AddClothesPostingScreen(),
              ),
            ),
            child: const ClosetElement(
              title: "옷 추가",
              image: "",
              isFst: true,
            ),
          );
        } else {
          final posting = postings[index - 1];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PostingDetailScreen(
                    id: posting.clothesId,
                    isCloset: true,
                    isMyposting: true,
                  );
                },
              ),
            ),
            child: ClosetElement(
              title: posting.title,
              image: posting.image,
            ),
          );
        }
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16.0);
      },
    );
  }
}
