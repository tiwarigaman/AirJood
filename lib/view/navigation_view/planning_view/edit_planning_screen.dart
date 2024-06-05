import 'dart:io';
import 'package:airjood/res/components/mainbutton.dart';
import 'package:airjood/res/components/maintextfild.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/Cuntry_State.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/slider.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/upload_image.dart';
import 'package:airjood/view_model/add_planning_view_model.dart';
import 'package:airjood/view_model/state_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../../data/response/status.dart';
import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';
import '../../../utils/utils.dart';
import '../../../view_model/country_view_model.dart';
import '../../../view_model/user_view_model.dart';
import '../home_screens/screen_widget/select_start_date.dart';
import 'package:http/http.dart' as http;
class EditPlanningScreen extends StatefulWidget {
  final int? planId;
  final String? imageUrl;
  final String? title;
  final String? country;
  final String? state;
  final String? startDate;
  final String? endDate;
  final String? duration;
  const EditPlanningScreen({super.key, this.imageUrl, this.title, this.country, this.state, this.startDate, this.endDate, this.duration, this.planId});

  @override
  State<EditPlanningScreen> createState() => _EditPlanningScreenState();
}

class _EditPlanningScreenState extends State<EditPlanningScreen> {
  @override
  void initState() {
    super.initState();
    _downloadImage();
    formattedDate = widget.startDate;
    formattedDate2 = widget.endDate;
    selectedItem = widget.country;
    selectedItem2 = widget.state;
    duration = widget.duration;
    UserViewModel().getToken().then((value) {
      token = value;
      Provider.of<CountryViewModel>(context, listen: false).countryGetApi(value!);
    });
    setState(() {});
  }

  String? token;
  DateTime? selectedDate;
  DateTime? selectedDate2;
  bool isUploadingNewImage = false;

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
  Future<void> _downloadImage() async {
    final response = await http.get(Uri.parse(widget.imageUrl!));
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final filePath = '${documentsDirectory.path}/plan_image.png';
    image = File(filePath);
    await image!.writeAsBytes(response.bodyBytes);
    setState(() {});
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
    titleController.text = widget.title!;
    int durations = int.parse('${widget.duration}');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        actions: [
          const SizedBox(
            width: 5,
          ),
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
            data: 'Edit Planning',
            fSize: 22,
            fweight: FontWeight.w700,
            fontColor: AppColors.blackColor,
          ),
          const Spacer(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty && !isUploadingNewImage)
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: widget.imageUrl!,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isUploadingNewImage = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Upload New Image',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (isUploadingNewImage || widget.imageUrl == null || widget.imageUrl!.isEmpty)
                UploadImage(
                  name: 'Upload Thumbnail Image for your Trip',
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
                          List<Map<String, dynamic>>? countryItems = value.countryData.data?.data?.map((country) {
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
                                  Provider.of<StateViewModel>(context, listen: false).stateGetApi(token!, value);
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
                          List<Map<String, dynamic>>? countryItems = value.stateData.data?.data?.map((country) {
                            return {
                              'id': country.id.toString(),
                              'name': country.name ?? '',
                            };
                          }).toList();
                          countryItems = countryItems?.toSet().toList();
                          if (countryItems != null && !countryItems.any((item) => item['id'] == selectedItem2)) {
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
                duration: durations,
                onValue: (val) {
                  duration = val.toString();
                  setState(() {});
                },
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  if (widget.imageUrl == null &&image == null) {
                    Utils.tostMessage('Please Upload Thumbnail !');
                  } else if (titleController.text.isEmpty) {
                    Utils.tostMessage('Please Enter Title !');
                  } else if (selectedItem == null) {
                    Utils.tostMessage('Please Select Country !');
                  } else if (selectedDate == null && selectedDate2 == null && duration == null) {
                    Utils.tostMessage('Please Select Start Date & End Date or Duration !');
                  } else if (selectedDate != null && selectedDate2 != null && duration != null) {
                    Utils.tostMessage('Please Select Either Dates or Duration, not both!');
                  } else {
                    Map<String, String> data = {
                      'title': titleController.text.toString(),
                      'country': selectedItem.toString(),
                      if (selectedItem2 != null) 'state': selectedItem2.toString(),
                      if (selectedDate != null) 'start_date': '${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}',
                      if (selectedDate2 != null) 'end_date': '${selectedDate2?.year}-${selectedDate2?.month}-${selectedDate2?.day}',
                      if (duration != null) 'plan_duration': duration.toString(),
                    };
                    addPlanning.addPlanningApi(token!, data, image!, context,edit: true,planId: widget.planId);
                  }
                },
                child: MainButton(
                  loading: addPlanning.addPlanningLoadings,
                  data: 'Save Plan',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
