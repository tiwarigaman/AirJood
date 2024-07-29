import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';

class SliderWidget extends StatefulWidget {
  final Function? onValue;
  final int? duration;

  const SliderWidget({super.key, this.onValue, this.duration});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  dynamic _low = 0.0;

  @override
  void initState() {
    _low = widget.duration?.toDouble();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SliderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      setState(() {
        _low = widget.duration?.toDouble();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: FlutterSlider(
            values: [_low],
            max: 20.0,
            min: 0.0,
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
                widget.onValue!(_low.toInt());
              });
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 40,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: AppColors.textFildBGColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.textFildBorderColor),
            ),
            child: Center(
              child: CustomText(
                data: '${_low.toInt()}',
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
