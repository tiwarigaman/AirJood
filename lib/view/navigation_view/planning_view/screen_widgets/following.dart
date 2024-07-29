import 'package:airjood/view_model/add_invitation_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/maintextfild.dart';
import '../../../../view_model/following_view_model.dart';
import '../../../../view_model/user_view_model.dart';
import '../../home_screens/sub_home_screens/experience_screens/reels_user_detail_screen.dart';

class FollowingUser extends StatefulWidget {
  final int planId;
  const FollowingUser({super.key, required this.planId});

  @override
  State<FollowingUser> createState() => _FollowingUserState();
}

class _FollowingUserState extends State<FollowingUser> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    UserViewModel().getUser().then((value) {
      userId = value?.id;
    }).then((v) {
      UserViewModel().getToken().then((values) {
        token = values;
        setState(() {});
        Provider.of<FollowingViewModel>(context,listen: false).setPage(1);
        Provider.of<FollowingViewModel>(context,listen: false).clearData();
        Provider.of<FollowingViewModel>(context, listen: false)
            .followingGetApi(values!, userId!, planId: widget.planId);
      });
    });
    _scrollController.addListener(_onScroll);
  }

  String? token;
  int? userId;
  Map<int, String> inviteStatuses = {};

  handleInvitation(int userId, int planId) {
    String currentStatus = inviteStatuses[userId] ?? 'Invite Now';
    String newStatus;
    if (currentStatus == 'Invite Now') {
      newStatus = 'Invited';
    } else if (currentStatus == 'Invited') {
      newStatus = 'Accepted';
    } else {
      newStatus = currentStatus; // handle other cases if necessary
    }
    Map<String, String> data = {
      "user_id": '$userId',
      "plan_id": '$planId',
    };
    Provider.of<AddInvitationViewModel>(context, listen: false)
        .addInvitationApi(token, data, context);
    setState(() {
      inviteStatuses[userId] = newStatus;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      Provider.of<FollowingViewModel>(context, listen: false)
          .followingGetApi(token!, userId!, planId: widget.planId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final followerListProvider = Provider.of<FollowingViewModel>(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MainTextFild(
            hintText: 'Search People...',
            onChanged: (values) {
              if (values.length == 3 || values.isEmpty) {
                Provider.of<FollowingViewModel>(context,listen: false).setPage(1);
                Provider.of<FollowingViewModel>(context,listen: false).clearData();
                Provider.of<FollowingViewModel>(context, listen: false)
                    .followingGetApi(token!, userId!, planId: widget.planId, search: values);
              }
            },
            onFieldSubmitted: (values) {
              Provider.of<FollowingViewModel>(context,listen: false).setPage(1);
              Provider.of<FollowingViewModel>(context,listen: false).clearData();
              Provider.of<FollowingViewModel>(context, listen: false)
                  .followingGetApi(token!, userId!, planId: widget.planId, search: values);
            },
            maxLines: 1,
            prefixIcon: const Icon(
              Icons.search_sharp,
              color: AppColors.textFildHintColor,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: followerListProvider.followingList.length,
              itemBuilder: (context, index) {
                String inviteStatus = inviteStatuses[followerListProvider.followingList[index].followedUser?.id] ?? followerListProvider.followingList[index].followedUser?.planInvitationStatus ?? 'Invite Now';
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReelsUserDetailScreen(
                                about: followerListProvider.followingList[index].followedUser?.about,
                                image:followerListProvider.followingList[index].followedUser?.profileImageUrl,
                                email: followerListProvider.followingList[index].followedUser?.email,
                                number: followerListProvider.followingList[index].followedUser?.contactNo,
                                name: followerListProvider.followingList[index].followedUser?.name,
                                guide: followerListProvider.followingList[index].followedUser?.isUpgrade,
                                createdAt: followerListProvider.followingList[index].followedUser?.createdAt,
                                language: followerListProvider.followingList[index].followedUser?.languages,
                                userId: followerListProvider.followingList[index].followedUser?.id,
                                screen: 'UserDetails',
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: '${followerListProvider.followingList[index].followedUser?.profileImageUrl}',
                            errorWidget: (context, url, error) {
                              return Container(
                                color: AppColors.secondTextColor.withOpacity(0.1),
                                child: const Icon(CupertinoIcons.person),
                              );
                            },
                            height: 50,
                            width: 50,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            data: followerListProvider.followingList[index].followedUser?.name ?? 'Saimon Jhonson',
                            fSize: 15,
                            color: AppColors.blackTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                          CustomText(
                            data: followerListProvider.followingList[index].followedUser?.email ?? 'davidwarner21@gmail.com',
                            fSize: 13,
                            color: AppColors.secondTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          handleInvitation(followerListProvider.followingList[index].followedUser!.id!, widget.planId);
                        },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            color: inviteStatus == 'Invite Now'
                                ? Colors.blue.shade50
                                : inviteStatus == 'Invited'
                                ? Colors.grey.shade300
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: CustomText(
                              data: inviteStatus,
                              color: inviteStatus == 'Invite Now'
                                  ? const Color(0xFF14C7FF)
                                  : inviteStatus == 'Invited'
                                  ? Colors.black
                                  : Colors.black,
                              fSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}