import 'package:flutter/material.dart';

import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';

class FacilitiesListWidget extends StatefulWidget {
  final int? count;
  final data;

  const FacilitiesListWidget({super.key, this.count, this.data});

  @override
  State<FacilitiesListWidget> createState() => _FacilitiesListWidgetState();
}

class _FacilitiesListWidgetState extends State<FacilitiesListWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemCount: widget.count,
        //shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var abc = widget.data[index];
          return Padding(
            padding: const EdgeInsets.all(3),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.textFildBGColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child: CustomText(
                    data: '${abc.facility}',
                    color: AppColors.greyTextColor,
                    fSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
