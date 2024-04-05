import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import 'color.dart';

class MobileTextFiled extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<Country>? onCountryChanged;
  final ValueChanged<PhoneNumber>? onChanged;
  const MobileTextFiled(
      {super.key, this.controller, this.onCountryChanged, this.onChanged});

  @override
  State<MobileTextFiled> createState() => _MobileTextFiledState();
}

class _MobileTextFiledState extends State<MobileTextFiled> {
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: widget.controller,
      focusNode: focusNode,
      showCountryFlag: false,
      flagsButtonMargin:
          const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      dropdownIcon: const Icon(
        Icons.phone_android_rounded,
        color: AppColors.textFildHintColor,
      ),
      style:
          GoogleFonts.nunito(color: Colors.black, fontWeight: FontWeight.w600),
      dropdownTextStyle:
          GoogleFonts.nunito(color: Colors.black, fontWeight: FontWeight.w600),
      dropdownDecoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Color(0xFF909090),
            width: 1,
          ),
        ),
      ),
      decoration: const InputDecoration(
        filled: true,
        fillColor: AppColors.textFildBGColor,
        labelText: 'Enter your phone number',
        labelStyle: TextStyle(color: AppColors.textFildHintColor),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: AppColors.textFildBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: AppColors.textFildBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: AppColors.textFildBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      languageCode: "en",
      disableLengthCheck: true,
      onChanged: widget.onChanged,
      onCountryChanged: widget.onCountryChanged,
    );
  }
}
