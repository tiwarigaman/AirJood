import 'package:flutter/material.dart';

import '../../../../model/booking_list_model.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';

class DashBoardWidget extends StatefulWidget {
  final List<BookingData>? bookingList;
  const DashBoardWidget({super.key, this.bookingList});

  @override
  State<DashBoardWidget> createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          data: 'Bookings',
          fweight: FontWeight.w800,
          fSize: 18,
          fontColor: AppColors.blackTextColor,
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          itemCount: widget.bookingList?.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var data = widget.bookingList?[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.containerBorderColor),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            '${data?.experience?.user?.profileImageUrl}',
                            height: 45,
                            width: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                        CustomText(
                          data: '\$${data?.bookingCharges}',
                          fweight: FontWeight.w800,
                          fSize: 18,
                          fontColor: AppColors.mainColor,
                        ),
                      ],
                    ),
                    CustomText(
                      data: data?.experience?.user?.name ?? "David Warner",
                      fweight: FontWeight.w700,
                      fSize: 18,
                      fontColor: AppColors.blackTextColor,
                    ),
                    CustomText(
                      data: data?.experience?.location ??
                          '9 Al Khayma Camp, Dubai, UAE',
                      fweight: FontWeight.w600,
                      fSize: 13,
                      fontColor: AppColors.greyTextColor,
                    ),
                    const SizedBox(height: 3),
                    const CustomText(
                      data: 'Mon 15, Mar 23 - 17:30 PM',
                      fweight: FontWeight.w600,
                      fSize: 13,
                      fontColor: AppColors.blackTextColor,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
