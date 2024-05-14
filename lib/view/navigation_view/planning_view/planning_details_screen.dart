import 'package:airjood/res/components/color.dart';
import 'package:airjood/res/components/mainbutton.dart';
import 'package:airjood/view/navigation_view/planning_view/plan_details_screen.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/plan_container.dart';
import 'package:flutter/material.dart';
import '../../../res/components/CustomText.dart';

class PlanningDetailsScreen extends StatefulWidget {
  const PlanningDetailsScreen({super.key});

  @override
  State<PlanningDetailsScreen> createState() => _PlanningDetailsScreenState();
}

class _PlanningDetailsScreenState extends State<PlanningDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      body: Column(
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
                            Image.asset(
                              'assets/images/Maskgroup.png',
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
                                child: Container(
                                  color: Colors.black.withOpacity(0.2),
                                  child: const Icon(Icons.arrow_back_ios_new,
                                      color: AppColors.whiteTextColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 160),
                      ],
                    ),
                    const PlanContainer(),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 0),
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
                    data: 'Create a plan & add or schedule plan from Laqta.',
                    fSize: 13,
                    fweight: FontWeight.w400,
                    fontColor: AppColors.greyTextColor,
                  ),
                ),
                GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1 / 1.3,
                  ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  children: List.generate(
                    9,
                    (index) {
                      return Container(
                        // width: 100,
                        // height: 160,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        margin: const EdgeInsets.only(top: 10,left: 5,right: 5),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                'assets/images/image1.png',
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
                                      Colors.black.withOpacity(0.0),
                                      Colors.black.withOpacity(0.2),
                                      Colors.black.withOpacity(0.5),
                                      Colors.black.withOpacity(0.8),
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
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
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 8.0, right: 20, bottom: 8.0 + padding.bottom),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PlanDetailsScreen(),),);
              },
                child: const MainButton(data: 'View Plan'),
            ),
          ),
        ],
      ),
    );
  }
}
