import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/res/components/color.dart';
import 'package:airjood/view/navigation_view/planning_view/planning_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListContainer extends StatefulWidget {
  final int? id;
  final String? imageUrl;
  final String? planningName;
  final String? startDate;
  final String? endDate;
  final String? duration;
  final String? location;

  const ListContainer(
      {super.key,
      this.planningName,
      this.startDate,
      this.endDate,
      this.duration,
      this.location,
      this.imageUrl,
      this.id});

  @override
  State<ListContainer> createState() => _ListContainerState();
}

class _ListContainerState extends State<ListContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlanningDetailsScreen(
                id: widget.id,
              ),
            ),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.containerBorderColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: CachedNetworkImage(
                  imageUrl: '${widget.imageUrl}',
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: CustomText(
                  data: widget.planningName ?? 'Plan Title Name Here',
                  fweight: FontWeight.w700,
                  fSize: 16,
                  fontColor: AppColors.blackTextColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.textFildHintColor,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomText(
                        data: widget.location ?? 'Mumbai, Maharastra',
                        fweight: FontWeight.w400,
                        fSize: 15,
                        fontColor: AppColors.greyTextColor,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_sharp,
                      color: AppColors.textFildHintColor,
                      size: 16,
                    ),
                    const SizedBox(width: 10),
                    CustomText(
                      data:
                      widget.startDate!.isNotEmpty || widget.endDate!.isNotEmpty ? '${widget.startDate} - ${widget.endDate} (${widget.duration} Days)' : '${widget.duration} Days',
                      fweight: FontWeight.w400,
                      fSize: 14,
                      fontColor: AppColors.greyTextColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
