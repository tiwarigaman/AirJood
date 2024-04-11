import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

class MainTextFild extends StatefulWidget {
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final String? hintText;
  final TextEditingController? controller;
  final bool? readOnly;
  final GestureTapCallback? onTap;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final String? initialValue;
  const MainTextFild({
    super.key,
    this.initialValue,
    this.labelText,
    this.prefixIcon,
    this.maxLines,
    this.suffixIcon,
    this.hintText,
    this.controller,
    this.readOnly,
    this.onTap,
    this.keyboardType,
    this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  State<MainTextFild> createState() => _MainTextFildState();
}

class _MainTextFildState extends State<MainTextFild> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      onTap: widget.onTap,
      controller: widget.controller,
      style: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.blackColor,
      ),
      maxLines: widget.maxLines,
      readOnly: widget.readOnly ?? false,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.textFildBGColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        prefixIcon: widget.prefixIcon,
        prefixStyle: const TextStyle(color: AppColors.textFildHintColor),
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: AppColors.textFildHintColor),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: AppColors.textFildHintColor),
        enabledBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: AppColors.textFildBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: AppColors.textFildBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: AppColors.textFildBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
