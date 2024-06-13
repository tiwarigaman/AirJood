import 'package:airjood/model/planning_details_model.dart';
import 'package:airjood/res/components/color.dart';
import 'package:airjood/res/components/mainbutton.dart';
import 'package:airjood/view/navigation_view/planning_view/plan_details_screen.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/plan_container.dart';
import 'package:airjood/view_model/accept_reject_invitation_view_model.dart';
import 'package:airjood/view_model/planning_details_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../data/response/status.dart';
import '../../../res/components/CustomText.dart';
import '../../../res/components/custom_shimmer.dart';
import '../../../view_model/user_view_model.dart';
import '../home_screens/screen_widget/video_player.dart';

class PlanningDetailsScreen extends StatefulWidget {
  final int? id;
  final int? invitationId;
  final String? status;
  const PlanningDetailsScreen(
      {super.key, this.id, this.invitationId, this.status});

  @override
  State<PlanningDetailsScreen> createState() => _PlanningDetailsScreenState();
}

class _PlanningDetailsScreenState extends State<PlanningDetailsScreen> {
  @override
  void initState() {
    super.initState();
    fetchPlanningDetailsData();
  }

  final List<PlanningDetailsModel> data = [];
  Future<void> fetchPlanningDetailsData() async {
    UserViewModel().getToken().then((value) async {
      token = value;
      final planningProvider =
          Provider.of<PlanningDetailsViewModel>(context, listen: false);
      await planningProvider.getPlanningDetailsApi(value!, widget.id!);
      setState(() {});
    });
  }

  String? token;
  @override
  Widget build(BuildContext context) {
    print(widget.invitationId);
    final padding = MediaQuery.of(context).padding;
    final invitation = Provider.of<AcceptRejectInvitationViewModel>(context);
    return Scaffold(
      body: Consumer<PlanningDetailsViewModel>(
        builder: (context, value, child) {
          switch (value.getPlanningDetailsData.status) {
            case Status.LOADING:
              return const SafeArea(child: ShimmerScreen());
            case Status.ERROR:
              return Container();
            case Status.COMPLETED:
              var data = value.getPlanningDetailsData.data?.data;
              String? result;
              String? result2;
              if (data?.startDate?.day != null &&
                  data?.startDate?.month != null &&
                  data?.startDate?.year != null) {
                String formattedDate =
                    '${data?.startDate?.day}-${data?.startDate?.month}-${data?.startDate?.year}';
                DateTime dateTime =
                    DateFormat('dd-MM-yyyy').parse(formattedDate);
                result = DateFormat('dd MMM yyyy').format(dateTime);
              }
              if (data?.endDate?.day != null &&
                  data?.endDate?.month != null &&
                  data?.endDate?.year != null) {
                String formattedDate2 =
                    '${data?.endDate?.day}-${data?.endDate?.month}-${data?.endDate?.year}';
                DateTime dateTime2 =
                    DateFormat('dd-MM-yyyy').parse(formattedDate2);
                result2 = DateFormat('dd MMM yyyy').format(dateTime2);
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(0),
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: data!.imageUrl.toString(),
                                      width: MediaQuery.of(context).size.width,
                                      height: 250,
                                      fit: BoxFit.fill,
                                    ),
                                    Positioned(
                                      top: 60,
                                      left: 15,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Icon(
                                          Icons.arrow_back_ios_new,
                                          color: AppColors.whiteTextColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 160),
                              ],
                            ),
                            PlanContainer(
                              planId: widget.id!,
                              screen: 'abc',
                              title: data.title,
                              location: '${data.countryName},${data.stateName}',
                              date: result != null && result2 != null
                                  ? '$result - $result2 (${data.planDuration} Days)'
                                  : "${data.planDuration} Days",
                              startDate: result,
                              endDate: result2,
                              duration: '${data.planDuration}',
                              state: data.state,
                              country: data.country,
                              imageUrl: data.imageUrl,
                              invitation: data.invitations,
                            ),
                          ],
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 0),
                          child: CustomText(
                            data: 'My Planning',
                            fSize: 22,
                            fweight: FontWeight.w600,
                            fontColor: AppColors.blackColor,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 2),
                          child: CustomText(
                            data:
                                'Create a plan & add or schedule plan from Laqta.',
                            fSize: 13,
                            fweight: FontWeight.w400,
                            fontColor: AppColors.greyTextColor,
                          ),
                        ),
                        //if (widget.status == 'invited')
                        data.planReels == [] || data.planReels!.isEmpty
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 50),
                                  Image.asset(
                                    'assets/images/rejected.png',
                                    height: 70,
                                    width: 70,
                                  ),
                                  const SizedBox(height: 10),
                                  const CustomText(
                                    data: 'Not found',
                                    fweight: FontWeight.w700,
                                    fontColor: AppColors.blackTextColor,
                                    fSize: 18,
                                  ),
                                ],
                              )
                            : GridView(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1 / 1.3,
                                ),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                children: List.generate(
                                  data.planReels!.length,
                                  (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VideoPlayerWidget(
                                              index: index,
                                              name: data
                                                  .planReels?[index]
                                                  .experience
                                                  ?.reel
                                                  ?.user?[0]
                                                  .name,
                                              language: data
                                                  .planReels?[index]
                                                  .experience
                                                  ?.reel
                                                  ?.user?[0]
                                                  .languages,
                                              about: data
                                                  .planReels?[index]
                                                  .experience
                                                  ?.reel
                                                  ?.user?[0]
                                                  .about,
                                              dateTime: data
                                                  .planReels?[index]
                                                  .experience
                                                  ?.reel
                                                  ?.user?[0]
                                                  .createdAt,
                                              userId: data
                                                  .planReels?[index]
                                                  .experience
                                                  ?.reel
                                                  ?.user?[0]
                                                  .id,
                                              email: data
                                                  .planReels?[index]
                                                  .experience
                                                  ?.reel
                                                  ?.user?[0]
                                                  .email,
                                              guide: data
                                                  .planReels?[index]
                                                  .experience
                                                  ?.reel
                                                  ?.user?[0]
                                                  .isUpgrade,
                                              number: data
                                                  .planReels?[index]
                                                  .experience
                                                  ?.reel
                                                  ?.user?[0]
                                                  .contactNo,
                                              createdAt: data
                                                  .planReels?[index]
                                                  .experience
                                                  ?.reel
                                                  ?.user?[0]
                                                  .createdAt,
                                              screen: 'Laqta',
                                              image: data
                                                  .planReels?[index]
                                                  .experience
                                                  ?.reel
                                                  ?.user?[0]
                                                  .profileImageUrl,
                                              commentCount: data
                                                  .planReels?[index]
                                                  .experience
                                                  ?.reel
                                                  ?.commentCount,
                                              videoUrl:
                                                  '${data.planReels?[index].experience?.reel?.videoUrl}',
                                              reelsId: data.planReels?[index]
                                                  .experience?.reel?.id,
                                              isLike: data.planReels?[index]
                                                  .experience?.reel?.liked,
                                              videoImage: data
                                                  .planReels?[index]
                                                  .experience
                                                  ?.reel
                                                  ?.videoThumbnailUrl,
                                              likeCount: data.planReels?[index]
                                                  .experience?.reel?.likeCount,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                        margin: const EdgeInsets.only(
                                          top: 10,
                                          left: 5,
                                          right: 5,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    '${data.planReels?[index].experience?.reel?.videoThumbnailUrl}',
                                                fit: BoxFit.cover,
                                              ),
                                              Container(
                                                height: 30,
                                                width: 180,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.black
                                                          .withOpacity(0.0),
                                                      Colors.black
                                                          .withOpacity(0.2),
                                                      Colors.black
                                                          .withOpacity(0.5),
                                                      Colors.black
                                                          .withOpacity(0.8),
                                                    ],
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Image.asset(
                                                      'assets/icons/play-button.png',
                                                      height: 25,
                                                      width: 25,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20,
                        top: 8.0,
                        right: 20,
                        bottom: 8.0 + padding.bottom),
                    child: Column(
                      children: [
                        if (widget.status == 'invited')
                          invitation.acceptRejectInvitationLoadings
                              ? const Center(
                                  child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Map<String, String> body = {
                                            "id": '${widget.invitationId}',
                                            "status":
                                                "rejected" //accepted,rejected
                                          };
                                          invitation.acceptRejectInvitationApi(
                                              token!, body, context);
                                        },
                                        child: buttonContainer(
                                            'Reject', CupertinoIcons.clear, 0),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      flex: 2,
                                      child: GestureDetector(
                                        onTap: () {
                                          Map<String, String> body = {
                                            "id": '${widget.invitationId}',
                                            "status":
                                                "accepted" //accepted,rejected
                                          };
                                          invitation.acceptRejectInvitationApi(
                                              token!, body, context);
                                        },
                                        child: buttonContainer(
                                            'Accept & Join Plan',
                                            CupertinoIcons.checkmark_alt_circle,
                                            1),
                                      ),
                                    ),
                                  ],
                                ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlanDetailsScreen(
                                  planId: widget.id!,
                                  screen: 'abc',
                                  title: data.title,
                                  location:
                                      '${data.countryName},${data.stateName}',
                                  date: result != null && result2 != null
                                      ? '$result - $result2 (${data.planDuration} Days)'
                                      : "${data.planDuration} Days",
                                  startDate: result,
                                  endDate: result2,
                                  duration: '${data.planDuration}',
                                  state: data.state,
                                  country: data.country,
                                  imageUrl: data.imageUrl,
                                  data: data.planReels,
                                  invitation: data.invitations,
                                ),
                              ),
                            );
                          },
                          child: const MainButton(data: 'View Plan'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            default:
          }
          return Container();
        },
      ),
    );
  }

  Widget buttonContainer(String name, IconData? icon, int color) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: color == 0 ? AppColors.transperent : AppColors.greenColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color == 0 ? AppColors.redColor : AppColors.greenColor,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            color: color == 0 ? AppColors.redColor : AppColors.whiteColor,
            size: 20,
          ),
          CustomText(
            data: name,
            fontColor: color == 0 ? AppColors.redColor : AppColors.whiteColor,
            fweight: FontWeight.w500,
            fSize: 18,
          ),
        ],
      ),
    );
  }
}
