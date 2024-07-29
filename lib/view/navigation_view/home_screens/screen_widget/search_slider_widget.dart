import 'package:airjood/res/components/maintextfild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';

class SearchSliderWidget extends StatefulWidget {
  final Function? low;
  final Function? high;
  const SearchSliderWidget({super.key, this.low, this.high});

  @override
  State<SearchSliderWidget> createState() => _SearchSliderWidgetState();
}

class _SearchSliderWidgetState extends State<SearchSliderWidget> {
  dynamic _low;
  dynamic _hei;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 40,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: AppColors.textFildBGColor,
              borderRadius: BorderRadius.circular(10),
              border:
              Border.all(color: AppColors.textFildBorderColor),
            ),
            child: Center(
              child: CustomText(
                data: '${_low == null ? 30 : _low.toInt()}',
                color: AppColors.mainColor,
                fSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: FlutterSlider(
            values: [_low ?? 30, _hei ?? 420],
            max: 2000,
            min: 1,
            rangeSlider: true,
            handlerHeight: 25,
            handlerWidth: 25,
            trackBar: FlutterSliderTrackBar(
              activeTrackBarHeight: 5,
              inactiveTrackBarHeight: 4,
              activeTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              inactiveTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            tooltip: FlutterSliderTooltip(
              alwaysShowTooltip: true,
              custom: (value) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDADDEE),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      '${value.toInt()}',
                      style: GoogleFonts.nunitoSans(
                        color: AppColors.mainColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                );
              },
              positionOffset: FlutterSliderTooltipPositionOffset(
                right: 0,
                left: 2,
                top: 44,
              ),
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              setState(() {
                _low = lowerValue;
                _hei = upperValue;
                widget.low!(_low.toInt());
                widget.high!(_hei.toInt());
              });
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: Container(
            height: 40,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: AppColors.textFildBGColor,
              borderRadius: BorderRadius.circular(10),
              border:
              Border.all(color: AppColors.textFildBorderColor),
            ),
            child: Center(
              child: CustomText(
                data: '${_hei == null ? 420 : _hei.toInt()}',
                color: AppColors.mainColor,
                fSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
