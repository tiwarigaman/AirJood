import 'package:airjood/res/components/CustomText.dart';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:flutter/material.dart';

import '../../../../res/components/color.dart';

class PlanWidgets extends StatefulWidget {
  const PlanWidgets({super.key});

  @override
  State<PlanWidgets> createState() => _PlanWidgetsState();
}

class _PlanWidgetsState extends State<PlanWidgets> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, index) {
        return Container(
          //height: 200,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: AppColors.textFildBorderColor,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/image1.png',
                  height: 100,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        data: 'France',
                        fweight: FontWeight.w700,
                        fSize: 20,
                      ),
                      const SizedBox(height: 5),
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
                    ],
                  ),
                  const Spacer(),
                  Image.asset(
                      'assets/images/rightconta.png',
                    height: 40,
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  CustomText(
                    data: '@Saimon J, @Leena S, @Magdalina K,',
                    fweight: FontWeight.w500,
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
            ],
          ),
        );
      },
    );
  }
}
