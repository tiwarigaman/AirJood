import 'package:airjood/res/components/maintextfild.dart';
import 'package:airjood/view_model/followers_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/response/status.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/custom_shimmer.dart';
import '../../../../view_model/user_view_model.dart';
import '../component/reels_user.dart';
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
          .followersGetApi(value!, 102);
    });
    super.initState();
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
          const CustomText(
            data: 'Followers (325K)',
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
                  switch (value.followersData.status) {
                    case Status.LOADING:
                      return const ChatShimmer();
                    case Status.ERROR:
                      return const ChatShimmer();
                    case Status.COMPLETED:
                      return ListView.builder(
                        itemCount: value.followersData.data?.data?.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var data = value.followersData.data?.data?[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReelsUserDetailScreen(
                                      about: data?.followedUser?.about,
                                      image:
                                          data?.followedUser?.profileImageUrl,
                                      email: data?.followedUser?.email,
                                      number: data?.followedUser?.contactNo,
                                      name: data?.followedUser?.name,
                                      guide: data?.followedUser?.isUpgrade,
                                      createdAt: data?.followedUser?.createdAt,
                                      language: data?.followedUser?.languages,
                                      userId: data?.followedUser?.id,
                                      screen: 'UserDetails',
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${data?.followedUser?.profileImageUrl}',
                                ),
                              ),
                            ),
                            // leading: ReelsUser(
                            //   image: data?.followedUser?.profileImageUrl,
                            //   name: data?.followedUser?.name,
                            //   createdAt: data?.followedUser?.createdAt,
                            //   number: data?.followedUser?.contactNo,
                            //   email: data?.followedUser?.email,
                            //   about: data?.followedUser?.about,
                            //   language: data?.followedUser?.languages,
                            //   guide: data?.followedUser?.isUpgrade,
                            //   userId: data?.followedUser?.id,
                            //   dateTime: data?.followedUser?.createdAt,
                            //   discription: data?.followedUser?.about,
                            //   screen: 'UserDetails',
                            //   // userData: userData,
                            // ),
                            title: Row(
                              children: [
                                CustomText(
                                  data: '${data?.followedUser?.name}',
                                  fontColor: AppColors.blackTextColor,
                                  fSize: 14,
                                  fweight: FontWeight.w500,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const CustomText(
                                  data: '+ Follow',
                                  fontColor: AppColors.blueShadeColor,
                                  fSize: 14,
                                  fweight: FontWeight.w500,
                                ),
                              ],
                            ),
                            subtitle: CustomText(
                              data: '${data?.followedUser?.email}',
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
