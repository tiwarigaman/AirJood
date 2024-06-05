import 'package:airjood/view/navigation_view/community_view/add_community_screen.dart';
import 'package:airjood/view/navigation_view/community_view/community_details_screen.dart';
import 'package:airjood/view/navigation_view/community_view/widgets/list_container_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';
import '../../../res/components/maintextfild.dart';
import '../../../view_model/user_view_model.dart';
import '../home_screens/sub_home_screens/user_details_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  void initState() {
    super.initState();
    UserViewModel().getUser().then((value) {
      image = value?.profileImageUrl;
      setState(() {});
    });
  }

  String? image;
  String? images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height * 0.90,
                width: MediaQuery.of(context).size.width),
            isScrollControlled: true,
            builder: (_) => const AddCommunityScreen(),
          );
        },
        child: Container(
          height: 56,
          width: 56,
          margin: const EdgeInsets.only(bottom: 80),
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(
            Icons.add,
            color: AppColors.whiteColor,
            size: 30,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        actions: [
          const SizedBox(
            width: 20,
          ),
          const CustomText(
            data: 'Community',
            fSize: 22,
            fweight: FontWeight.w700,
            fontColor: AppColors.blackColor,
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserDetailsScreen(
                    screen: 'MyScreen',
                  ),
                ),
              ).then((value) {
                UserViewModel().getUser().then((value) {
                  images = value?.profileImageUrl;
                  // widget.getImage!(value?.profileImageUrl);
                  setState(() {});
                });
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: '$image',
                fit: BoxFit.cover,
                height: 40,
                width: 40,
                errorWidget: (context, url, error) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://airjood.neuronsit.in/storage/profile_images/TOAeh3xMyzAz2SOjz2xYu7GvC2yePHMqoTKd3pWJ.png',
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              const MainTextFild(
                hintText: 'Search Community...',
                maxLines: 1,
                prefixIcon: Icon(
                  Icons.search_sharp,
                  color: AppColors.textFildHintColor,
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CommunityDetailsScreen(),
                        ),
                      );
                    },
                    child: const ListContainerWidget(),
                  );
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
