import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../model/booking_list_model.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../sub_home_screens/experience_screens/upload_experience_details.dart';

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
        if (widget.bookingList!.isNotEmpty)
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
            DateTime dateTime = DateTime.parse(
                data?.createdAt.toString() ?? 'Mon 15, Mar 23 - 17:30 PM');
            DateFormat dateFormat = DateFormat("EEE d,MMM yyyy - hh:mm a");
            String formattedDateTime = dateFormat.format(dateTime);
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    constraints: BoxConstraints.expand(
                        height: MediaQuery.of(context).size.height * 0.90,
                        width: MediaQuery.of(context).size.width),
                    isScrollControlled: true,
                    builder: (_) => UploadExperienceDetails(
                      id: data?.experience?.id,
                      screen: '',
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.containerBorderColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${data?.experience?.reel?.videoThumbnailUrl}',
                                height: 115,
                                // width: 90,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) {
                                  return Container(
                                    color: Colors.black.withOpacity(0.2),
                                    child: const Icon(Icons.error),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  data:
                                      data?.displayUser?.name ?? "Deleted user",
                                  fweight: FontWeight.w700,
                                  fSize: 18,
                                  fontColor: AppColors.blackTextColor,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                CustomText(
                                  data: data?.experience?.name ?? "",
                                  fweight: FontWeight.w700,
                                  fSize: 18,
                                  fontColor:
                                      AppColors.blackTextColor.withOpacity(0.7),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                CustomText(
                                  data: data?.experience?.location ?? '',
                                  fweight: FontWeight.w600,
                                  fSize: 13,
                                  fontColor: AppColors.greyTextColor,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 3),
                                CustomText(
                                  data: formattedDateTime,
                                  fweight: FontWeight.w600,
                                  fSize: 13,
                                  fontColor: AppColors.blackTextColor,
                                ),
                                CustomText(
                                  data: '\$${data?.totalAmount}',
                                  fweight: FontWeight.w800,
                                  fSize: 18,
                                  fontColor: AppColors.mainColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      CustomText(
                        data:
                            'Number Of Person : ${data?.noOfGuests}',
                        fweight: FontWeight.w700,
                        fSize: 13,
                        fontColor: AppColors.blackTextColor,
                      ),
                      if (data?.facility != null && data!.facility!.isNotEmpty)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              data: 'Facilities : ',
                              fweight: FontWeight.w700,
                              fSize: 14,
                              fontColor: AppColors.blackTextColor,
                            ),
                            Expanded(
                              child: Wrap(
                                children: [
                                  ...?data.facility?.map(
                                    (e) => CustomText(
                                      data: '${e.facility} , ',
                                      fweight: FontWeight.w600,
                                      fSize: 13,
                                      fontColor: AppColors.blackTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      if (data?.comment != null)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              data: 'Comment : ',
                              fweight: FontWeight.w700,
                              fSize: 14,
                              fontColor: AppColors.blackTextColor,
                            ),
                            Expanded(
                              child: CustomText(
                                data: '${data?.comment}',
                                fweight: FontWeight.w500,
                                fSize: 13,
                                fontColor: AppColors.blackTextColor,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
