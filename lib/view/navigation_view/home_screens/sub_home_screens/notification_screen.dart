import 'package:airjood/utils/utils.dart';
import 'package:airjood/view/navigation_view/planning_view/planning_details_screen.dart';
import 'package:airjood/view_model/delete_notification_view_model.dart';
import 'package:airjood/view_model/notification_list_view_model.dart';
import 'package:airjood/view_model/read_unread_notification_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../data/response/status.dart';
import '../../../../model/conversations_model.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/custom_shimmer.dart';
import '../../../../view_model/user_view_model.dart';
import '../../chat_view/chat_details_screen.dart';
import '../screen_widget/video_player.dart';
import 'experience_screens/reels_user_detail_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late final controller = SlidableController(this);
  @override
  void initState() {
    super.initState();
    UserViewModel().getToken().then((value) {
      token = value;
      setState(() {});
      Provider.of<NotificationListViewModel>(context, listen: false)
          .notificationListGetApi(value!);
    });
  }

  String? token;
  void doNothing(BuildContext context, String id) {
    Provider.of<DeleteNotificationViewModel>(context, listen: false)
        .deleteNotificationApi(token!, id, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: AppColors.whiteColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const CustomText(
                    data: 'Notifications',
                    fweight: FontWeight.w700,
                    fSize: 22,
                    fontColor: AppColors.blackTextColor,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      CupertinoIcons.xmark,
                    ),
                  ),
                ],
              ),
            ),
            Consumer<NotificationListViewModel>(
              builder: (context, value, child) {
                switch (value.notificationListData.status) {
                  case Status.LOADING:
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FollowersShimmer(),
                    );
                  case Status.ERROR:
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FollowersShimmer(),
                    );
                  case Status.COMPLETED:
                    var data2 = value.notificationListData.data?.data ?? [];
                    return value.notificationListData.data == null ||
                            value.notificationListData.data!.data!.isEmpty
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 250),
                              Image.asset(
                                'assets/images/rejected.png',
                                height: 70,
                                width: 70,
                              ),
                              const SizedBox(height: 10),
                              const CustomText(
                                data: 'Not found',
                                fweight: FontWeight.w700,
                                fontColor: AppColors.blueColor,
                                fSize: 18,
                              ),
                            ],
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: data2.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Slidable(
                                key: const ValueKey(0),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  dismissible: DismissiblePane(onDismissed: () {
                                    doNothing(context, data2[index].id!);
                                  }),
                                  extentRatio: 0.20,
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        doNothing(context, data2[index].id!);
                                      },
                                      backgroundColor: const Color(0xFFD43672),
                                      foregroundColor: Colors.white,
                                      icon: CupertinoIcons.trash,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      color: data2[index].readAt == null
                                          ? AppColors.textFildBGColor
                                          : AppColors.whiteColor,
                                      child: ListTile(
                                        onTap: () {
                                          Map<String,String> data = {
                                            "notification_ids": '${data2[index].id}'
                                          };
                                          Provider.of<ReadNotificationViewModel>(context, listen: false)
                                              .readUnreadNotificationApi(token!, data, context);
                                          var planIdString =
                                              data2[index].data?.data?.planId;
                                          var invitationIdString = data2[index]
                                              .data
                                              ?.data
                                              ?.invitationId;
                                          if (data2[index].data?.type ==
                                              'plan_invitation_request') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PlanningDetailsScreen(
                                                  id: int.tryParse(
                                                      planIdString!),
                                                  invitationId:
                                                      invitationIdString,
                                                  status: data2[index]
                                                      .metadata
                                                      ?.invitation
                                                      ?.status,
                                                ),
                                              ),
                                            );
                                          }
                                          else if (data2[index].data?.type ==
                                              'user_followed'){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ReelsUserDetailScreen(
                                                  about:data2[index].metadata?.user?.about,
                                                  image: data2[index].metadata?.user?.profileImageUrl,
                                                  email: data2[index].metadata?.user?.email,
                                                  number: data2[index].metadata?.user?.contactNo,
                                                  name: data2[index].metadata?.user?.name,
                                                  guide: data2[index].metadata?.user?.isUpgrade,
                                                  createdAt: data2[index].metadata?.user?.createdAt,
                                                  language: data2[index].metadata?.user?.languages,
                                                  userId: data2[index].metadata?.user?.id,
                                                  screen:"UserDetails",
                                                  isFollow: data2[index].metadata?.user?.isFollower,
                                                ),
                                              ),
                                            );
                                          }
                                          else if (data2[index].data?.type ==
                                              'reel_liked'){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => VideoPlayerWidget(
                                                  videoUrl: '${data2[index].metadata?.reel?.videoUrl}',
                                                  commentCount:
                                                  data2[index].metadata?.reel?.commentCount,
                                                  about: data2[index].metadata?.reel?.user?[0].about,
                                                  dateTime:
                                                  data2[index].metadata?.reel?.user?[0].createdAt,
                                                  userId: data2[index].metadata?.reel?.user?[0].id,
                                                  email: data2[index].metadata?.reel?.user?[0].email,
                                                  guide:
                                                  data2[index].metadata?.reel?.user?[0].isUpgrade,
                                                  number: data2[index].metadata?.reel?.user?[0].contactNo,
                                                  createdAt:
                                                  data2[index].metadata?.reel?.user?[0].createdAt,
                                                  image: data2[index].metadata?.reel?.user?[0].profileImageUrl,
                                                  name: data2[index].metadata?.reel?.user?[0].name,
                                                  description: data2[index].metadata?.reel?.caption,
                                                  language:
                                                  data2[index].metadata?.reel?.user?[0].languages,
                                                  index: 1,
                                                  likeCount: data2[index].metadata?.reel?.likeCount,
                                                  videoImage:
                                                  data2[index].metadata?.reel?.videoThumbnailUrl,
                                                  isLike: data2[index].metadata?.reel?.liked,
                                                  reelsId: data2[index].metadata?.reel?.id,
                                                  screen: 'UserDetails',
                                                ),
                                              ),
                                            );
                                          }
                                          else if (data2[index].data?.type ==
                                              'new_laqta'){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => VideoPlayerWidget(
                                                  videoUrl: '${data2[index].metadata?.reel?.videoUrl}',
                                                  commentCount:
                                                  data2[index].metadata?.reel?.commentCount,
                                                  about: data2[index].metadata?.reel?.user?[0].about,
                                                  dateTime:
                                                  data2[index].metadata?.reel?.user?[0].createdAt,
                                                  userId: data2[index].metadata?.reel?.user?[0].id,
                                                  email: data2[index].metadata?.reel?.user?[0].email,
                                                  guide:
                                                  data2[index].metadata?.reel?.user?[0].isUpgrade,
                                                  number: data2[index].metadata?.reel?.user?[0].contactNo,
                                                  createdAt:
                                                  data2[index].metadata?.reel?.user?[0].createdAt,
                                                  image: data2[index].metadata?.reel?.user?[0].profileImageUrl,
                                                  name: data2[index].metadata?.reel?.user?[0].name,
                                                  description: data2[index].metadata?.reel?.caption,
                                                  language:
                                                  data2[index].metadata?.reel?.user?[0].languages,
                                                  index: 1,
                                                  likeCount: data2[index].metadata?.reel?.likeCount,
                                                  videoImage:
                                                  data2[index].metadata?.reel?.videoThumbnailUrl,
                                                  isLike: data2[index].metadata?.reel?.liked,
                                                  reelsId: data2[index].metadata?.reel?.id,
                                                  screen: 'UserDetails',
                                                ),
                                              ),
                                            );
                                          }
                                          else if (data2[index].data?.type ==
                                              'new_message_received'){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ChatDetailsScreen(
                                                  user: ConversationsData(
                                                    id: data2[0].metadata?.user?.id,
                                                    languages: data2[0].metadata?.user?.languages,
                                                    about: data2[0].metadata?.user?.about,
                                                    contactNo: data2[0].metadata?.user?.contactNo,
                                                    dob:data2[0].metadata?.user?.dob,
                                                    gender: data2[0].metadata?.user?.gender,
                                                    name:data2[0].metadata?.user?.name,
                                                    role:data2[0].metadata?.user?.role,
                                                    email: data2[0].metadata?.user?.email,
                                                    profileImageUrl: data2[0].metadata?.user?.profileImageUrl,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          else if (data2[index].data?.type ==
                                              'laqta_comment'){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => VideoPlayerWidget(
                                                  videoUrl: '${data2[index].metadata?.reel?.videoUrl}',
                                                  commentCount:
                                                  data2[index].metadata?.reel?.commentCount,
                                                  about: data2[index].metadata?.reel?.user?[0].about,
                                                  dateTime:
                                                  data2[index].metadata?.reel?.user?[0].createdAt,
                                                  userId: data2[index].metadata?.reel?.user?[0].id,
                                                  email: data2[index].metadata?.reel?.user?[0].email,
                                                  guide:
                                                  data2[index].metadata?.reel?.user?[0].isUpgrade,
                                                  number: data2[index].metadata?.reel?.user?[0].contactNo,
                                                  createdAt:
                                                  data2[index].metadata?.reel?.user?[0].createdAt,
                                                  image: data2[index].metadata?.reel?.user?[0].profileImageUrl,
                                                  name: data2[index].metadata?.reel?.user?[0].name,
                                                  description: data2[index].metadata?.reel?.caption,
                                                  language:
                                                  data2[index].metadata?.reel?.user?[0].languages,
                                                  index: 1,
                                                  likeCount: data2[index].metadata?.reel?.likeCount,
                                                  videoImage:
                                                  data2[index].metadata?.reel?.videoThumbnailUrl,
                                                  isLike: data2[index].metadata?.reel?.liked,
                                                  reelsId: data2[index].metadata?.reel?.id,
                                                  screen: 'UserDetails',
                                                  commentOpen: 'Open',
                                                ),
                                              ),
                                            );
                                          }
                                          else if (data2[index].data?.type ==
                                              'experience_booked'){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ReelsUserDetailScreen(
                                                  about:data2[index].metadata?.user?.about,
                                                  image: data2[index].metadata?.user?.profileImageUrl,
                                                  email: data2[index].metadata?.user?.email,
                                                  number: data2[index].metadata?.user?.contactNo,
                                                  name: data2[index].metadata?.user?.name,
                                                  guide: data2[index].metadata?.user?.isUpgrade,
                                                  createdAt: data2[index].metadata?.user?.createdAt,
                                                  language: data2[index].metadata?.user?.languages,
                                                  userId: data2[index].metadata?.user?.id,
                                                  screen:"MyScreen",
                                                  isFollow: data2[index].metadata?.user?.isFollower,
                                                ),
                                              ),
                                            );
                                          }
                                          else {
                                            Utils.toastMessage(
                                                'Something went wrong !');
                                          }
                                        },
                                        contentPadding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        leading: Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                            color: AppColors.textFildBGColor,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Center(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.network(
                                                '${data2[index].metadata?.user?.profileImageUrl}',
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                softWrap: true,
                                                maxLines: 2,
                                                text: TextSpan(
                                                  text:
                                                      '${data2[index].metadata?.user?.name}',
                                                  style: GoogleFonts.nunitoSans(
                                                    color: AppColors
                                                        .blackTextColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          ' ${data2[index].data?.message}',
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors
                                                            .tileTextColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle:  CustomText(
                                          data: timeago.format(
                                              data2[index].createdAt ??
                                                  DateTime.now()),
                                          fSize: 14,
                                          fweight: FontWeight.w500,
                                          fontColor: AppColors.tileTextColor,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 0.5,
                                      thickness: 0.9,
                                      color: data2[index].readAt == null
                                          ? AppColors.whiteColor
                                          : AppColors.textFildBGColor,
                                    ),
                                  ],
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
    );
  }
}
