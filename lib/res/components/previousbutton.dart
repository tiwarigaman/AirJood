import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

class PreviousButton extends StatefulWidget {
  final String? data;
  final IconData? icon;
  const PreviousButton({super.key, this.data, this.icon});

  @override
  State<PreviousButton> createState() => _PreviousButtonState();
}

class _PreviousButtonState extends State<PreviousButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 132,
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF5A5A74)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            size: 18,
            color: AppColors.mainColor,
            weight: 3,
          ),
          const SizedBox(width: 10),
          Text(
            '${widget.data}',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunitoSans(
              color: AppColors.mainColor,
              fontSize: 16,
              // fontFamily: 'Euclid Circular A',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
