import 'package:airjood/res/components/mainbutton.dart';
import 'package:airjood/res/components/maintextfild.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/Cuntry_State.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/slider.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/upload_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';
import '../home_screens/screen_widget/select_start_date.dart';

class AddPlanningScreen extends StatefulWidget {
  const AddPlanningScreen({super.key});

  @override
  State<AddPlanningScreen> createState() => _AddPlanningScreenState();
}

class _AddPlanningScreenState extends State<AddPlanningScreen> {
  DateTime? selectedDate;
  DateTime? selectedDate2;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('d MMM yyyy').format(selectedDate!);
      });
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate2,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate2) {
      setState(() {
        selectedDate2 = picked;
        formattedDate2 = DateFormat('d MMM yyyy').format(selectedDate2!);
      });
    }
  }

  String? formattedDate;
  String? formattedDate2;
  String? selectedItem;
  String? selectedItem2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        actions: const [
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                data: 'Create Planning',
                fSize: 21,
                fweight: FontWeight.w700,
                fontColor: AppColors.blackColor,
              ),
              CustomText(
                data: 'Create a plan & add or schedule plan from Laqta.',
                fSize: 13,
                fweight: FontWeight.w400,
                fontColor: AppColors.greyTextColor,
              ),
            ],
          ),
          Spacer(),
          CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage(
              'assets/images/personbig.png',
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UploadImage(
                onValue: ((val) {
                  if (kDebugMode) {
                    print(val);
                  }
                }),
              ),
              const SizedBox(height: 20),
              const MainTextFild(
                hintText: 'Your Plan Title',
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CountryCityDrop(
                      data: 'Select Country',
                      onChanged: (value) {
                        setState(() {
                          selectedItem = value as String?;
                        });
                      },
                      value: selectedItem,
                      items: const [
                        {'id': '0', 'name': 'Country 1', },
                        {'id': '1', 'name': 'Country 2', },
                        {'id': '2', 'name': 'Country 3', },
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CountryCityDrop(
                      data: 'Select State',
                      onChanged: (value) {
                        setState(() {
                          selectedItem2 = value as String?;
                        });
                      },
                      value: selectedItem2,
                      items: const [
                        {'id': '0', 'name': 'State 1', },
                        {'id': '1', 'name': 'State 2', },
                        {'id': '2', 'name': 'State 3', },
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: SelectStartDate(
                      data: 'Start Date',
                      onTap: () {
                        _selectDate(context);
                      },
                      formattedDate: formattedDate,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SelectStartDate(
                      data: 'End Date',
                      onTap: () {
                        selectDate(context);
                      },
                      formattedDate: formattedDate2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const CustomText(
                data: 'Or you can select the duration (In Days)',
                fSize: 17,
                fweight: FontWeight.w500,
                fontColor: AppColors.blackColor,
              ),
              const SizedBox(height: 10),
              const SliderWidget(),
              const SizedBox(height: 40),
              const MainButton(data: 'Create Plan'),
            ],
          ),
        ),
      ),
    );
  }
}
