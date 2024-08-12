import 'package:flutter/material.dart';
import 'package:lyc_flutter_project/common/widget/member_list.dart';
import 'package:lyc_flutter_project/data/app_color.dart';
import 'package:lyc_flutter_project/director/widget/active_state.dart';
import 'package:lyc_flutter_project/director/widget/custom_search_bar.dart';
import 'package:lyc_flutter_project/screens/home_screen.dart';
import 'package:lyc_flutter_project/styles/default_padding.dart';
import 'package:lyc_flutter_project/widget/switch_category_button.dart';

class DirectorSearchScreen extends StatefulWidget {
  const DirectorSearchScreen({super.key});

  @override
  State<DirectorSearchScreen> createState() => _DirectorSearchScreenState();
}

class _DirectorSearchScreenState extends State<DirectorSearchScreen> {
  bool isNormal = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.lightGrey,
      appBar: const HomeAppbar(),
      body: DefaultPadding(
        bottom: 0,
        child: Column(
          children: [
            const CustomSearchBar(),
            const SizedBox(height: 16.0),
            renderButtons(),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return const MemberList(
                    profile: "assets/ex_profile.png",
                    nickname: "karina",
                    id: "katarinabluu",
                    content: "선호 패션: ",
                    button: ActiveState(),
                  );
                },
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }

  Container renderButtons() {
    return Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Row(
              children: [
                SwitchCategoryButton(
                  "일반검색",
                  isNormal,
                  () => setState(() {
                    isNormal = true;
                  }),
                  AppColor.brown,
                ),
                SwitchCategoryButton(
                  "키워드검색",
                  !isNormal,
                  () => setState(() {
                    isNormal = false;
                  }),
                  AppColor.brown,
                ),
              ],
            ),
          );
  }
}
