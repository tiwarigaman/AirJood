import 'package:airjood/view/navigation_view/ExitBar.dart';
import 'package:airjood/view_model/delete_planning_reels_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../view_model/user_view_model.dart';
import '../../home_screens/component/read_more_text.dart';

class PlanningReelsSheetWidget extends StatefulWidget {
  final String? imageUrl;
  final String? title;
  final String? about;
  final String? location;
  final int? planId;
  final int? experianceId;
  const PlanningReelsSheetWidget(
      {super.key,
      this.imageUrl,
      this.title,
      this.about,
      this.planId,
      this.location,
      this.experianceId});

  @override
  State<PlanningReelsSheetWidget> createState() =>
      _PlanningReelsSheetWidgetState();
}

class _PlanningReelsSheetWidgetState extends State<PlanningReelsSheetWidget> {
  @override
  void initState() {
    super.initState();
    UserViewModel().getToken().then((value) {
      token = value;
      setState(() {});
    });
  }
  String? token;
  @override
  Widget build(BuildContext context) {
    final deletePlanningReels = Provider.of<DeletePlanningReelsViewModel>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 50),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.imageUrl ?? 'assets/images/image1.png',
                    height: 110,
                    width: 85,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.title ?? 'AL khayma Camp',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (_) =>  CustomExitCard(
                                title: 'Delete',
                                subTitle: 'Are you sure you want to delete ?',
                                positiveButton: 'Delete',
                                negativeButton: 'Cancel',
                                icon: CupertinoIcons.trash,
                                onPressed: () {
                                  Map<String,String> data = {
                                    "plan_id": '${widget.planId}',
                                    "experience_id": '${widget.experianceId}',
                                  };
                                  deletePlanningReels.deletePlanningReelsApi(token, data, widget.planId!,context);
                                },
                              ),
                            );
                          },
                          child: const Icon(
                            CupertinoIcons.trash,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.splashTextColor,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomText(
                            data: widget.location ?? 'Mumbai, Maharashtra',
                            fweight: FontWeight.w600,
                            fSize: 14,
                            fontColor: AppColors.splashTextColor,
                          ),
                        ),
                      ],
                    ),
                    CustomReadMoreText(
                      mColor: AppColors.mainColor,
                      rColor: AppColors.mainColor,
                      trimLines: 3,
                      content: widget.about ??
                          'Lorem ipsum dolor sit amet consectetur. Enim justo tellus odio vitae ullamcorper adipiscing est. Phasellus proin non orci consectetur. Id sit lectus morbi nulla Tristique.',
                      color: AppColors.secondTextColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
