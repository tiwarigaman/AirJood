import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/components/color.dart';

class SelectStartDate extends StatefulWidget {
  final String? data;
  final GestureTapCallback? onTap;
  final String? formattedDate;
  const SelectStartDate({super.key, this.data, this.onTap, this.formattedDate});

  @override
  State<SelectStartDate> createState() => _SelectStartDateState();
}

class _SelectStartDateState extends State<SelectStartDate> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: ShapeDecoration(
          color: AppColors.textFildBGColor,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                width: 1, color: AppColors.textFildBorderColor),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: widget.formattedDate == null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/icons/calender.png',
                        height: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        maxLines: 1,
                        '${widget.data}',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                          color: AppColors.textFildHintColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/icons/calender.png',
                        height: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${widget.formattedDate}',
                        style: GoogleFonts.nunito(
                            color: AppColors.blackTextColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
