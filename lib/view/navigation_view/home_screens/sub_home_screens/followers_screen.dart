import 'package:airjood/model/follower_model.dart';
import 'package:airjood/res/components/maintextfild.dart';
import 'package:airjood/view_model/delete_follower_view_model.dart';
import 'package:airjood/view_model/followers_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/response/status.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/custom_shimmer.dart';
import '../../../../view_model/home_reels_view_model.dart';
import '../../../../view_model/user_view_model.dart';
import 'experience_screens/reels_user_detail_screen.dart';

class FollowersScreen extends StatefulWidget {
  final int? userId;
  final String? screen;

  const FollowersScreen({super.key, this.userId, this.screen});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  void initState() {
    UserViewModel().getToken().then((value) {
      Provider.of<FollowersViewModel>(context, listen: false).setPage(1);
      Provider.of<FollowersViewModel>(context, listen: false).clearData();
      Provider.of<FollowersViewModel>(context, listen: false)
          .followerGetApi(value!, widget.userId!);
    });
    super.initState();
  }

  Map<int, bool> followStates = {};

  handleFollowers(Datum? data) {
    data?.isFollowingByFollowedUser =
        !(data.isFollowingByFollowedUser ?? false);
    Provider.of<HomeReelsViewModel>(context, listen: false).handleFollowers(
        context, data!.createdBy!.id!, !data.isFollowingByFollowedUser!);
    setState(() {});
  }

  handleRemoveFollowers(int userId, int loginUserId) {
    UserViewModel().getToken().then((value) {
      Provider.of<DeleteFollowerViewModel>(context, listen: false)
          .deleteFollowerApi(value!, userId, loginUserId, context);
    });
  }

  final TextEditingController searchController = TextEditingController();

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
                'Followers(${Provider.of<FollowersViewModel>(context).followerData.data?.data?.length ?? 0})',
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
              MainTextFild(
                onChanged: (values) {
                  if (values.length == 3 || values.isEmpty) {
                    UserViewModel().getToken().then((value) {
                      Provider.of<FollowersViewModel>(context, listen: false)
                          .setPage(1);
                      Provider.of<FollowersViewModel>(context, listen: false)
                          .clearData();
                      Provider.of<FollowersViewModel>(context, listen: false)
                          .followerGetApi(value!, widget.userId!,
                              search: values);
                    });
                  }
                },
                onFieldSubmitted: (values) {
                  UserViewModel().getToken().then((value) {
                    Provider.of<FollowersViewModel>(context, listen: false)
                        .setPage(1);
                    Provider.of<FollowersViewModel>(context, listen: false)
                        .clearData();
                    Provider.of<FollowersViewModel>(context, listen: false)
                        .followerGetApi(value!, widget.userId!, search: values);
                  });
                },
                hintText: 'Search People...',
                maxLines: 1,
                prefixIcon: const Icon(
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
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: GestureDetector(
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
                                      isFollow: data?.isFollowingByFollowedUser,
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
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: AppColors.blueShade,
                                      ),
                                      child: const Icon(
                                        CupertinoIcons.person,
                                      ),
                                    );
                                  },
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
                                widget.screen == 'MyScreen'
                                    ? InkWell(
                                        onTap: () {
                                          handleFollowers(data);
                                          setState(() {});
                                        },
                                        child: CustomText(
                                          data:
                                              data?.isFollowingByFollowedUser ==
                                                      true
                                                  ? "Following"
                                                  : "+ Follow",
                                          fontColor: AppColors.blueShadeColor,
                                          fSize: 14,
                                          fweight: FontWeight.w500,
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            subtitle: CustomText(
                              data: '${data?.createdBy?.email}',
                              fontColor: AppColors.greyTextColor,
                              fSize: 14,
                              fweight: FontWeight.w500,
                            ),
                            trailing: widget.screen == 'MyScreen'
                                ? GestureDetector(
                                    onTap: () {
                                      UserViewModel().getUser().then((values) {
                                        handleRemoveFollowers(
                                            data?.createdBy!.id as int,
                                            values!.id!);
                                      });
                                    },
                                    child: Container(
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
                                  )
                                : const SizedBox(),
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
