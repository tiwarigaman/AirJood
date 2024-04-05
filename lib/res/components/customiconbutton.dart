
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'CustomText.dart';
import 'color.dart';

class CustomIconButton extends StatefulWidget {
  final String? data;
  final String? assetName;
  const CustomIconButton({super.key, this.data, this.assetName});

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: ShapeDecoration(
        color: AppColors.textFildBGColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          SvgPicture.asset('${widget.assetName}'),
          const SizedBox(
            width: 15,
          ),
          CustomText(
            data: '${widget.data}',
            fontColor: AppColors.blackTextColor,
            fweight: FontWeight.w500,
            fSize: 16,
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
