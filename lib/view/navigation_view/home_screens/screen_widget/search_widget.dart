import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/res/components/color.dart';
import 'package:airjood/res/components/datebutton.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/search_result_widget.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/search_slider_widget.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import '../../../../data/response/status.dart';
import '../../../../res/components/maintextfild.dart';
import '../../../../view_model/mood_view_model.dart';
import '../../../../view_model/search_view_model.dart';
import '../../../../view_model/user_view_model.dart';
import 'mood_drop.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String? selectedItem;
  String? selectedItem2;
  String? selectedItem3;
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('d MMM yyyy').format(selectedDate!);
      });
    }
  }

  String? formattedDate;
  bool switchValue = true;

  void onSwitchValueChanged(bool newValue) {
    setState(() {
      switchValue = newValue;
    });
  }

  @override
  void initState() {
    super.initState();
    UserViewModel().getToken().then((value) {
      token = value;
      Provider.of<MoodViewModel>(context, listen: false).moodGetApi(value!);
    });
  }

  final CustomSegmentedController controller =
      CustomSegmentedController(value: 0);
  TextEditingController location = TextEditingController();
  TextEditingController keyword = TextEditingController();
  TextEditingController userController = TextEditingController();
  String? token;
  String? priceForm;
  String? priceTo;
  List? selectedMood;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: AppColors.whiteColor,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      CupertinoIcons.xmark,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const CustomText(
                    data: 'Search',
                    fontWeight: FontWeight.w800,
                    fSize: 22,
                    color: AppColors.blackTextColor,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if (index == 0) {
                        Provider.of<SearchViewModel>(context, listen: false)
                            .searchGetApi(
                                token!,
                                location.text,
                                selectedDate?.day == null
                                    ? ''
                                    : '${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}',
                                priceTo ?? '30',
                                priceForm ?? '420',
                                selectedMood ?? [],
                                switchValue)
                            .then((value) {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            constraints: BoxConstraints.expand(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                width: MediaQuery.of(context).size.width),
                            isScrollControlled: true,
                            builder: (_) => const SearchResultWidget(search: 'reel'),
                          );
                        });
                      } else {
                        Provider.of<SearchViewModel>(context, listen: false)
                            .setPage(1);
                        Provider.of<SearchViewModel>(context, listen: false)
                            .clearData();
                        Provider.of<SearchViewModel>(context, listen: false)
                            .userListGetApi(token!, search: userController.text.toString()).then((value) {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            constraints: BoxConstraints.expand(
                                height:
                                MediaQuery.of(context).size.height * 0.75,
                                width: MediaQuery.of(context).size.width),
                            isScrollControlled: true,
                            builder: (_) => const SearchResultWidget(search: 'user'),
                          );
                        });
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: CustomText(
                          data: 'Search',
                          color: AppColors.whiteTextColor,
                          fSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              CustomSlidingSegmentedControl(
                initialValue: 1,
                children: const {
                  1: Text('Experiance'),
                  2: Text('User'),
                },
                fixedWidth: MediaQuery.of(context).size.width / 2.2,
                decoration: BoxDecoration(
                  color: CupertinoColors.lightBackgroundGray,
                  borderRadius: BorderRadius.circular(8),
                ),
                thumbDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInToLinear,
                controller: controller,
                onValueChanged: (v) {
                  index = v == 1 ? 0 : 1;
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: [
                  Column(
                    children: [
                      MainTextFild(
                        controller: location,
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppColors.textFildHintColor,
                        ),
                        hintText: "Location, Experience, Venue....",
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DateButton(
                        data: 'Select Date',
                        onTap: () {
                          _selectDate(context);
                        },
                        formattedDate: formattedDate,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SearchSliderWidget(
                        high: (val) {
                          priceForm = val.toString();
                          setState(() {});
                        },
                        low: (val) {
                          priceTo = val.toString();
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Consumer<MoodViewModel>(
                        builder: (context, value, child) {
                          switch (value.moodData.status) {
                            case Status.LOADING:
                              return MoodDrop(
                                items: const [],
                                onConfirm: (p0) {},
                              );
                            case Status.ERROR:
                              return MoodDrop(
                                items: const [],
                                onConfirm: (p0) {},
                              );
                            case Status.COMPLETED:
                              List<Map<String, String>> itemsList = [];
                              for (int i = 0;
                                  i < value.moodData.data!.data!.length;
                                  i++) {
                                final moodItem = value.moodData.data!.data![i];
                                itemsList.add({
                                  'id': '${moodItem.id}',
                                  'name': '${moodItem.mood}'
                                });
                              }
                              return MoodDrop(
                                initialValue: selectedMood,
                                items: value.moodData.data?.data?.map((item) {
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
                        height: 15,
                      ),
                      Row(
                        children: [
                          const CustomText(
                            data: 'Rate',
                            color: AppColors.blackTextColor,
                            fSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          RatingBar(
                            initialRating: 3,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            ratingWidget: RatingWidget(
                              full: const Icon(
                                Icons.star_rounded,
                                color: AppColors.amberColor,
                              ),
                              half: const Icon(
                                Icons.star_half_rounded,
                                color: AppColors.amberColor,
                              ),
                              empty: const Icon(
                                Icons.star_outline_rounded,
                                color: AppColors.secondTextColor,
                              ),
                            ),
                            itemSize: 30.0,
                            itemPadding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            onRatingUpdate: (double value) {},
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MainTextFild(
                        controller: keyword,
                        labelText: "# Keywords",
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            data: 'Add ons',
                            fontWeight: FontWeight.w500,
                            fSize: 17,
                            color: AppColors.blackTextColor,
                          ),
                          Switch(
                            value: switchValue,
                            onChanged: onSwitchValueChanged,
                            activeColor: AppColors.whiteTextColor,
                            activeTrackColor: AppColors.mainColor,
                            inactiveThumbColor: AppColors.whiteTextColor,
                            inactiveTrackColor: AppColors.textFildBorderColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MainTextFild(
                        controller: userController,
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppColors.textFildHintColor,
                        ),
                        hintText: "Search....",
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 400,
                      ),
                    ],
                  ),
                ][index],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
