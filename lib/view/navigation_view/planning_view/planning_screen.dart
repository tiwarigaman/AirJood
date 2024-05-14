import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/res/components/color.dart';
import 'package:airjood/view/navigation_view/planning_view/Add_planning_screen.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/listContainer.dart';
import 'package:flutter/material.dart';

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({super.key});

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        actions: [
          const SizedBox(width: 20),
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                data: 'My Planning',
                fSize: 22,
                fweight: FontWeight.w600,
                fontColor: AppColors.blackColor,
              ),
              CustomText(
                data: 'Create a plan & add or schedule plan from Laqta.',
                fSize: 13,
                fweight: FontWeight.w400,
                fontColor: AppColors.greyTextColor,
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPlanningScreen()));
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.blueBGShadeColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.add, color: AppColors.blueColor,size: 26),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 80),
        child: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
          return const ListContainer();
        },),
      ),
    );
  }
}
