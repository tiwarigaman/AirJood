import 'package:flutter/material.dart';

import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';

class DashBoardWidget extends StatefulWidget {
  const DashBoardWidget({super.key});

  @override
  State<DashBoardWidget> createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          data: 'Bookings',
          fweight: FontWeight.w800,
          fSize: 18,
          fontColor: AppColors.blackTextColor,
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.containerBorderColor),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/images/user.png',
                            height: 45,
                            width: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const CustomText(
                          data: '\$195.67',
                          fweight: FontWeight.w800,
                          fSize: 18,
                          fontColor: AppColors.mainColor,
                        ),
                      ],
                    ),
                    const CustomText(
                      data: 'David Warner',
                      fweight: FontWeight.w700,
                      fSize: 18,
                      fontColor: AppColors.blackTextColor,
                    ),
                    const CustomText(
                      data: '9 Al Khayma Camp, Dubai, UAE',
                      fweight: FontWeight.w600,
                      fSize: 13,
                      fontColor: AppColors.greyTextColor,
                    ),
                    const SizedBox(height: 3),
                    const CustomText(
                      data: 'Mon 15, Mar 23 - 17:30 PM',
                      fweight: FontWeight.w600,
                      fSize: 13,
                      fontColor: AppColors.blackTextColor,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
