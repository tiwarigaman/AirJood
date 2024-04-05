import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

class CustomDropdownButton extends StatefulWidget {
  final ValueChanged? onChanged;
  final value;
  final List<DropdownMenuItem>? items;
  const CustomDropdownButton(
      {super.key, this.onChanged, this.value, this.items});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  List items = [
    {'id': '0', 'name': 'Male', "image": "assets/icons/male.png"},
    {'id': '1', 'name': 'Female', "image": "assets/icons/woman.png"},
    {'id': '2', 'name': 'Other', "image": "assets/icons/other.png"},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width / 2,
      decoration: ShapeDecoration(
        color: AppColors.textFildBGColor,
        shape: RoundedRectangleBorder(
          side:
              const BorderSide(width: 1, color: AppColors.textFildBorderColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton(
          dropdownColor: Colors.white,
          iconEnabledColor: AppColors.textFildHintColor,
          hint: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              Image.asset(
                'assets/icons/gender.png',
                height: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Gender',
                style: GoogleFonts.nunito(
                    color: AppColors.textFildHintColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          underline: Container(),
          value: widget.value,
          borderRadius: BorderRadius.circular(10),
          iconSize: 35,
          isExpanded: true,
          onChanged: widget.onChanged,
          items: items.map((drop) {
            return DropdownMenuItem<String>(
              value: drop['id'],
              child: Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    "${drop['image']}",
                    height: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${drop['name']}",
                    style: GoogleFonts.nunito(
                        color: AppColors.blackTextColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
