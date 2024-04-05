import 'package:airjood/res/components/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scroll_datetime_picker/scroll_datetime_picker.dart';

class DateTimeTabWidget extends StatefulWidget {
  const DateTimeTabWidget({super.key});

  @override
  State<DateTimeTabWidget> createState() => _DateTimeTabWidgetState();
}

class _DateTimeTabWidgetState extends State<DateTimeTabWidget>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  DateTime time = DateTime.now();
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int indexs = 0;
  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('E dd MMM yyy');
    String formattedDate = dateFormat.format(_selectedDate);
    String formattedTime = DateFormat('HH:mm:ss').format(time);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.textFildBGColor,
          ),
          child: TabBar(
              onTap: (p0) {
                indexs = p0;
                setState(() {});
              },
              controller: _tabController,
              indicatorColor: AppColors.transperent,
              indicator: const ShapeDecoration(shape: InputBorder.none),
              dividerColor: AppColors.transperent,
              dividerHeight: 0,
              labelStyle: GoogleFonts.nunitoSans(
                color: AppColors.mainColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              unselectedLabelStyle: GoogleFonts.nunitoSans(
                color: AppColors.secondTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              padding: const EdgeInsets.all(0),
              indicatorPadding: const EdgeInsets.all(0),
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              tabs: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: indexs == 0 ? Colors.white : AppColors.transperent,
                  ),
                  child: Tab(
                    text: formattedDate,
                  ),
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: indexs == 1 ? Colors.white : AppColors.transperent,
                  ),
                  child: Tab(
                    text: formattedTime,
                  ),
                ),
              ]),
        ),
        Center(
          child: [
            SizedBox(
              height: 200,
              child: ScrollDateTimePicker(
                itemExtent: 54,
                infiniteScroll: true,
                style: DateTimePickerStyle(
                  activeStyle: GoogleFonts.nunitoSans(
                    color: AppColors.mainColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  centerDecoration: BoxDecoration(
                    color: AppColors.blueBGShadeColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  inactiveStyle: GoogleFonts.nunitoSans(
                    color: AppColors.mainColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                dateOption: DateTimePickerOption(
                  dateFormat: DateFormat('EEEddMMMMy'),
                  minDate: DateTime(1900, 6),
                  maxDate: DateTime(2024, 6),
                  initialDate: _selectedDate,
                ),
                onChange: (datetime) => setState(() {
                  _selectedDate = datetime;
                }),
              ),
            ),
            SizedBox(
              height: 200,
              child: ScrollDateTimePicker(
                itemExtent: 54,
                infiniteScroll: true,
                style: DateTimePickerStyle(
                  activeStyle: GoogleFonts.nunitoSans(
                    color: AppColors.mainColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                  centerDecoration: BoxDecoration(
                    color: AppColors.blueBGShadeColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  inactiveStyle: GoogleFonts.nunitoSans(
                    color: AppColors.mainColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                dateOption: DateTimePickerOption(
                  dateFormat: DateFormat.jm(),
                  minDate: DateTime(1900, 6),
                  maxDate: DateTime(2024, 6),
                  initialDate: time,
                ),
                onChange: (datetime) => setState(() {
                  time = datetime;
                }),
              ),
            ),
          ][_tabController.index],
        ),
      ],
    );
  }
}
