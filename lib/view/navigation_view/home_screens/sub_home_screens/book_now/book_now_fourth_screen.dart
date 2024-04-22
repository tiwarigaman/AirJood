import 'package:airjood/model/experience_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../res/components/CustomText.dart';
import '../../../../../res/components/color.dart';
import '../../../../../res/components/mainbutton.dart';

class BookNowFourthScreen extends StatefulWidget {
  final Function? onTap;
  final String? reelsUrl;
  final String? videoThumbnailUrl;
  final String? price;
  final String? totalPrice;
  final String? userCharges;
  final String? date;
  final String? address;
  final List<Addon>? addon;
  final String? noOfGuest;
  final String? comment;
  final List? selectedFacilitates;
  final String? reelsUserProfileImage;
  final String? reelsUserName;
  final String? priceType;
  const BookNowFourthScreen(
      {super.key,
      this.onTap,
      this.reelsUrl,
      this.videoThumbnailUrl,
      this.price,
      this.date,
      this.noOfGuest,
      this.comment,
      this.selectedFacilitates,
      this.reelsUserProfileImage,
      this.reelsUserName,
      this.address,
      this.addon,
      this.totalPrice,
      this.userCharges, this.priceType});

  @override
  State<BookNowFourthScreen> createState() => _BookNowFourthScreenState();
}

class _BookNowFourthScreenState extends State<BookNowFourthScreen> {
  double calculateTotalCharges() {
      double bookingCharges = (widget.priceType == 'person' ? (double.parse(widget.userCharges.toString()) * double.parse(widget.noOfGuest ?? '1')) : double.parse(widget.userCharges.toString()));
    double addonCharges = 0;
    String addonType = '';

    if (widget.addon != null && widget.addon!.isNotEmpty) {
      addonCharges = widget.addon!
          .map((addon) => double.parse(addon.price.toString()))
          .reduce((value, element) => value + element);
      for (var addon in widget.addon!) {
        addonType = addon.priceType ?? ''; // Get the priceType of the current addon
        break; // Exit the loop after getting the priceType of the first addon
      }
    }
    int noOfGuests = int.parse(widget.noOfGuest ?? '1');
    double totalCharges = bookingCharges + (addonType == 'person'?addonCharges * noOfGuests : addonCharges);
    return totalCharges;
  }
  @override
  Widget build(BuildContext context) {
    double totalCharges = calculateTotalCharges();
    print('Booking Charges: ${widget.userCharges}');
    print('Addon Charges: ${widget.addon?.map((addon) => addon.price).toList()}');
    print('Total Charges: $totalCharges');
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: InkWell(
          onTap: () {
            widget.onTap!(
                totalCharges.toInt()
            );
          },
          child: const MainButton(
            data: 'Confirm & Pay',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                data: 'Almost Done !',
                fweight: FontWeight.w800,
                fSize: 18,
                fontColor: AppColors.blackTextColor,
              ),
              const CustomText(
                data: 'Please confirm your given details & proceed boking.',
                fweight: FontWeight.w600,
                fSize: 13,
                fontColor: AppColors.greyTextColor,
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: '${widget.videoThumbnailUrl}',
                  height: 110,
                  width: 85,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Container(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: '${widget.reelsUserProfileImage}',
                            height: 45,
                            width: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                        CustomText(
                          data: '\$${totalCharges.toInt()}',
                          fweight: FontWeight.w800,
                          fSize: 18,
                          fontColor: AppColors.mainColor,
                        ),
                      ],
                    ),
                    CustomText(
                      data: widget.reelsUserName ?? 'David Warner',
                      fweight: FontWeight.w700,
                      fSize: 18,
                      fontColor: AppColors.blackTextColor,
                    ),
                    CustomText(
                      data: widget.address ?? '9 Al Khayma Camp, Dubai, UAE',
                      fweight: FontWeight.w600,
                      fSize: 13,
                      fontColor: AppColors.greyTextColor,
                    ),
                    const SizedBox(height: 3),
                    CustomText(
                      data: widget.date ?? 'Mon 15, Mar 23',
                      fweight: FontWeight.w600,
                      fSize: 13,
                      fontColor: AppColors.blackTextColor,
                    ),
                    const SizedBox(height: 2),
                    const Row(
                      children: [
                        CustomText(
                          data: 'Confirmation : ',
                          fweight: FontWeight.w600,
                          fSize: 14,
                          fontColor: AppColors.blackTextColor,
                        ),
                        CustomText(
                          data: 'Pending',
                          fweight: FontWeight.w700,
                          fSize: 14,
                          fontColor: AppColors.amberTextColor,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const CustomText(
                data: 'Charges to Pay',
                fweight: FontWeight.w700,
                fSize: 18,
                fontColor: AppColors.blackTextColor,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    data: 'Booking Charges',
                    fweight: FontWeight.w600,
                    fSize: 14,
                    fontColor: AppColors.greyTextColor,
                  ),
                  CustomText(
                    data: '\$${widget.priceType == 'person' ? (int.parse(widget.userCharges.toString()) * int.parse(widget.noOfGuest ?? '1')) : int.parse(widget.userCharges.toString())}',
                    // data: '\$${widget.userCharges ?? "125.32"}',
                    fweight: FontWeight.w700,
                    fSize: 14,
                    fontColor: AppColors.blackTextColor,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget.addon?.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        data: widget.addon?[index].name ?? 'Transportation',
                        fweight: FontWeight.w600,
                        fSize: 14,
                        fontColor: AppColors.greyTextColor,
                      ),
                      CustomText(
                        data: '\$${widget.addon?[index].priceType == 'person' ? (int.parse(widget.addon![index].price.toString()) * int.parse(widget.noOfGuest ?? '1')) : int.parse(widget.addon![index].price.toString())}',
                        fweight: FontWeight.w700,
                        fSize: 14,
                        fontColor: AppColors.blackTextColor,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 5),
              const Divider(color: AppColors.deviderColor),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    data: 'Total',
                    fweight: FontWeight.w700,
                    fSize: 15,
                    fontColor: AppColors.blackTextColor,
                  ),
                  CustomText(
                    data: '\$${totalCharges.toInt()}',
                    fweight: FontWeight.w700,
                    fSize: 14,
                    fontColor: AppColors.mainColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
