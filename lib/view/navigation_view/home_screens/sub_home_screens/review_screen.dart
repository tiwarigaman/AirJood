import 'package:airjood/res/components/mainbutton.dart';
import 'package:airjood/res/components/maintextfild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../planning_view/screen_widgets/plan_container.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
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
          const SizedBox(width: 15),
          const CustomText(
            data: 'Review Now',
            fSize: 22,
            fweight: FontWeight.w700,
            fontColor: AppColors.blackColor,
          ),
          const Spacer(),
        ],
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                      color: AppColors.blueShade,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          CustomText(
                            data: 'Plan Title Name Here',
                            fweight: FontWeight.w700,
                            fSize: 16,
                            fontColor: AppColors.blackTextColor,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: AppColors.textFildHintColor,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              CustomText(
                                data: 'Mumbai, Maharastra',
                                fweight: FontWeight.w400,
                                fSize: 15,
                                fontColor: AppColors.greyTextColor,
                              ),

                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month_sharp,
                                color: AppColors.textFildHintColor,
                                size: 16,
                              ),
                              SizedBox(width: 10),
                              CustomText(
                                data: '25th Jan 2023 - 30th Jan 2023 (5 Days)',
                                fweight: FontWeight.w400,
                                fSize: 14,
                                fontColor: AppColors.greyTextColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
              ),
              const SizedBox(height: 20),
              const CustomText(
                data: 'How was your experience?',
                fSize: 22,
                fweight: FontWeight.w800,
                fontColor: AppColors.blackTextColor,
              ),
              const SizedBox(height: 20),
              RatingBar(
                initialRating: 4,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star_rounded,
                    color: AppColors.amberColor,
                  ),
                  half: const Icon(
                    Icons.star_half_rounded,
                    color: AppColors.amberColor,
                  ),
                  empty: const Icon(
                    Icons.star_rounded,
                    color: AppColors.greyTextColor,
                  ),
                ),
                itemSize: 40.0,
                itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                onRatingUpdate: (double value) {},
              ),
              const SizedBox(height: 20),
              const MainTextFild(
                hintText: 'Write your experience here..',
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              const MainButton(
                data: 'Post Now',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
