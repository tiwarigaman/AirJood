import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatefulWidget {
  final String? data;
  final double? fSize;
  final fweight;

  final fontColor;
  const CustomText(
      {super.key, this.data, this.fSize, this.fweight, this.fontColor});

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.data}',
      style: GoogleFonts.nunitoSans(
        color: widget.fontColor,
        fontSize: widget.fSize,
        //fontFamily: 'Euclid Circular A',
        fontWeight: widget.fweight,
      ),
    );
  }
}
