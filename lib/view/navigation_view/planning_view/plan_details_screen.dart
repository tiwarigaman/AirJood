import 'package:airjood/view/navigation_view/planning_view/screen_widgets/plan_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_planner/time_planner.dart';

import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';
import '../home_screens/component/read_more_text.dart';

class PlanDetailsScreen extends StatefulWidget {
  const PlanDetailsScreen({super.key});

  @override
  State<PlanDetailsScreen> createState() => _PlanDetailsScreenState();
}

class _PlanDetailsScreenState extends State<PlanDetailsScreen> {
  List<TimePlannerTask> tasks = [
    TimePlannerTask(
      color: Colors.transparent,
      dateTime: TimePlannerDateTime(day: 0, hour: 8, minutes: 00),
      minutesDuration: 360,
      daysDuration: 2,
      onTap: () {},
      widthTask: 135,
      child:  ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/images/image1.png',
          fit: BoxFit.fill,
        ),
      ),
    ),
    TimePlannerTask(
      color: Colors.transparent,
      dateTime: TimePlannerDateTime(day: 0, hour: 14, minutes: 00),
      minutesDuration: 360,
      daysDuration: 1,
      onTap: () {},
      widthTask: 135,
      leftSpace: 120,
      child:  ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/images/image1.png',
          fit: BoxFit.fill,
        ),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        actions: [
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 35,
              weight: 2,
            ),
          ),
          const CustomText(
            data: 'Plan Details',
            fSize: 22,
            fweight: FontWeight.w700,
            fontColor: AppColors.blackColor,
          ),
          const Spacer(),
        ],
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Center(child: PlanContainer(screen: 'planScreen',)),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: 500,
                  child: TimePlanner(
                    use24HourFormat: true,
                    setTimeOnAxis: true,
                    style: TimePlannerStyle(
                      backgroundColor: const Color(0xFFF1F1F8),
                      //backgroundColor: Colors.red,
                      cellHeight: 30,
                      cellWidth: 260,
                      dividerColor: Colors.white.withOpacity(0.5),
                      showScrollBar: true,
                      horizontalTaskPadding: 0,
                      // borderRadius: const BorderRadius.all(Radius.circular(100)),
                    ),
                    startHour: 7,
                    endHour: 19,
                    currentTimeAnimation: true,
                    headers:  [
                      TimePlannerTitle(
                        title: "Day 1",
                        titleStyle: GoogleFonts.nunito(
                          color: AppColors.mainColor,
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                        ),
                        date: '',
                        dateStyle: const TextStyle(
                          fontSize: 0
                        ),
                      ),
                      TimePlannerTitle(
                        title: "Day 2",
                        titleStyle: GoogleFonts.nunito(
                          color: AppColors.mainColor,
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                        ),
                        date: '',
                        dateStyle: const TextStyle(
                            fontSize: 0
                        ),
                      ),
                      TimePlannerTitle(
                        title: "Day 3",
                        titleStyle: GoogleFonts.nunito(
                          color: AppColors.mainColor,
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                        ),
                        date: '',
                        dateStyle: const TextStyle(
                            fontSize: 0
                        ),
                      ),
                    ],
                    tasks: tasks,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/image1.png',
                        height: 110,
                        width: 85,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'AL khayma Camp',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const Icon(CupertinoIcons.trash,size: 20,),
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(Icons.location_on_outlined,color: AppColors.splashTextColor,size: 20,),
                            SizedBox(width: 10),
                            CustomText(
                              data: 'Mumbai, Maharashtra',
                              fweight: FontWeight.w600,
                              fSize: 14,
                              fontColor: AppColors.splashTextColor,
                            ),
                          ],
                        ),
                        const CustomReadMoreText(
                          mColor: AppColors.mainColor,
                          rColor: AppColors.mainColor,
                          trimLines: 3,
                          content: 'Lorem ipsum dolor sit amet consectetur. Enim justo tellus odio vitae ullamcorper adipiscing est. Phasellus proin non orci consectetur. Id sit lectus morbi nulla Tristique.',
                          color: AppColors.secondTextColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
