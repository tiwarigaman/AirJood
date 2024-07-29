import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatefulWidget {
  final String? data;
  final double? fSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? overflow;
  final int? maxLines;
  final Color? decorationColor;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  const CustomText(
      {super.key,
      this.data,
      this.fSize,
      this.fontWeight,
      this.color,
      this.overflow,
      this.maxLines,
      this.decorationColor,
      this.decoration, this.textAlign});

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.data}',
      overflow: widget.overflow,
      maxLines: widget.maxLines,
      textAlign: widget.textAlign,
      style: GoogleFonts.nunitoSans(
        color: widget.color,
        fontSize: widget.fSize,
        fontWeight: widget.fontWeight,
        decorationColor: widget.decorationColor,
        decoration: widget.decoration,
      ),
    );
  }
}
