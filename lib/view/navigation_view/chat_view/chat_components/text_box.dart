import 'package:airjood/res/components/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBox extends StatelessWidget {
  const TextBox({super.key, required this.data, required this.num});

  final String data;
  final int num;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: num == 0 ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(
          right: num == 0 ? 5 : 50,
          left: num == 0 ? 50 : 5,
          top: 5,
          bottom: 5,
        ),
        decoration: BoxDecoration(
          color: num == 0 ? AppColors.mainColor : AppColors.textFildBGColor,
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(15),
            topLeft: Radius.circular(num == 0 ? 15 : 0),
            bottomLeft: const Radius.circular(15),
            bottomRight: Radius.circular(num == 0 ? 0 : 15),
          ),
        ),
        child: Text(
          data,
          style: GoogleFonts.nunito(
            color:
            num == 0 ? AppColors.whiteTextColor : AppColors.blackTextColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}