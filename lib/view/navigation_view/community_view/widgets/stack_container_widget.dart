import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:flutter/material.dart';

import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';

class StackContainerWidget extends StatefulWidget {
  const StackContainerWidget({super.key});

  @override
  State<StackContainerWidget> createState() => _StackContainerWidgetState();
}

class _StackContainerWidgetState extends State<StackContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
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
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.whiteTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 55),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 95,
              width: 95,
              margin: const EdgeInsets.only(left: 10, bottom: 0),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.greenColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset('assets/images/appicon.png'),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const CustomText(
                  data: 'Community Name Here',
                  fSize: 17,
                  fweight: FontWeight.w600,
                  fontColor: AppColors.blackTextColor,
                ),
                Row(
                  children: [
                    AvatarStack(
                      height: 25,
                      width: 75,
                      settings: RestrictedAmountPositions(
                        maxAmountItems: 5,
                        maxCoverage: 0.5,
                        minCoverage: 0.1,
                      ),
                      avatars: [
                        for (var n = 0; n < 5; n++)
                          NetworkImage(
                              'https://i.pravatar.cc/150?img=$n'),
                      ],
                    ),
                    const SizedBox(width: 10),
                    const CustomText(
                      data: '25k Members',
                      fSize: 14,
                      fweight: FontWeight.w500,
                      fontColor: AppColors.secondTextColor,
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 6),
              margin: const EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Row(
                children: [
                  Icon(Icons.add,color: AppColors.whiteColor,size: 15,),
                  SizedBox(width: 5),
                  CustomText(
                    data: 'Join',
                    fontColor: AppColors.whiteTextColor,
                    fweight: FontWeight.w500,
                    fSize: 15,
                  )
                ],
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}
