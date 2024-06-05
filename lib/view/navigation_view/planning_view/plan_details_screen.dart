import 'package:airjood/view/navigation_view/planning_view/screen_widgets/plan_container.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/reels_time_widget.dart';
import 'package:flutter/material.dart';
import '../../../model/planning_details_model.dart';
import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';

class PlanDetailsScreen extends StatefulWidget {
  final int planId;
  final String? imageUrl;
  final String screen;
  final String? title;
  final String? location;
  final String? date;
  final String? startDate;
  final String? endDate;
  final String? duration;
  final String? country;
  final String? state;
  final List<PlanReel>? data;
  final List<Invitation>? invitation;
  const PlanDetailsScreen(
      {super.key,
      required this.planId,
      this.imageUrl,
      required this.screen,
      this.title,
      this.location,
      this.date,
      this.startDate,
      this.endDate,
      this.duration,
      this.country,
      this.state,
      this.data,
      this.invitation});

  @override
  State<PlanDetailsScreen> createState() => _PlanDetailsScreenState();
}

class _PlanDetailsScreenState extends State<PlanDetailsScreen> {

  @override
  Widget build(BuildContext context) {
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
            data: 'Plan Details',
            fSize: 22,
            fweight: FontWeight.w700,
            fontColor: AppColors.blackColor,
          ),
          const Spacer(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: PlanContainer(
                  screen: 'planScreen',
                  planId: widget.planId,
                  imageUrl: widget.imageUrl,
                  duration: widget.duration,
                  country: widget.country,
                  state: widget.state,
                  endDate: widget.endDate,
                  startDate: widget.startDate,
                  title: widget.title,
                  date: widget.date,
                  location: widget.location,
                  invitation: widget.invitation,
                ),
              ),
              const SizedBox(height: 20),
              ReelsTimeWidget(
                data: widget.data,
                duration: widget.duration ?? '',
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
