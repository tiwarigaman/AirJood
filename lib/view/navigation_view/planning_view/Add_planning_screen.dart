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
    UserViewModel().getUser().then((value) {
      imaged = value?.profileImageUrl;
      setState(() {});
    });
  }

  String? token;
  DateTime? selectedDate;
  DateTime? selectedDate2;
  String? formattedDate;
  String? formattedDate2;
  String? selectedItem;
  String? selectedItem2;
  File? image;
  String? imaged;
  String? images;
  String? duration;
  final TextEditingController titleController = TextEditingController();
  int sliderValue = 0;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
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
      initialDate: selectedDate2 ?? DateTime.now(),
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

  void _resetForm() {
    setState(() {
      image = null;
      titleController.clear();
      selectedItem = null;
      selectedItem2 = null;
      selectedDate = null;
      selectedDate2 = null;
      formattedDate = null;
      formattedDate2 = null;
      sliderValue = 0;
      duration = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final addPlanning = Provider.of<AddPlanningViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        actions: [
          const SizedBox(width: 5),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 35,
              weight: 2,
            ),
          ),
          const CustomText(
            data: 'Create Planning',
            fSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
          const Spacer(),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: _resetForm,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const CustomText(
                data: 'Reset',
                fSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.whiteTextColor,
              ),
            ),
          ),
          const SizedBox(width: 15),
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
                image: image,
                onValue: (val) {
                  image = val;
                  setState(() {});
                },
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
                          return Container();
                      }
                    },
                  ),
                  const SizedBox(width: 10),
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
                          countryItems = countryItems?.toSet().toList();
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
                          return Container();
                      }
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
                  const SizedBox(width: 10),
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
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
              const SizedBox(height: 10),
              SliderWidget(
                duration: sliderValue,
                onValue: (val) {
                  duration = val.toString();
                  setState(() {
                    sliderValue = val;
                  });
                },
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
                  } else if (selectedDate == null &&
                      selectedDate2 == null &&
                      duration == null) {
                    Utils.toastMessage(
                        'Please Select Start Date & End Date or Duration !');
                  } else if (selectedDate != null &&
                      selectedDate2 != null &&
                      duration != null) {
                    Utils.toastMessage(
                        'Please Select Either Dates or Duration, not both!');
                  } else {
                    Map<String, String> data = {
                      'title': titleController.text.toString(),
                      'country': '$selectedItem',
                      if (selectedItem2 != null) 'state': '$selectedItem2',
                      if (selectedDate != null)
                        'start_date':
                        '${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}',
                      if (selectedDate2 != null)
                        'end_date':
                        '${selectedDate2?.year}-${selectedDate2?.month}-${selectedDate2?.day}',
                      if (duration != null)
                        'plan_duration': duration.toString(),
                    };
                    addPlanning.addPlanningApi(
                        token!, data, image!, edit: false, context);
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


// appBar: AppBar(
//   automaticallyImplyLeading: false,
//   backgroundColor: AppColors.whiteColor,
//   actions: [
//     const SizedBox(width: 20),
//     const Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomText(
//           data: 'Create Planning',
//           fSize: 21,
//           fweight: FontWeight.w700,
//           fontColor: AppColors.blackColor,
//         ),
//         CustomText(
//           data: 'Create a plan & add or schedule plan from Laqta.',
//           fSize: 13,
//           fweight: FontWeight.w400,
//           fontColor: AppColors.greyTextColor,
//         ),
//       ],
//     ),
//     const Spacer(),
//     InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const UserDetailsScreen(
//               screen: 'MyScreen',
//             ),
//           ),
//         ).then((value) {
//           UserViewModel().getUser().then((value) {
//             images = value?.profileImageUrl;
//             // widget.getImage!(value?.profileImageUrl);
//             setState(() {});
//           });
//         });
//       },
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(100),
//         child: CachedNetworkImage(
//           imageUrl: '$imaged',
//           fit: BoxFit.cover,
//           height: 40,
//           width: 40,
//           errorWidget: (context, url, error) {
//             return ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(
//                 'https://airjood.neuronsit.in/storage/profile_images/TOAeh3xMyzAz2SOjz2xYu7GvC2yePHMqoTKd3pWJ.png',
//                 fit: BoxFit.cover,
//                 height: 40,
//                 width: 40,
//                 errorBuilder: (context, error, stackTrace) {
//                   return const Icon(Icons.error);
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     ),
//     const SizedBox(width: 20),
//   ],
// ),
