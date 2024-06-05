import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/components/color.dart';

class SelectedList extends StatefulWidget {
  final int? day;
  final int? id;
  final String? experianceTime;
  final Function? onSelect;
  const SelectedList({super.key, this.day, this.id, this.onSelect, this.experianceTime});

  @override
  State<SelectedList> createState() => _SelectedListState();
}

class _SelectedListState extends State<SelectedList> {
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.day,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  selectedIndex = index; // Set the selected index
                });
                if (widget.onSelect != null) {
                  widget.onSelect!(selectedIndex! + 1);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? AppColors.blueShadeColor.withOpacity(0.2)
                      : AppColors.whiteTextColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: selectedIndex == index
                      ? AppColors.blueShadeColor
                      : AppColors.whiteTextColor.withOpacity(0.1))
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Day: ${index+1}',
                          style: GoogleFonts.nunitoSans(
                            color: AppColors.whiteTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          widget.experianceTime ?? '5:30 AM - 4:30PM',
                          style: GoogleFonts.nunitoSans(
                            color: AppColors.whiteTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
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
