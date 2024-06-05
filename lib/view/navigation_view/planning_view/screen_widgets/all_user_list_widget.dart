import 'package:airjood/view_model/add_invitation_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/maintextfild.dart';
import '../../../../view_model/invite_user_list_view_model.dart';
import '../../../../view_model/user_view_model.dart';
import '../../home_screens/sub_home_screens/experience_screens/reels_user_detail_screen.dart';

class AllUsers extends StatefulWidget {
  final int planId;
  const AllUsers({super.key, required this.planId});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    UserViewModel().getToken().then((value) {
      token = value;
      setState(() {});
      Provider.of<InviteUserListViewModel>(context,listen: false).setPage(1);
      Provider.of<InviteUserListViewModel>(context,listen: false).clearData();
      Provider.of<InviteUserListViewModel>(context, listen: false)
          .inviteUserListGetApi(value!, widget.planId);
    });
    _scrollController.addListener(_onScroll);
  }

  String? token;
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
      Provider.of<InviteUserListViewModel>(context, listen: false)
          .inviteUserListGetApi(token!, widget.planId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final invitedListProvider = Provider.of<InviteUserListViewModel>(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MainTextFild(
            hintText: 'Search People...',
            onChanged: (values) {
              if (values.length == 3 || values.isEmpty) {
                Provider.of<InviteUserListViewModel>(context,listen: false).setPage(1);
                Provider.of<InviteUserListViewModel>(context,listen: false).clearData();
                Provider.of<InviteUserListViewModel>(context, listen: false)
                    .inviteUserListGetApi(token!, widget.planId, search: values);
              }
            },
            onFieldSubmitted: (values) {
              Provider.of<InviteUserListViewModel>(context,listen: false).setPage(1);
              Provider.of<InviteUserListViewModel>(context,listen: false).clearData();
              Provider.of<InviteUserListViewModel>(context, listen: false)
                  .inviteUserListGetApi(token!, widget.planId, search: values);
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
              itemCount: invitedListProvider.invitedList.length,
              itemBuilder: (context, index) {
                String inviteStatus = inviteStatuses[invitedListProvider.invitedList[index].id] ?? invitedListProvider.invitedList[index].planInvitationStatus ?? 'Invite Now';
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
                                about: invitedListProvider.invitedList[index].about,
                                image: invitedListProvider.invitedList[index].profileImageUrl,
                                email: invitedListProvider.invitedList[index].email,
                                number: invitedListProvider.invitedList[index].contactNo,
                                name: invitedListProvider.invitedList[index].name,
                                guide: invitedListProvider.invitedList[index].isUpgrade,
                                createdAt: invitedListProvider.invitedList[index].createdAt,
                                language: invitedListProvider.invitedList[index].languages,
                                userId: invitedListProvider.invitedList[index].id,
                                screen: 'UserDetails',
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: '${invitedListProvider.invitedList[index].profileImageUrl}',
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
                            data: invitedListProvider.invitedList[index].name ?? 'Saimon Jhonson',
                            fSize: 15,
                            fontColor: AppColors.blackTextColor,
                            fweight: FontWeight.w600,
                          ),
                          CustomText(
                            data: invitedListProvider.invitedList[index].email ?? 'davidwarner21@gmail.com',
                            fSize: 13,
                            fontColor: AppColors.secondTextColor,
                            fweight: FontWeight.w500,
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          handleInvitation(invitedListProvider.invitedList[index].id!.toInt(), widget.planId);
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
                              fontColor: inviteStatus == 'Invite Now'
                                  ? const Color(0xFF14C7FF)
                                  : inviteStatus == 'Invited'
                                  ? Colors.black
                                  : Colors.black,
                              fSize: 13,
                              fweight: FontWeight.w600,
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
