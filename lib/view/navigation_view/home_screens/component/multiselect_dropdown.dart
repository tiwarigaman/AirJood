import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../res/components/color.dart';

class MultiSelectDrop extends StatefulWidget {
  final List? initialValue;
  final void Function(List) onConfirm;
  const MultiSelectDrop({
    super.key,
    this.initialValue,
    required this.onConfirm,
  });

  @override
  State<MultiSelectDrop> createState() => _MultiSelectDropState();
}

class _MultiSelectDropState extends State<MultiSelectDrop> {
  @override
  Widget build(BuildContext context) {
    return MultiSelectDialogField(
      items: [
        MultiSelectItem('English', 'English'),
        MultiSelectItem('Hindi', 'Hindi'),
        MultiSelectItem('Gujarati', 'Gujarati'),
        MultiSelectItem('France', 'France'),
        MultiSelectItem('Juryman', 'Juryman'),
        MultiSelectItem('Nepali', 'Nepali'),
      ],
      initialValue: widget.initialValue ?? [],
      selectedColor: AppColors.mainColor,
      decoration: BoxDecoration(
        color: AppColors.textFildBGColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: AppColors.textFildBorderColor,
          width: 1,
        ),
      ),
      buttonIcon: const Icon(
        Icons.arrow_drop_down,
      ),
      checkColor: AppColors.whiteColor,
      //barrierColor: AppColors.transperent,
      searchable: true,
      backgroundColor: AppColors.whiteColor,
      dialogHeight: MediaQuery.of(context).size.height / 2,
      dialogWidth: MediaQuery.of(context).size.height / 1.2,
      itemsTextStyle: GoogleFonts.nunitoSans(
        color: AppColors.blackTextColor,
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
      selectedItemsTextStyle: GoogleFonts.nunitoSans(
        color: AppColors.mainColor,
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
      buttonText: Text(
        "Select language",
        style: GoogleFonts.nunitoSans(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      onConfirm: widget.onConfirm,
    );
  }
}
