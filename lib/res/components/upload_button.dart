import 'package:airjood/res/components/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomText.dart';

class UploadButton extends StatefulWidget {
  final String name;
  final String title;
  const UploadButton({super.key, required this.name, required this.title});

  @override
  State<UploadButton> createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        Image.asset(
          'assets/images/uploadbg.png',
          fit: BoxFit.fill,
          height: 190,
          width: double.maxFinite,
        ),
        Image.asset(
          'assets/images/uploadbgstack.png',
          height: 190,
          fit: BoxFit.fill,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset(
                      'assets/images/upload_bg_dot.png',
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Image.asset(
                          widget.name,
                          height: 25,
                          width: 25,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              CustomText(
                data: widget.title,
                fontColor: AppColors.whiteTextColor,
                fSize: 22,
                fweight: FontWeight.w700,
              ),
              const SizedBox(
                height: 7,
              ),
              const CustomText(
                data: 'Lorem ipsum dolor sit amet consectetur.Pharetra',
                fontColor: AppColors.whiteTextColor,
                fSize: 12,
                fweight: FontWeight.w400,
              ),
              const CustomText(
                data: 'aliquam in porttitor amet morbi non sit.',
                fontColor: AppColors.whiteTextColor,
                fSize: 12,
                fweight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
