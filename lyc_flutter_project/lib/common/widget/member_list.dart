import 'package:flutter/material.dart';
import 'package:lyc_flutter_project/common/widget/round_image.dart';

class MemberList extends StatelessWidget {
  final String profile;
  final String nickname;
  final String id;
  final String? content;
  final Widget? button;

  const MemberList({
    super.key,
    required this.profile,
    required this.nickname,
    required this.id,
    this.button,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14.0),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RoundImage(
                  image: Image.asset(
                    profile,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 4.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        nickname,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "@$id",
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  if (content != null)
                    Text(
                      content!,
                      style: TextStyle(
                        fontSize: 12.0,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ],
          ),
          if (button != null) button!,
        ],
      ),
    );
  }
}
