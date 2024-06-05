import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../data/response/status.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/custom_shimmer.dart';
import '../../../../view_model/get_planning_list_view_model.dart';
import '../../planning_view/planning_details_screen.dart';

class SelectListContainer extends StatefulWidget {
  final Function? onSelect;
  const SelectListContainer({super.key, this.onSelect});

  @override
  State<SelectListContainer> createState() => _SelectListContainerState();
}

class _SelectListContainerState extends State<SelectListContainer> {
  int? selectedIndex;
  String formatDateString(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return '';
    }
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(parsedDate);
    } catch (e) {
      return 'Invalid date';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GetPlanningListViewModel>(
      builder: (context, value, child) {
        switch (value.planningData.status) {
          case Status.LOADING:
            return const Padding(
              padding: EdgeInsets.all(20),
              child: PlanningShimmer(),
            );
          case Status.ERROR:
            return Container();
          case Status.COMPLETED:
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ListView.builder(
                  itemCount: value.planningData.data?.data?.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = value.planningData.data?.data?[index];
                    String formattedStartDate =
                    formatDateString(data?.startDate?.toString());
                    String formattedEndDate =
                    formatDateString(data?.endDate?.toString());
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlanningDetailsScreen(
                                id: data!.id,
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
                                  imageUrl: '${data?.imageUrl}',
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                child: Row(
                                  children: [
                                    CustomText(
                                      data: data?.title ?? 'Plan Title Name Here',
                                      fweight: FontWeight.w700,
                                      fSize: 16,
                                      fontColor: AppColors.blackTextColor,
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                          widget.onSelect?.call({
                                            'id': data?.id,
                                            'day': data?.planDuration,
                                          });
                                        });
                                      },
                                      child: selectedIndex == index
                                          ? const Icon(CupertinoIcons.checkmark_alt_circle_fill, size: 25)
                                          : const Icon(Icons.circle_outlined, size: 25),
                                    ),
                                  ],
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
                                    CustomText(
                                      data: data?.stateName != null
                                          ? '${data?.countryName} , ${data?.stateName}'
                                          : '${data?.countryName}',
                                      fweight: FontWeight.w400,
                                      fSize: 15,
                                      fontColor: AppColors.greyTextColor,
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
                                      data: formattedStartDate.isNotEmpty || formattedEndDate.isNotEmpty ? '$formattedStartDate - $formattedEndDate (${data?.planDuration} Days)' : '${data?.planDuration} Days',
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
                  },
                ),
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}
