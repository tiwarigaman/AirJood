import 'package:airjood/res/components/color.dart';
import 'package:airjood/view/navigation_view/community_view/post_inquiry_screen.dart';
import 'package:airjood/view/navigation_view/community_view/widgets/stack_container_widget.dart';
import 'package:airjood/view/navigation_view/home_screens/component/read_more_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommunityDetailsScreen extends StatefulWidget {
  const CommunityDetailsScreen({super.key});

  @override
  State<CommunityDetailsScreen> createState() => _CommunityDetailsScreenState();
}

class _CommunityDetailsScreenState extends State<CommunityDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      constraints: BoxConstraints.expand(
                          height: MediaQuery.of(context).size.height * 0.90,
                          width: MediaQuery.of(context).size.width),
                      isScrollControlled: true,
                      builder: (_) => const PostInquiryScreen(),
                    );
                  },
                  child: const StackContainerWidget(),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: CustomReadMoreText(
                    content:
                        'Lorem ipsum dolor sit amet consectetur. Enim justo tellus odio vitae ullamcorper adipiscing est. Phasellus proin non orci consectetur. Id sit lectus morbi nulla Tristique.',
                    color: AppColors.secondTextColor,
                    mColor: AppColors.mainColor,
                    rColor: AppColors.mainColor,
                    trimLines: 3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
