import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';

class PlanContainer extends StatelessWidget {
  const PlanContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: BoxDecoration(
        color: AppColors.blueShade,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                const CustomText(
                  data: 'Plan Title Name Here',
                  fweight: FontWeight.w700,
                  fSize: 16,
                  fontColor: AppColors.blackTextColor,
                ),
                const Spacer(),
                SvgPicture.asset('assets/svg/editIcon.svg'),
                const SizedBox(width: 15),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
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
            const SizedBox(height: 10),
            const Row(
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
            const SizedBox(height: 10),
            AvatarStack(
              height: 25,
              width: 90,
              settings: RestrictedAmountPositions(
                maxAmountItems: 6,
                maxCoverage: 0.7,
                minCoverage: 0.1,
              ),
              avatars: [
                for (var n = 0; n < 6; n++)
                  NetworkImage('https://i.pravatar.cc/150?img=$n'),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                CustomText(
                  data: '@Saimon J, @Leena S, @Magdalina K,',
                  fweight: FontWeight.w400,
                  fSize: 13,
                  fontColor: AppColors.greyTextColor,
                ),
                CustomText(
                  data: '+ 6more ',
                  fweight: FontWeight.w800,
                  fSize: 14,
                  fontColor: AppColors.greyTextColor,
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
