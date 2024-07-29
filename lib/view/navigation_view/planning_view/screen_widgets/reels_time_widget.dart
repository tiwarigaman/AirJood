import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/res/components/color.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/planning_reels_sheet_widget.dart';
import 'package:flutter/material.dart';

import '../../../../model/planning_details_model.dart';

class ReelsTimeWidget extends StatefulWidget {
  final List<PlanReel>? data;
  final String? duration;
  const ReelsTimeWidget({super.key, this.data, this.duration});

  @override
  State<ReelsTimeWidget> createState() => _ReelsTimeWidgetState();
}

class _ReelsTimeWidgetState extends State<ReelsTimeWidget> {
  final List<String> times = List.generate(24, (index) {
    if (index == 0) {
      return '12 AM';
    } else if (index < 12) {
      return '$index AM';
    } else if (index == 12) {
      return '12 PM';
    } else {
      return '${index - 12} PM';
    }
  });

  int currentDay = 1;
  int totalDays = 1;

  @override
  void initState() {
    super.initState();
    if (widget.duration != null) {
      totalDays = int.tryParse(widget.duration!) ?? 1;
    }
  }

  Map<int, List<Map<String, dynamic>>> dayCards = {};

  @override
  Widget build(BuildContext context) {
    _initializeDayCards();
    return Container(
      height: 560,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFF1F1F8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_left_sharp,
                  size: 40,
                  color: AppColors.mainColor,
                ),
                onPressed: _decrementDay,
              ),
              CustomText(
                data: 'Day $currentDay',
                fontWeight: FontWeight.w800,
                fSize: 18,
                color: AppColors.mainColor,
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_right_sharp,
                  size: 40,
                  color: AppColors.mainColor,
                ),
                onPressed: _incrementDay,
              ),
            ],
          ),
          SizedBox(
            height: 486,
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: times.length,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    String timeSlot = times[index];
                    return SizedBox(
                      height: 20,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              timeSlot,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF5A5A75),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Container(
                              height: 0.5,
                              color: AppColors.tileTextColor.withOpacity(0.2),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ..._buildDayCards(dayCards[currentDay] ?? []),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _initializeDayCards() {
    if (widget.data != null) {
      dayCards.clear();
      for (var planReel in widget.data!) {
        int day = int.tryParse('${planReel.dayCount}') ?? 1;
        if (!dayCards.containsKey(day)) {
          dayCards[day] = [];
        }
        dayCards[day]!.add({
          'start': _formatTime('${planReel.experience?.startDate}'),
          'end': _formatTime('${planReel.experience?.endDate}'),
          'image': planReel.experience?.reel?.videoThumbnailUrl ?? '',
          'name':planReel.experience?.name,
          'about':planReel.experience?.description,
          'location':planReel.experience?.location,
          'experianceId':planReel.experience?.id,
          'planId':planReel.planId,
        });
      }
    }
  }

  String _formatTime(String? dateTime) {
    if (dateTime == null) return '12 AM';
    DateTime dt = DateTime.parse(dateTime);
    int hour = dt.hour;
    String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    if (hour == 0) hour = 12;
    return '$hour $period';
  }

  void _incrementDay() {
    setState(() {
      if (currentDay < totalDays) {
        currentDay++;
      }
    });
  }

  void _decrementDay() {
    setState(() {
      if (currentDay > 1) {
        currentDay--;
      }
    });
  }

  int _getTimeIndex(String time) {
    int index = 0;
    if (time.endsWith('AM')) {
      index = int.parse(time.split(' ')[0]) % 12;
    } else if (time.endsWith('PM')) {
      index = (int.parse(time.split(' ')[0]) % 12) + 12;
    }
    return index;
  }

  List<Widget> _buildDayCards(List<Map<String, dynamic>> cards) {
    List<Widget> positionedCards = [];
    for (int i = 0; i < cards.length; i++) {
      int startIndex = _getTimeIndex(cards[i]['start']!);
      int endIndex = _getTimeIndex(cards[i]['end']!);
      double topOffset = startIndex * 20.0;
      double cardHeight = (endIndex - startIndex) * 20.0;
      double leftOffset = 50.0 + (i * 100);
      positionedCards.add(
        Positioned(
          top: topOffset,
          left: leftOffset,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (_) =>  PlanningReelsSheetWidget(
                  imageUrl: '${cards[i]['image']}',
                  location: '${cards[i]['location']}',
                  title: '${cards[i]['name']}',
                  planId: cards[i]['planId'],
                  experianceId: cards[i]['experianceId'],
                  about: '${cards[i]['about']}',
                ),
              );
            },
            child: Container(
              height: cardHeight,
              width: 90,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: AppColors.blackColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(5),
              ),
              margin: const EdgeInsets.only(top: 10),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    '${cards[i]['image']}',
                    width: 90,
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return positionedCards;
  }

}
