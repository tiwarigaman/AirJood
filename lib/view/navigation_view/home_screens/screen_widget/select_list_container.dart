import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../planning_view/planning_details_screen.dart';

class SelectListContainer extends StatefulWidget {
  const SelectListContainer({super.key});

  @override
  State<SelectListContainer> createState() => _SelectListContainerState();
}

class _SelectListContainerState extends State<SelectListContainer> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          //physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PlanningDetailsScreen()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.containerBorderColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/Maskgroup.png',
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            const CustomText(
                              data: 'Plan Title Name Here',
                              fweight: FontWeight.w700,
                              fSize: 16,
                              fontColor: AppColors.blackTextColor,
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: selectedIndex == index
                                  ? const Icon(Icons.check_circle,size: 25)
                                  : const Icon(Icons.circle_outlined,size: 25),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: AppColors.textFildHintColor,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            CustomText(
                              data: 'Mumbai, Maharastra',
                              fweight: FontWeight.w400,
                              fSize: 15,
                              fontColor: AppColors.greyTextColor,
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_sharp,
                              color: AppColors.textFildHintColor,
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            CustomText(
                              data: '25th Jan 2023 - 30th Jan 2023 (5 Days)',
                              fweight: FontWeight.w400,
                              fSize: 14,
                              fontColor: AppColors.greyTextColor,
                            ),
                          ],
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
    );
  }
}
