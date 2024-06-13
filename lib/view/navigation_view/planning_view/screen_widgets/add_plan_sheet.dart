import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/res/components/color.dart';
import 'package:airjood/res/components/mainbutton.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/note_textbox.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/selected_list.dart';
import 'package:airjood/view_model/add_reels_planning_view_model.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../utils/utils.dart';
import '../../../../view_model/user_view_model.dart';
import '../../home_screens/component/read_more_text.dart';

class AddPlanSheet extends StatefulWidget {
  final int? day;
  final int? id;
  final int? experianceId;
  final String? experianceName;
  final String? experianceLocation;
  final String? experianceDescription;
  final String? experianceTime;
  const AddPlanSheet(
      {super.key,
      this.day,
      this.id,
      this.experianceId,
      this.experianceName,
      this.experianceLocation,
      this.experianceDescription,
      this.experianceTime});

  @override
  State<AddPlanSheet> createState() => _AddPlanSheetState();
}

class _AddPlanSheetState extends State<AddPlanSheet> {
  @override
  void initState() {
    super.initState();
    UserViewModel().getToken().then((value) {
      token = value;
      setState(() {});
    });
  }

  String? token;
  final TextEditingController noteController = TextEditingController();
  int? day;
  @override
  Widget build(BuildContext context) {
    final addPlanning = Provider.of<AddReelsPlanningViewModel>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add this Latqa to your trip day from below and also you can add a note for this latqa.',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  color: AppColors.whiteTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 20),
              SelectedList(
                id: widget.id,
                day: widget.day,
                experianceTime: widget.experianceTime,
                onSelect: ((val) {
                  day = val;
                  setState(() {});
                }),
              ),
              const SizedBox(height: 20),
              NoteTextBox(
                controller: noteController,
                maxLines: 2,
                hintText: 'Write a Notes...',
              ),
              const SizedBox(height: 20),
              ExpansionTile(
                backgroundColor: AppColors.whiteTextColor.withOpacity(0.2),
                collapsedBackgroundColor:
                    AppColors.whiteTextColor.withOpacity(0.2),
                initiallyExpanded: true,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                childrenPadding: EdgeInsets.zero,
                collapsedIconColor: AppColors.whiteTextColor,
                collapsedShape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const CustomText(
                  data: 'Latqa Details',
                  fontColor: AppColors.whiteTextColor,
                  fSize: 16,
                  fweight: FontWeight.w600,
                ),
                children: [
                  const Divider(
                    color: AppColors.whiteTextColor,
                    thickness: 0.6,
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      CustomText(
                        data: widget.experianceName ?? 'Place Name would be here',
                        fontColor: AppColors.whiteTextColor,
                        fSize: 16,
                        fweight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColors.whiteTextColor.withOpacity(0.7),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      CustomText(
                        data: widget.experianceLocation ?? 'Mumbai, Maharastra',
                        fweight: FontWeight.w400,
                        fSize: 15,
                        fontColor: AppColors.whiteTextColor.withOpacity(0.7),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Icon(
                        Icons.calendar_month_sharp,
                        color: AppColors.whiteTextColor.withOpacity(0.7),
                        size: 16,
                      ),
                      const SizedBox(width: 10),
                      CustomText(
                        data: widget.experianceTime ??
                            '25th Jan 2023 - 30th Jan 2023 (5 Days)',
                        fweight: FontWeight.w400,
                        fSize: 14,
                        fontColor: AppColors.whiteTextColor.withOpacity(0.7),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomReadMoreText(
                      content: widget.experianceDescription ??
                          'Lorem ipsum dolor sit amet consectetur. Enim justo tellus odio vitae ullamcorper adipiscing est. Phasellus proin non orci consectetur. Id sit lectus morbi nulla Tristique.',
                      color: AppColors.whiteTextColor.withOpacity(0.7),
                      mColor: AppColors.whiteTextColor,
                      rColor: AppColors.whiteTextColor,
                      trimLines: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (day == null) {
                    Utils.toastMessage('Please Select Day!');
                  } else if (noteController.text.isEmpty) {
                    Utils.toastMessage('Please Enter Your Note !');
                  } else {
                    Map<String, String> data = {
                      "plan_id": '${widget.id}',
                      "experience_id": '${widget.experianceId}',
                      "day_count": '$day',
                      'notes': noteController.text.toString(),
                    };
                    addPlanning
                        .addReelsPlanningApi(widget.id!,token!, data, context);
                  }
                },
                child:  MainButton(
                  loading: addPlanning.addReelsPlanningLoadings,
                  data: 'Add to Plan',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
