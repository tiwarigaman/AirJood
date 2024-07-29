import 'package:airjood/res/components/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomText.dart';

class UploadButton extends StatefulWidget {
  final String name;
  final String title;
  final bool? isLoading;
  const UploadButton({super.key, required this.name, required this.title,this.isLoading});

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
          height: 210,
          width: double.maxFinite,
        ),
        Image.asset(
          'assets/images/uploadbgstack.png',
          height: 210,
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
                        child: widget.isLoading == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.mainColor,
                                ),
                              )
                            : Image.asset(
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
                color: AppColors.whiteTextColor,
                fSize: 22,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                height: 7,
              ),
              const CustomText(
                data: 'Lorem ipsum dolor sit amet consectetur.Pharetra',
                color: AppColors.whiteTextColor,
                fSize: 12,
                fontWeight: FontWeight.w400,
              ),
              const CustomText(
                data: 'aliquam in porttitor amet morbi non sit.',
                color: AppColors.whiteTextColor,
                fSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
