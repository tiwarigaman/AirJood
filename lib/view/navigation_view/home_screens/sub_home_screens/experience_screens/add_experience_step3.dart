import 'dart:convert';
import 'dart:io';

import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/res/components/color.dart';
import 'package:airjood/view/navigation_view/home_screens/component/read_more_text.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/google_location_box.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/radio_widget.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/select_start_date.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/select_start_time.dart';

import 'package:airjood/view_model/facilities_view_model.dart';
import 'package:airjood/view_model/mood_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import '../../../../../data/response/status.dart';
import '../../../../../res/components/mainbutton.dart';
import '../../../../../res/components/maintextfild.dart';
import '../../../../../utils/utils.dart';
import '../../../../../view_model/user_view_model.dart';
import '../../../planning_view/screen_widgets/upload_image.dart';
import '../../screen_widget/facilities_drop.dart';
import '../../screen_widget/mood_drop.dart';

class AddExperienceStep3 extends StatefulWidget {
  final Function? onNextTap;
  final int? id;
  final String? image;
  final String? video;
  final String? activity;
  final String? description;

  const AddExperienceStep3(
      {super.key,
      this.onNextTap,
      this.id,
      this.image,
      this.video,
      this.activity,
      this.description});

  @override
  State<AddExperienceStep3> createState() => _AddExperienceStep3State();
}

class _AddExperienceStep3State extends State<AddExperienceStep3> {
  String? selectedItem;
  String? selectedItem2;
  String? selectedItem3;
  String? selectedItem4;
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

  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        formattedTime = _selectedTime.format(context);
      });
    }
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        formattedTime2 = selectedTime.format(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    UserViewModel().getToken().then((value) {
      Provider.of<MoodViewModel>(context, listen: false).moodGetApi(value!);
    });
    UserViewModel().getToken().then((value) {
      Provider.of<FacilitiesViewModel>(context, listen: false)
          .facilitiesGetApi(value!);
    });
  }

  String? formattedDate;
  String? formattedDate2;
  String? formattedTime;
  String? formattedTime2;
  File? image;
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String? location;
  String? cit;
  String? cou;
  String? sta;
  String? lats;
  String? lngs;
  String? radioValue;
  List? selected;
  List? selectedMood;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    '${widget.image}',
                    height: 110,
                    width: 85,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data: '${widget.activity}',
                        fweight: FontWeight.w700,
                        fSize: 18,
                        fontColor: AppColors.blackTextColor,
                      ),
                      CustomReadMoreText(
                        mColor: AppColors.mainColor,
                        rColor: AppColors.mainColor,
                        trimLines: 4,
                        content: widget.description ??
                            "Lorem ipsum dolor sit amet consectetur. Enim justo tellus odio vitae ullamcorper adipiscing est. Phasellus proin non orci consectetur. Id sit lectus morbi nulla Tristique.",
                        color: AppColors.secondTextColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GoogleLocationBox(
              setLocation: ((val) async {
                location = val;
                List<String> addressComponents = val.split(', ') ?? [];
                String city = addressComponents.length >= 2
                    ? addressComponents[addressComponents.length - 2]
                    : '';
                String country = addressComponents.isNotEmpty
                    ? addressComponents[addressComponents.length - 1]
                    : '';
                String state = addressComponents.length >= 3
                    ? addressComponents[addressComponents.length - 3]
                    : '';
                String addressQuery = val.replaceAll(' ', '+');
                String apiKey = 'AIzaSyCGzdWSRPmwqh8Lor3UsWsEO9HArG9u64s';
                String apiUrl =
                    'https://maps.googleapis.com/maps/api/geocode/json?address=$addressQuery&key=$apiKey';
                http.Response response = await http.get(Uri.parse(apiUrl));
                Map<String, dynamic> data = json.decode(response.body);
                double lat = data['results'][0]['geometry']['location']['lat'];
                double lng = data['results'][0]['geometry']['location']['lng'];
                setState(() {
                  cit = city;
                  cou = country;
                  sta = state;
                  lats = lat.toString();
                  lngs = lng.toString();
                });
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: SelectStartTime(
                    data: 'Start Time',
                    onTap: () {
                      _selectTime(context);
                    },
                    formattedTime: formattedTime,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SelectStartTime(
                    data: 'End Time',
                    onTap: () {
                      selectTime(context);
                    },
                    formattedTime: formattedTime2,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
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
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: MainTextFild(
                    controller: minController,
                    prefixIcon: const Icon(
                      CupertinoIcons.person,
                      color: AppColors.textFildHintColor,
                    ),
                    labelText: 'min person',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MainTextFild(
                    controller: maxController,
                    prefixIcon: const Icon(
                      CupertinoIcons.person,
                      color: AppColors.textFildHintColor,
                    ),
                    labelText: 'max person',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            RadioWidget(
              selectedOption: radioValue,
              setValue: ((val) {
                radioValue = val;
              }),
            ),
            MainTextFild(
              controller: priceController,
              prefixIcon: const Icon(CupertinoIcons.money_dollar,
                  color: AppColors.textFildHintColor),
              labelText: "Enter price per Experience",
              maxLines: 1,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            UploadImage(
              name: 'Upload Fridge Magnet',
              onValue: ((val) {
                setState(() {
                  image = val;
                });
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<MoodViewModel>(
              builder: (context, value, child) {
                switch (value.moodData.status) {
                  case Status.LOADING:
                    return MoodDrop(
                      items: value.moodData.data?.map((item) {
                            return MultiSelectItem(
                                '${item.id}', '${item.mood}');
                          }).toList() ??
                          [],
                      onConfirm: (results) {},
                    );
                  case Status.ERROR:
                    return MoodDrop(
                      items: value.moodData.data?.map((item) {
                            return MultiSelectItem(
                                '${item.id}', '${item.mood}');
                          }).toList() ??
                          [],
                      onConfirm: (results) {},
                    );
                  case Status.COMPLETED:
                    List<Map<String, String>> itemsList = [];
                    for (int i = 0; i < value.moodData.data!.length; i++) {
                      final moodItem = value.moodData.data![i];
                      itemsList.add(
                          {'id': '${moodItem.id}', 'name': '${moodItem.mood}'});
                    }
                    return MoodDrop(
                      initialValue: selectedMood,
                      items: value.moodData.data?.map((item) {
                            return MultiSelectItem(
                                '${item.id}', '${item.mood}');
                          }).toList() ??
                          [],
                      onConfirm: (results) {
                        setState(() {
                          selectedMood = results;
                        });
                      },
                    );
                  default:
                }
                return Container();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<FacilitiesViewModel>(
              builder: (context, value, child) {
                switch (value.facilitiesData.status) {
                  case Status.LOADING:
                    return FacilitiesDrop(
                      initialValue: selected,
                      items: value.facilitiesData.data?.map((item) {
                            return MultiSelectItem(
                                '${item.id}', '${item.facility}');
                          }).toList() ??
                          [],
                      onConfirm: (results) {
                        setState(() {
                          selected = results;
                        });
                      },
                    );
                  case Status.ERROR:
                    return FacilitiesDrop(
                      initialValue: selected,
                      items: value.facilitiesData.data?.map((item) {
                            return MultiSelectItem(
                                '${item.id}', '${item.facility}');
                          }).toList() ??
                          [],
                      onConfirm: (results) {
                        setState(() {
                          selected = results;
                        });
                      },
                    );
                  case Status.COMPLETED:
                    return FacilitiesDrop(
                      initialValue: selected,
                      items: value.facilitiesData.data?.map((item) {
                            return MultiSelectItem(
                                '${item.id}', '${item.facility}');
                          }).toList() ??
                          [],
                      onConfirm: (results) {
                        setState(() {
                          selected = results;
                        });
                      },
                    );
                  default:
                }
                return Container();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                if (location == null) {
                  Utils.toastMessage('Please Enter location');
                } else if (_selectedTime == null || selectedTime == null) {
                  Utils.toastMessage('Please Select StartTime and EndTime');
                } else if (selectedDate == null || selectedDate2 == null) {
                  Utils.toastMessage('Please Select StartDate and EndDate');
                } else if (minController.text.isEmpty ||
                    maxController.text.isEmpty) {
                  Utils.toastMessage('Please Enter Min/Max Person');
                } else if (priceController.text.isEmpty) {
                  Utils.toastMessage('Please Enter Price');
                } else if (image == null) {
                  Utils.toastMessage('Please Select Fridge Magnet');
                } else if (selectedMood == null) {
                  Utils.toastMessage('Please Select Mood');
                } else if (selected == null) {
                  Utils.toastMessage('Please Select Facilities');
                } else {
                  widget.onNextTap!({
                    "location": location,
                    "city": cit,
                    "state": sta,
                    "country": cou,
                    "lat": lats,
                    "lng": lngs,
                    "startDate":
                        "${selectedDate?.year}/${selectedDate?.month}/${selectedDate?.day}",
                    "endDate":
                        "${selectedDate2?.year}/${selectedDate2?.month}/${selectedDate2?.day}",
                    "startTime":
                        "${_selectedTime.hour}:${_selectedTime.minute}",
                    "endTime": "${selectedTime.hour}:${selectedTime.minute}",
                    "minPerson": minController.text,
                    "maxPerson": maxController.text,
                    "radio": radioValue,
                    "price": priceController.text,
                    "fridgeImage": image,
                    "mood": selectedMood,
                    "facilities": selected,
                  });
                }
              },
              child: const MainButton(
                data: 'Next ',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Row(
// children: [
// Expanded(
// child: SelectCountry(
// onChanged: (value) {
// setState(() {
// selectedItem = value as String?;
// });
// },
// value: selectedItem,
// ),
// ),
// const SizedBox(
// width: 10,
// ),
// Expanded(
// child: SelectCity(
// onChanged: (value) {
// setState(() {
// selectedItem2 = value as String?;
// });
// },
// value: selectedItem2,
// ),
// ),
// ],
// ),
