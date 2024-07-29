import 'package:airjood/view_model/add_invitation_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/maintextfild.dart';
import '../../../../view_model/followers_view_model.dart';
import '../../../../view_model/invite_user_list_view_model.dart';
import '../../../../view_model/user_view_model.dart';
import '../../home_screens/sub_home_screens/experience_screens/reels_user_detail_screen.dart';

class FollowersUser extends StatefulWidget {
  final int planId;
  const FollowersUser({super.key, required this.planId});

  @override
  State<FollowersUser> createState() => _FollowersUserState();
}

class _FollowersUserState extends State<FollowersUser> {

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
        Provider.of<FollowersViewModel>(context,listen: false).setPage(1);
        Provider.of<FollowersViewModel>(context,listen: false).clearData();
        Provider.of<FollowersViewModel>(context, listen: false)
            .followerGetApi(values!, userId!, planId: widget.planId);
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
      Provider.of<FollowersViewModel>(context, listen: false)
          .followerGetApi(token!, userId!, planId: widget.planId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final followerListProvider = Provider.of<FollowersViewModel>(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MainTextFild(
            hintText: 'Search People...',
            onChanged: (values) {
              if (values.length == 3 || values.isEmpty) {
                Provider.of<FollowersViewModel>(context,listen: false).setPage(1);
                Provider.of<FollowersViewModel>(context,listen: false).clearData();
                Provider.of<FollowersViewModel>(context, listen: false)
                    .followerGetApi(token!, userId!, planId: widget.planId, search: values);
              }
            },
            onFieldSubmitted: (values) {
              Provider.of<FollowersViewModel>(context,listen: false).setPage(1);
              Provider.of<FollowersViewModel>(context,listen: false).clearData();
              Provider.of<FollowersViewModel>(context, listen: false)
                  .followerGetApi(token!, userId!, planId: widget.planId, search: values);
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
              itemCount: followerListProvider.followersList.length,
              itemBuilder: (context, index) {
                String inviteStatus = inviteStatuses[followerListProvider.followersList[index].createdBy?.id] ?? followerListProvider.followersList[index].createdBy?.planInvitationStatus ?? 'Invite Now';
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
                                about: followerListProvider.followersList[index].createdBy?.about,
                                image:followerListProvider.followersList[index].createdBy?.profileImageUrl,
                                email: followerListProvider.followersList[index].createdBy?.email,
                                number: followerListProvider.followersList[index].createdBy?.contactNo,
                                name: followerListProvider.followersList[index].createdBy?.name,
                                guide: followerListProvider.followersList[index].createdBy?.isUpgrade,
                                createdAt: followerListProvider.followersList[index].createdBy?.createdAt,
                                language: followerListProvider.followersList[index].createdBy?.languages,
                                userId: followerListProvider.followersList[index].createdBy?.id,
                                screen: 'UserDetails',
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: '${followerListProvider.followersList[index].createdBy?.profileImageUrl}',
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
                            data: followerListProvider.followersList[index].createdBy?.name ?? 'Saimon Jhonson',
                            fSize: 15,
                            color: AppColors.blackTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                          CustomText(
                            data: followerListProvider.followersList[index].createdBy?.email ?? 'davidwarner21@gmail.com',
                            fSize: 13,
                            color: AppColors.secondTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          handleInvitation(followerListProvider.followersList[index].createdBy!.id!, widget.planId);
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