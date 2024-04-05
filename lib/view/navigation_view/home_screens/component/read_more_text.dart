import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CustomReadMoreText extends StatefulWidget {
  final String content;
  final Color color;
  final Color mColor;
  final Color rColor;
  final int trimLines;
  const CustomReadMoreText(
      {super.key,
      required this.content,
      required this.color,
      required this.mColor,
      required this.rColor,
      required this.trimLines});

  @override
  State<CustomReadMoreText> createState() => _CustomReadMoreTextState();
}

class _CustomReadMoreTextState extends State<CustomReadMoreText> {
  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      widget.content,
      style: TextStyle(
          fontWeight: FontWeight.w400, fontSize: 15, color: widget.color),
      trimLines: widget.trimLines,
      textAlign: TextAlign.justify,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'more',
      trimExpandedText: '..Read less',
      moreStyle: TextStyle(
        color: widget.mColor,
        fontWeight: FontWeight.bold,
      ),
      lessStyle: TextStyle(
        color: widget.rColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
