import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/select_list_container.dart';
import 'package:airjood/view/navigation_view/planning_view/Add_planning_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../res/components/color.dart';
import '../../planning_view/screen_widgets/add_plan_sheet.dart';

class PlanningWidget extends StatefulWidget {
  const PlanningWidget({super.key});

  @override
  State<PlanningWidget> createState() => _PlanningWidgetState();
}

class _PlanningWidgetState extends State<PlanningWidget> {
  @override
  Widget build(BuildContext context) {
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
              // height: 70,
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
            const SelectListContainer(),
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
                        showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          backgroundColor: Colors.black.withOpacity(0.9),
                          showDragHandle: true,
                          constraints: BoxConstraints.expand(
                              height: MediaQuery.of(context).size.height / 1.4),
                          isScrollControlled: true,
                          context: context,
                          builder: (_) => const AddPlanSheet(),
                        );
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
