import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/components/color.dart';

class NoteTextBox extends StatefulWidget {
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
  const NoteTextBox({super.key, this.labelText, this.prefixIcon, this.suffixIcon, this.maxLines, this.hintText, this.controller, this.readOnly, this.onTap, this.keyboardType, this.onChanged, this.onFieldSubmitted, this.initialValue});

  @override
  State<NoteTextBox> createState() => _NoteTextBoxState();
}

class _NoteTextBoxState extends State<NoteTextBox> {
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
        color: AppColors.whiteColor,
      ),
      maxLines: widget.maxLines,
      readOnly: widget.readOnly ?? false,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.whiteTextColor.withOpacity(0.2),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        prefixIcon: widget.prefixIcon,
        prefixStyle: const TextStyle(color: AppColors.textFildHintColor),
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: AppColors.textFildHintColor),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.nunito(color: AppColors.whiteTextColor,fontSize: 15),
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
