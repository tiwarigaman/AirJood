import 'package:airjood/res/components/mainbutton.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/date_time_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import '../../../../../data/response/status.dart';
import '../../../../../res/components/CustomText.dart';
import '../../../../../res/components/color.dart';
import '../../../../../view_model/facilities_view_model.dart';
import '../../../../../view_model/mood_view_model.dart';
import '../../../../../view_model/user_view_model.dart';
import '../../screen_widget/facilities_drop.dart';
import '../../screen_widget/mood_drop.dart';

class BookNowSecondScreen extends StatefulWidget {
  final Function? onTap;
  const BookNowSecondScreen({super.key, this.onTap});

  @override
  State<BookNowSecondScreen> createState() => _BookNowSecondScreenState();
}

class _BookNowSecondScreenState extends State<BookNowSecondScreen> {
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

  final TextEditingController guestController = TextEditingController();
  List? selected;
  List? selectedMood;
  dynamic _low;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: InkWell(
          onTap: () {
            widget.onTap!();
          },
          child: const MainButton(
            data: 'Next - Payments',
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data: 'AL khayma Camp',
                        fweight: FontWeight.w800,
                        fSize: 18,
                        fontColor: AppColors.blackTextColor,
                      ),
                      CustomText(
                        data: '9 Al Khayma Camp, Dubai, UAE',
                        fweight: FontWeight.w600,
                        fSize: 13,
                        fontColor: AppColors.greyTextColor,
                      ),
                    ],
                  ),
                  CustomText(
                    data: '\$195.67',
                    fweight: FontWeight.w800,
                    fSize: 20,
                    fontColor: AppColors.mainColor,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const DateTimeTabWidget(),
              const SizedBox(height: 20),
              Consumer<MoodViewModel>(
                builder: (context, value, child) {
                  switch (value.moodData.status) {
                    case Status.LOADING:
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
                    case Status.ERROR:
                      return const SizedBox();
                    case Status.COMPLETED:
                      List<Map<String, String>> itemsList = [];
                      for (int i = 0; i < value.moodData.data!.length; i++) {
                        final moodItem = value.moodData.data![i];
                        itemsList.add({
                          'id': '${moodItem.id}',
                          'name': '${moodItem.mood}'
                        });
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
                height: 15,
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
                      return const SizedBox();
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
              const SizedBox(height: 15),
              const CustomText(
                data: 'No of Guests',
                fweight: FontWeight.w500,
                fSize: 17,
                fontColor: AppColors.blackTextColor,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: FlutterSlider(
                      values: [_low ?? 12],
                      max: 15,
                      min: 0,
                      handlerHeight: 25,
                      handlerWidth: 25,
                      trackBar: FlutterSliderTrackBar(
                        activeTrackBarHeight: 5,
                        inactiveTrackBarHeight: 4,
                        activeTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        inactiveTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      tooltip: FlutterSliderTooltip(
                        alwaysShowTooltip: true,
                        custom: (value) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDADDEE),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '${value.toInt()}',
                                style: GoogleFonts.nunitoSans(
                                  color: AppColors.mainColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          );
                        },
                        positionOffset: FlutterSliderTooltipPositionOffset(
                          right: 0,
                          left: 2,
                          top: 44,
                        ),
                      ),
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        setState(() {
                          _low = lowerValue;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 40,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: AppColors.textFildBGColor,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: AppColors.textFildBorderColor),
                      ),
                      child: Center(
                        child: CustomText(
                          data: '${_low == null ? 12 : _low.toInt()}',
                          fontColor: AppColors.mainColor,
                          fSize: 16,
                          fweight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }
}
