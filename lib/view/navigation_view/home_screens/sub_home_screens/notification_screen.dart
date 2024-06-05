import 'package:airjood/view/navigation_view/planning_view/planning_details_screen.dart';
import 'package:airjood/view_model/delete_notification_view_model.dart';
import 'package:airjood/view_model/notification_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../data/response/status.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/custom_shimmer.dart';
import '../../../../view_model/user_view_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late final controller = SlidableController(this);
  final List data = [
    {
      'Image': 'assets/images/user.png',
      'name': 'Saimon jhonson',
      'dis': ' added a new post',
      'hei': 45,
      'wid': 45,
    },
    {
      'Image': 'assets/images/user.png',
      'name': 'Jack Maa',
      'dis': ' Started following you',
      'hei': 45,
      'wid': 45,
    },
    {
      'Image': 'assets/icons/like.png',
      'name': 'Saimon jhonson, Leena smith',
      'dis': ' and 25 others liked your post.',
      'hei': 20,
      'wid': 20,
    },
    {
      'Image': 'assets/icons/message.png',
      'name': 'Magdalina Kubica',
      'dis': ' Commented on your post click to reply her.',
      'hei': 20,
      'wid': 20,
    },
    {
      'Image': 'assets/images/user.png',
      'name': 'Anjilina Jolie',
      'dis': 'Started following you',
      'hei': 45,
      'wid': 45,
    },
    {
      'Image': 'assets/images/user.png',
      'name': 'Rose Spartain',
      'dis': ' Started following you',
      'hei': 45,
      'wid': 45,
    },
    {
      'Image': 'assets/icons/like.png',
      'name': 'Saimon jhonson, Leena smith',
      'dis': ' and 25 others liked your post.',
      'hei': 20,
      'wid': 20,
    },
    {
      'Image': 'assets/icons/message.png',
      'name': 'Magdalina Kubica',
      'dis': ' Commented on your post click to reply her.',
      'hei': 20,
      'wid': 20,
    },
    {
      'Image': 'assets/images/user.png',
      'name': 'Jack Maa',
      'dis': ' Started following you',
      'hei': 45,
      'wid': 45,
    },
    {
      'Image': 'assets/icons/like.png',
      'name': 'Saimon jhonson, Leena smith',
      'dis': ' and 25 others liked your post.',
      'hei': 20,
      'wid': 20,
    },
  ];

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
                                    ListTile(
                                      onTap: () {
                                        var planIdString = data2[index].data?.data?.planId;
                                        if (data2[index]
                                                .metadata
                                                ?.invitation
                                                ?.status ==
                                            'accepted') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PlanningDetailsScreen(
                                                id: int.tryParse(planIdString),
                                              ),
                                            ),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PlanningDetailsScreen(
                                                invitationId: data2[index]
                                                    .data
                                                    ?.data
                                                    ?.invitationId,
                                                id: int.tryParse(planIdString),
                                              ),
                                            ),
                                          );
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
                                            borderRadius: BorderRadius.circular(
                                                data[index]['hei'] == 20
                                                    ? 00
                                                    : 100),
                                            child: Image.network(
                                              '${data2[index].metadata?.invitedBy?.profileImageUrl}',
                                              height:
                                                  data[index]['hei'].toDouble(),
                                              width:
                                                  data[index]['wid'].toDouble(),
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
                                                    '${data2[index].metadata?.invitedBy?.name}',
                                                style: GoogleFonts.nunitoSans(
                                                  color:
                                                      AppColors.blackTextColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                        ' ${data2[index].data?.message}',
                                                    style:
                                                        GoogleFonts.nunitoSans(
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
                                      subtitle: const CustomText(
                                        data: '10 min ago',
                                        fSize: 14,
                                        fweight: FontWeight.w500,
                                        fontColor: AppColors.tileTextColor,
                                      ),
                                    ),
                                    const Divider(
                                      height: 0.5,
                                      thickness: 0.9,
                                      color: AppColors.textFildBGColor,
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
