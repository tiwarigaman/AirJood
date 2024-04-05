import 'package:flutter/material.dart';

import '../../../../../res/components/CustomText.dart';
import '../../../../../res/components/color.dart';
import '../../../../../res/components/mainbutton.dart';

class BookNowFourthScreen extends StatefulWidget {
  final Function? onTap;
  const BookNowFourthScreen({super.key, this.onTap});

  @override
  State<BookNowFourthScreen> createState() => _BookNowFourthScreenState();
}

class _BookNowFourthScreenState extends State<BookNowFourthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: InkWell(
          onTap: () {
            widget.onTap!();
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
                child: Image.asset(
                  'assets/images/image1.png',
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
                          child: Image.asset(
                            'assets/images/user.png',
                            height: 45,
                            width: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const CustomText(
                          data: '\$195.67',
                          fweight: FontWeight.w800,
                          fSize: 18,
                          fontColor: AppColors.mainColor,
                        ),
                      ],
                    ),
                    const CustomText(
                      data: 'David Warner',
                      fweight: FontWeight.w700,
                      fSize: 18,
                      fontColor: AppColors.blackTextColor,
                    ),
                    const CustomText(
                      data: '9 Al Khayma Camp, Dubai, UAE',
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    data: 'Booking Charges',
                    fweight: FontWeight.w600,
                    fSize: 14,
                    fontColor: AppColors.greyTextColor,
                  ),
                  CustomText(
                    data: '\$125.32',
                    fweight: FontWeight.w700,
                    fSize: 14,
                    fontColor: AppColors.blackTextColor,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    data: 'Transportation',
                    fweight: FontWeight.w600,
                    fSize: 14,
                    fontColor: AppColors.greyTextColor,
                  ),
                  CustomText(
                    data: '\$40.20',
                    fweight: FontWeight.w700,
                    fSize: 14,
                    fontColor: AppColors.blackTextColor,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    data: 'Desert Safari Trip',
                    fweight: FontWeight.w600,
                    fSize: 14,
                    fontColor: AppColors.greyTextColor,
                  ),
                  CustomText(
                    data: '\$30.15',
                    fweight: FontWeight.w700,
                    fSize: 14,
                    fontColor: AppColors.blackTextColor,
                  ),
                ],
              ),
              const Divider(
                color: AppColors.deviderColor,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    data: 'Total',
                    fweight: FontWeight.w700,
                    fSize: 15,
                    fontColor: AppColors.blackTextColor,
                  ),
                  CustomText(
                    data: '\$195.67',
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
