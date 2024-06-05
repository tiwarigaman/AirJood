import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/res/components/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListContainerWidget extends StatefulWidget {
  const ListContainerWidget({super.key});

  @override
  State<ListContainerWidget> createState() => _ListContainerWidgetState();
}

class _ListContainerWidgetState extends State<ListContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.textFildBorderColor,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/Maskgroup.png'),
                  const SizedBox(height: 60),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    margin: const EdgeInsets.only(left: 10, bottom: 15),
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
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      CustomText(
                        data: 'Community Name Here',
                        fSize: 17,
                        fweight: FontWeight.w600,
                        fontColor: AppColors.blackTextColor,
                      ),
                      CustomText(
                        data: '25k Members',
                        fSize: 14,
                        fweight: FontWeight.w500,
                        fontColor: AppColors.secondTextColor,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

        ],
      ),
    );
  }
}
