import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../res/components/color.dart';

class MoodDrop extends StatefulWidget {
  final List? initialValue;
  final void Function(List) onConfirm;
  final List<MultiSelectItem> items;
  const MoodDrop(
      {super.key,
      this.initialValue,
      required this.onConfirm,
      required this.items});

  @override
  State<MoodDrop> createState() => _MoodDropState();
}

class _MoodDropState extends State<MoodDrop> {
  @override
  Widget build(BuildContext context) {
    return MultiSelectDialogField(
      items: widget.items,
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
        color: AppColors.textFildHintColor,
      ),
      checkColor: AppColors.whiteColor,
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
        "Select Mood",
        style: GoogleFonts.nunitoSans(
          height: 1.9,
          color: AppColors.textFildHintColor,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      onConfirm: widget.onConfirm,
    );
  }
}
