import 'package:airjood/res/components/mainbutton.dart';
import 'package:airjood/res/components/maintextfild.dart';
import 'package:airjood/utils/utils.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/date_time_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import '../../../../../res/components/CustomText.dart';
import '../../../../../res/components/color.dart';
import '../../../../../view_model/facilities_view_model.dart';
import '../../../../../view_model/mood_view_model.dart';
import '../../../../../view_model/user_view_model.dart';
import '../../screen_widget/facilities_drop.dart';

class BookNowSecondScreen extends StatefulWidget {
  final Function? onTap;
  final String? name;
  final String? address;
  final String? price;
  final List? facilitates;
  final int? minGuest;
  final int? maxGuest;
  const BookNowSecondScreen({super.key, this.onTap, this.name, this.address, this.price, this.facilitates, this.minGuest, this.maxGuest});

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
  final TextEditingController commentController = TextEditingController();
  List? selected;
  dynamic _low;
  String? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: InkWell(
          onTap: () {
            if(selectedDate == null){
              Utils.tostMessage('Please select date');
            }else if(_low == null){
              Utils.tostMessage('Please select No Of Guest');
            }else{
              widget.onTap!(
                  {
                    'date':selectedDate,
                    'selectFacilities':selected ?? [],
                    'comment': commentController.text,
                    'noOfGuest': _low.toStringAsFixed(0),
                  }
              );
            }

          },
          child: const MainButton(
            data: 'Payments',
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
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data: widget.name ??'AL khayma Camp',
                        fweight: FontWeight.w800,
                        fSize: 18,
                        fontColor: AppColors.blackTextColor,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/1.4,
                        child: CustomText(
                          data: widget.address??'9 Al Khayma Camp, Dubai, UAE',
                          fweight: FontWeight.w600,
                          fSize: 13,
                          fontColor: AppColors.greyTextColor,
                        ),
                      ),
                    ],
                  ),
                  CustomText(
                    data: '\$${widget.price ?? "195.67"}',
                    fweight: FontWeight.w800,
                    fSize: 20,
                    fontColor: AppColors.mainColor,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DateTimeTabWidget(
                date: ((date){
                  selectedDate = date;
                  setState(() {

                  });
                }),
              ),
              widget.facilitates == null
                 ?  const SizedBox()
                  : FacilitiesDrop(
                initialValue: selected,
                items: widget.facilitates?.map((item) {
                  return MultiSelectItem(
                      '${item.id}', '${item.facility}');
                }).toList() ??
                    [],
                onConfirm: (results) {
                  setState(() {
                    selected = results;
                  });
                },
              ),
              const SizedBox(height: 15),
              MainTextFild(
                controller: commentController,
                labelText: 'Comments...',
                maxLines: 2,
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
                      values: [_low ?? widget.minGuest!.toDouble()+2],
                      max: widget.maxGuest?.toDouble(),
                      min: widget.minGuest?.toDouble(),
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
                          data: '${_low == null ? widget.minGuest!+2 : _low.toInt()}',
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
