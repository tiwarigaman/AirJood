import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/components/color.dart';

class CountryCityDrop extends StatefulWidget {
  final ValueChanged? onChanged;
  final value;
  final List? items;
  final String? data;

  const CountryCityDrop(
      {super.key, this.onChanged, this.value, this.items, this.data});

  @override
  State<CountryCityDrop> createState() => _CountryCityDropState();
}

class _CountryCityDropState extends State<CountryCityDrop> {
  // List items = [
  //   {'id': '0', 'name': 'Male', },
  //   {'id': '1', 'name': 'Female', },
  //   {'id': '2', 'name': 'Other', },
  // ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      // width: MediaQuery.of(context).size.width / 2,
      decoration: ShapeDecoration(
        color: AppColors.textFildBGColor,
        shape: RoundedRectangleBorder(
          side:
              const BorderSide(width: 1, color: AppColors.textFildBorderColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DropdownButton(
          dropdownColor: Colors.white,
          iconEnabledColor: AppColors.textFildHintColor,
          hint: Text(
            '${widget.data}',
            style: GoogleFonts.nunito(
              color: AppColors.textFildHintColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          underline: Container(),
          value: widget.value,
          borderRadius: BorderRadius.circular(10),
          iconSize: 35,
          isExpanded: true,
          padding: EdgeInsets.zero,
          menuMaxHeight: 400,
          onChanged: widget.onChanged,
          items: widget.items?.map((drop) {
            return DropdownMenuItem<String>(
              value: drop['id'],
              child: Text(
                "${drop['name']}",
                style: GoogleFonts.nunito(
                  color: AppColors.blackTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
