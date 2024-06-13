import 'dart:io';
import 'package:airjood/res/components/mainbutton.dart';
import 'package:airjood/res/components/maintextfild.dart';
import 'package:airjood/utils/utils.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/Cuntry_State.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/slider.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/upload_image.dart';
import 'package:airjood/view_model/add_planning_view_model.dart';
import 'package:airjood/view_model/state_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../data/response/status.dart';
import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';
import '../../../view_model/country_view_model.dart';
import '../../../view_model/user_view_model.dart';
import '../home_screens/screen_widget/select_start_date.dart';

class AddPlanningScreen extends StatefulWidget {
  const AddPlanningScreen({super.key});

  @override
  State<AddPlanningScreen> createState() => _AddPlanningScreenState();
}

class _AddPlanningScreenState extends State<AddPlanningScreen> {
  @override
  void initState() {
    super.initState();
    UserViewModel().getToken().then((value) {
      token = value;
      Provider.of<CountryViewModel>(context, listen: false)
          .countryGetApi(value!);
      setState(() {});
    });
  }

  String? token;
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
  File? image;
  String? duration;
  final TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final addPlanning = Provider.of<AddPlanningViewModel>(context);
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
                name: 'Upload Thumbnail Image for your Trip',
                onValue: ((val) {
                  image = val;
                  setState(() {});
                }),
              ),
              const SizedBox(height: 20),
              MainTextFild(
                controller: titleController,
                hintText: 'Your Plan Title',
                maxLines: 1,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Consumer<CountryViewModel>(
                    builder: (context, value, child) {
                      switch (value.countryData.status) {
                        case Status.LOADING:
                          return Expanded(
                            child: CountryCityDrop(
                              data: 'Select Country',
                              onChanged: (value) {},
                              value: selectedItem,
                              items: const [],
                            ),
                          );
                        case Status.ERROR:
                          return Container();
                        case Status.COMPLETED:
                          List<Map<String, dynamic>>? countryItems =
                              value.countryData.data?.data?.map((country) {
                            return {
                              'id': country.id.toString(),
                              'name': country.name,
                            };
                          }).toList();
                          return Expanded(
                            child: CountryCityDrop(
                              data: 'Select Country',
                              onChanged: (value) {
                                setState(() {
                                  selectedItem = value;
                                  Provider.of<StateViewModel>(context,
                                          listen: false)
                                      .stateGetApi(token!, value);
                                });
                              },
                              value: selectedItem,
                              items: countryItems,
                            ),
                          );
                        default:
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Consumer<StateViewModel>(
                    builder: (context, value, child) {
                      switch (value.stateData.status) {
                        case Status.LOADING:
                          return Expanded(
                            child: CountryCityDrop(
                              data: 'Select State',
                              onChanged: (value) {},
                              value: selectedItem2,
                              items: const [],
                            ),
                          );
                        case Status.ERROR:
                          return Container();
                        case Status.COMPLETED:
                          List<Map<String, dynamic>>? countryItems =
                              value.stateData.data?.data?.map((country) {
                            return {
                              'id': country.id.toString(),
                              'name': country.name ?? '',
                            };
                          }).toList();
                          countryItems = countryItems
                              ?.toSet()
                              .toList();
                          if (countryItems != null &&
                              !countryItems
                                  .any((item) => item['id'] == selectedItem2)) {
                            selectedItem2 = null; // Reset if invalid
                          }
                          return Expanded(
                            child: CountryCityDrop(
                              data: 'Select State',
                              onChanged: (value) {
                                setState(() {
                                  selectedItem2 = value;
                                });
                              },
                              value: selectedItem2,
                              items: countryItems,
                            ),
                          );
                        default:
                      }
                      return Container();
                    },
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
              SliderWidget(
                duration: 0,
                onValue: ((val) {
                  duration = val.toString();
                  setState(() {});
                }),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  if (image == null) {
                    Utils.toastMessage('Please Upload Thumbnail !');
                  } else if (titleController.text.isEmpty) {
                    Utils.toastMessage('Please Enter Title !');
                  } else if (selectedItem == null) {
                    Utils.toastMessage('Please Select Country !');
                  } else if (selectedDate == null && selectedDate2 == null && duration == null) {
                    Utils.toastMessage('Please Select Start Date & End Date or Duration !');
                  } else if (selectedDate != null && selectedDate2 != null && duration != null) {
                    Utils.toastMessage('Please Select Either Dates or Duration, not both!');
                  } else {
                    Map<String, String> data = {
                      'title': titleController.text.toString(),
                      'country': '$selectedItem',
                      if (selectedItem2 != null) 'state': '$selectedItem2',
                      if (selectedDate != null) 'start_date': '${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}',
                      if (selectedDate2 != null) 'end_date': '${selectedDate2?.year}-${selectedDate2?.month}-${selectedDate2?.day}',
                      if (duration != null) 'plan_duration': duration.toString() ,
                    };
                    addPlanning
                        .addPlanningApi(token!, data, image!,edit: false, context);
                  }
                },
                child: MainButton(
                  loading: addPlanning.addPlanningLoadings,
                  data: 'Create Plan',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
