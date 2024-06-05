import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/utils/utils.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/select_list_container.dart';
import 'package:airjood/view/navigation_view/planning_view/Add_planning_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../res/components/color.dart';
import '../../../../view_model/get_planning_list_view_model.dart';
import '../../../../view_model/upload_experiance_view_model.dart';
import '../../../../view_model/user_view_model.dart';
import '../../planning_view/screen_widgets/add_plan_sheet.dart';

class PlanningWidget extends StatefulWidget {
  final int? experianceId;
  const PlanningWidget({super.key, this.experianceId});

  @override
  State<PlanningWidget> createState() => _PlanningWidgetState();
}

class _PlanningWidgetState extends State<PlanningWidget> {
  @override
  void initState() {
    super.initState();
    UserViewModel().getToken().then((value) {
      Provider.of<GetPlanningListViewModel>(context, listen: false)
          .planningListGetApi(value!);
      Provider.of<UploadExperianceViewModel>(context, listen: false)
          .getUploadExperianceListApi(value, widget.experianceId!);
    });
  }

  int? day;
  int? id;
  @override
  Widget build(BuildContext context) {
    final experiance = Provider.of<UploadExperianceViewModel>(context);
    final startDate = experiance.getUploadExperianceData.data?.startDate;
    final endDate = experiance.getUploadExperianceData.data?.endDate;
    String formattedTime = '';
    String formattedTime2 = '';

    if (startDate != null && endDate != null) {
      DateTime dateTime = DateTime.parse(startDate.toString());
      formattedTime = DateFormat('h:mm a').format(dateTime);
      DateTime dateTime2 = DateTime.parse(endDate.toString());
      formattedTime2 = DateFormat('h:mm a').format(dateTime2);
    }
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFFF1F1F8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        data: 'Add to Planning',
                        fontColor: AppColors.blackTextColor,
                        fSize: 20,
                        fweight: FontWeight.w600,
                      ),
                      CustomText(
                        data:
                            'Add this Latqa to your planning and enjoy a easy trip.',
                        fontColor: AppColors.secondTextColor,
                        fSize: 13,
                        fweight: FontWeight.w400,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(CupertinoIcons.clear),
                  )
                ],
              ),
            ),
            SelectListContainer(
              onSelect: ((val) {
                id = val['id'];
                day = val['day'];
                setState(() {});
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 20, left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddPlanningScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.mainColor)),
                        child: const Center(
                          child: CustomText(
                            data: 'Create New Plan',
                            fweight: FontWeight.w700,
                            fSize: 16,
                            fontColor: AppColors.mainColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (id == null || day == null) {
                          Utils.tostMessage('Please select plan !');
                        } else {
                          showModalBottomSheet(
                            barrierColor: Colors.transparent,
                            backgroundColor: Colors.black.withOpacity(0.9),
                            showDragHandle: true,
                            constraints: BoxConstraints.expand(
                                height:
                                    MediaQuery.of(context).size.height / 1.4),
                            isScrollControlled: true,
                            context: context,
                            builder: (_) => AddPlanSheet(
                              id: id,
                              day: day,
                              experianceId: widget.experianceId,
                              experianceDescription: experiance
                                  .getUploadExperianceData.data?.description,
                              experianceLocation:
                                  '${experiance.getUploadExperianceData.data?.country} , ${experiance.getUploadExperianceData.data?.state}',
                              experianceName:
                                  experiance.getUploadExperianceData.data?.name,
                              experianceTime:
                                  '$formattedTime - $formattedTime2',
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.mainColor)),
                        child: const Center(
                          child: CustomText(
                            data: 'Add to this Plan',
                            fweight: FontWeight.w700,
                            fSize: 16,
                            fontColor: AppColors.whiteTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
