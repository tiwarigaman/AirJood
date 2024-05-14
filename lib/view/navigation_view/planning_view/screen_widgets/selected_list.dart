import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/components/color.dart';

class SelectedList extends StatefulWidget {
  const SelectedList({super.key});

  @override
  State<SelectedList> createState() => _SelectedListState();
}

class _SelectedListState extends State<SelectedList> {
  int selectedIndex = 1;
  final List data = [
    {'day' : '3','time':'5:30 AM - 4:30PM'},
    {'day' : '4','time':'5:30 AM - 4:30PM'},
    {'day' : '5','time':'5:30 AM - 4:30PM'},
    {'day' : '6','time':'5:30 AM - 4:30PM'},
    {'day' : '7','time':'5:30 AM - 4:30PM'},
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  selectedIndex = index; // Set the selected index
                });
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
                          'Day: ${data[index]['day']}',
                          style: GoogleFonts.nunitoSans(
                            color: AppColors.whiteTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${data[index]['time']}',
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
