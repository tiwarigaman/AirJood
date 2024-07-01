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
        MultiSelectItem('Amharic', 'Amharic'),
        MultiSelectItem('Arabic', 'Arabic'),
        MultiSelectItem('Bengali', 'Bengali'),
        MultiSelectItem('Burmese', 'Burmese'),
        MultiSelectItem('Cantonese', 'Cantonese'),
        MultiSelectItem('Dutch', 'Dutch'),
        MultiSelectItem('English', 'English'),
        MultiSelectItem('Farsi (Persian)', 'Farsi (Persian)'),
        MultiSelectItem('French', 'French'),
        MultiSelectItem('German', 'German'),
        MultiSelectItem('Gujarati', 'Gujarati'),
        MultiSelectItem('Hausa', 'Hausa'),
        MultiSelectItem('Hindi', 'Hebrew'),
        MultiSelectItem('Hindi', 'Hindi'),
        MultiSelectItem('Igbo', 'Igbo'),
        MultiSelectItem('Indonesian', 'Indonesian'),
        MultiSelectItem('Italian', 'Italian'),
        MultiSelectItem('Japanese', 'Japanese'),
        MultiSelectItem('Javanese', 'Javanese'),
        MultiSelectItem('Kannada', 'Kannada'),
        MultiSelectItem('Korean', 'Korean'),
        MultiSelectItem('Malay', 'Malay'),
        MultiSelectItem('Malayalam', 'Malayalam'),
        MultiSelectItem('Mandarin Chinese', 'Mandarin Chinese'),
        MultiSelectItem('Marathi', 'Marathi'),
        MultiSelectItem('Nepali', 'Nepali'),
        MultiSelectItem('Pashto', 'Pashto'),
        MultiSelectItem('Polish', 'Polish'),
        MultiSelectItem('Portuguese', 'Portuguese'),
        MultiSelectItem('Punjabi', 'Punjabi'),
        MultiSelectItem('Romanian', 'Romanian'),
        MultiSelectItem('Russian', 'Russian'),
        MultiSelectItem('Spanish', 'Spanish'),
        MultiSelectItem('Swahili', 'Swahili'),
        MultiSelectItem('Tagalog', 'Tagalog'),
        MultiSelectItem('Tamil', 'Tamil'),
        MultiSelectItem('Telugu', 'Telugu'),
        MultiSelectItem('Thai', 'Thai'),
        MultiSelectItem('Turkish', 'Turkish'),
        MultiSelectItem('Vietnamese', 'Vietnamese'),
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
