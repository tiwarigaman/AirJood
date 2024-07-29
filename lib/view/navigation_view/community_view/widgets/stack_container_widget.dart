import 'package:airjood/model/community_details_model.dart';
import 'package:airjood/utils/utils.dart';
import 'package:airjood/view_model/join_community_view_model.dart';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';

class StackContainerWidget extends StatefulWidget {
  final String? coverImage;
  final String? profileImage;
  final String? name;
  final int? member;
  final List<LatestMember>? latestMembers;
  final bool? hasJoined;
  final String? token;
  final int? communityId;
  const StackContainerWidget(
      {super.key,
      this.coverImage,
      this.profileImage,
      this.name,
      this.member,
      this.latestMembers,
      this.hasJoined,
      this.token,
      this.communityId});

  @override
  State<StackContainerWidget> createState() => _StackContainerWidgetState();
}

class _StackContainerWidgetState extends State<StackContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.profileImage ?? '',
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  top: 30,
                  left: 15,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.black.withOpacity(0.2),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.whiteTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 200,
                      child: CustomText(
                        data: widget.name ?? '',
                        fSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackTextColor,
                      ),
                    ),
                    Row(
                      children: [
                        if (widget.latestMembers!.isNotEmpty)
                          AvatarStack(
                            height: 22,
                            width: widget.latestMembers!.length == 1
                                ? 20
                                : widget.latestMembers!.length == 2
                                ? 40
                                : widget.latestMembers!.length == 3
                                ? 60
                                : 70,
                            settings: RestrictedAmountPositions(
                              maxAmountItems: 5,
                              maxCoverage: 0.5,
                              minCoverage: 0.1,
                            ),
                            avatars: [
                              for (var n = 0; n < widget.latestMembers!.length; n++)
                                CachedNetworkImageProvider(
                                  '${widget.latestMembers?[n].user?.profileImageUrl}',
                                  errorListener: (p0) {
                                    const Icon(CupertinoIcons.person);
                                  },
                                ),
                            ],
                          ),
                        if (widget.latestMembers!.isNotEmpty)
                          const SizedBox(width: 10),
                        CustomText(
                          data: '${widget.member} Members',
                          fSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondTextColor,
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.hasJoined == true) {
                      Utils.toastMessage('You have already join this community');
                    } else {
                      Map<String, String> data = {
                        "community_id": '${widget.communityId}',
                      };
                      Provider.of<JoinCommunityViewModel>(context, listen: false)
                          .joinCommunityApi(widget.token, data, context,
                          communityId: widget.communityId);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: widget.hasJoined == false
                          ? AppColors.mainColor
                          : AppColors.greyTextColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: AppColors.whiteColor,
                          size: 15,
                        ),
                        SizedBox(width: 5),
                        CustomText(
                          data: 'Join',
                          color: AppColors.whiteTextColor,
                          fontWeight: FontWeight.w500,
                          fSize: 15,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
        Positioned(
          top: 205,
          left: 8,
          child: Container(
            height: 95,
            width: 95,
            margin: const EdgeInsets.only(left: 10, bottom: 0),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.greenColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: widget.coverImage ?? '',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
