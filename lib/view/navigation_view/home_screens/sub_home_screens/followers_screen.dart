import 'package:airjood/res/components/maintextfild.dart';
import 'package:airjood/view_model/follow_view_model.dart';
import 'package:airjood/view_model/followers_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/response/status.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/custom_shimmer.dart';
import '../../../../view_model/user_view_model.dart';
import 'experience_screens/reels_user_detail_screen.dart';

class FollowersScreen extends StatefulWidget {
  final int? userId;

  const FollowersScreen({super.key, this.userId});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  void initState() {
    UserViewModel().getToken().then((value) {
      Provider.of<FollowersViewModel>(context, listen: false)
          .followerGetApi(value!, widget.userId!);
    });
    super.initState();
  }

  bool follow = false;
  Map<int, bool> followStates = {};
  handleFollowers(int userId) {
    bool isFollowing =
        followStates[userId] ?? false; // Get current follow state
    bool newFollowState = !isFollowing; // Toggle the follow state
    UserViewModel().getToken().then((token) async {
      await Provider.of<FollowViewModel>(context, listen: false).followApi(
        token!,
        userId,
        newFollowState,
        context,
      );
      setState(() {
        followStates[userId] =
            newFollowState; // Update follow state for this user
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        actions: [
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 35,
              weight: 2,
            ),
          ),
          CustomText(
            data:
                'Followers (${Provider.of<FollowersViewModel>(context).followerData.data?.data?.length ?? 0})',
            fSize: 20,
            fweight: FontWeight.w700,
            fontColor: AppColors.blackColor,
          ),
          const Spacer(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            children: [
              const MainTextFild(
                hintText: 'Search People...',
                prefixIcon: Icon(
                  Icons.search_sharp,
                  color: AppColors.textFildHintColor,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<FollowersViewModel>(
                builder: (context, value, child) {
                  switch (value.followerData.status) {
                    case Status.LOADING:
                      return const FollowersShimmer();
                    case Status.ERROR:
                      return const FollowersShimmer();
                    case Status.COMPLETED:
                      return ListView.builder(
                        itemCount: value.followerData.data?.data?.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var data = value.followerData.data?.data?[index];
                          int userId = data?.createdBy?.id ?? 0; // Get user ID

                          bool isFollowing = followStates[userId] ?? false;
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReelsUserDetailScreen(
                                      about: data?.createdBy?.about,
                                      image: data?.createdBy?.profileImageUrl,
                                      email: data?.createdBy?.email,
                                      number: data?.createdBy?.contactNo,
                                      name: data?.createdBy?.name,
                                      guide: data?.createdBy?.isUpgrade,
                                      createdAt: data?.createdBy?.createdAt,
                                      language: data?.createdBy?.languages,
                                      userId: data?.createdBy?.id,
                                      screen: 'UserDetails',
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${data?.createdBy?.profileImageUrl}',
                                  height: 55,
                                  width: 55,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Row(
                              children: [
                                CustomText(
                                  data: '${data?.createdBy?.name}',
                                  fontColor: AppColors.blackTextColor,
                                  fSize: 14,
                                  fweight: FontWeight.w500,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    handleFollowers(
                                        data?.createdBy?.id! as int);
                                    setState(() {});
                                  },
                                  child: CustomText(
                                    data: isFollowing ? "unfollow" : "+ Follow",
                                    fontColor: AppColors.blueShadeColor,
                                    fSize: 14,
                                    fweight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: CustomText(
                              data: '${data?.createdBy?.email}',
                              fontColor: AppColors.greyTextColor,
                              fSize: 14,
                              fweight: FontWeight.w500,
                            ),
                            trailing: Container(
                              height: 40,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: CustomText(
                                  data: 'Remove',
                                  fontColor: Color(0xFFD43672),
                                  fSize: 13,
                                  fweight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    default:
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
