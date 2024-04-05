import 'package:airjood/res/components/mainbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../res/components/CustomText.dart';
import '../../../../../res/components/color.dart';
import '../../screen_widget/content_details_widget.dart';

class BookNowFirstScreen extends StatefulWidget {
  final Function? onTap;
  const BookNowFirstScreen({super.key, this.onTap});

  @override
  State<BookNowFirstScreen> createState() => _BookNowFirstScreenState();
}

class _BookNowFirstScreenState extends State<BookNowFirstScreen> {
  List<bool> isSelected = [true, false, true, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: InkWell(
          onTap: () {
            widget.onTap!();
          },
          child: const MainButton(
            data: 'Next - Dates',
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
                children: [
                  const CustomText(
                    data: '\$125.32',
                    fontColor: AppColors.mainColor,
                    fSize: 25,
                    fweight: FontWeight.w800,
                  ),
                  const Spacer(),
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
                        color: AppColors.secondTextColor,
                      ),
                    ),
                    itemSize: 25.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    onRatingUpdate: (double value) {},
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const ContentDetailsWidget(
                name: 'AL khayma Camp',
                discription:
                    'Lorem ipsum dolor sit amet consectetur. Enim justo tellus odio vitae ullamcorper adipiscing est. Phasellus proin non orci consectetur Id sit letus morbi null.',
                location: '9 Al Khayma Camp, Dubai, UAE',
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/image1.png',
                  height: 110,
                  width: 85,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  CustomText(
                    data: 'Add ons (2)',
                    fontColor: AppColors.blackTextColor,
                    fSize: 18,
                    fweight: FontWeight.w600,
                  ),
                  Spacer(),
                  CustomText(
                    data: '\$70.35',
                    fontColor: AppColors.mainColor,
                    fSize: 18,
                    fweight: FontWeight.w700,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              buildContainer(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainer() {
    List data = [
      {
        "title": "Transportation",
        "subTitle": "Pickup and drop off from your location.",
        "price": "\$40.20"
      },
      {
        "title": "Dinner",
        "subTitle": "Veg & Non veg both meal available.",
        "price": "\$10.15"
      },
      {
        "title": "Desert Safari Trip",
        "subTitle": "Lorem ipsum dolor sit amet consectetur.",
        "price": "\$30.15"
      },
      {
        "title": "Buggy Trip",
        "subTitle": "Lorem ipsum dolor sit amet consectetur.",
        "price": "\$12.20"
      }
    ];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 7, bottom: 7),
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: isSelected[index]
                  ? AppColors.blueBGShadeColor
                  : AppColors.textFildBGColor,
              border: Border.all(
                color: isSelected[index]
                    ? AppColors.blueBorderShadeColor
                    : AppColors.textFildBorderColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  isSelected[index] = !isSelected[index];
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          data: '${data[index]['title']}',
                          fweight: FontWeight.w700,
                          fSize: 15,
                          fontColor: AppColors.blackTextColor,
                        ),
                        CustomText(
                          data: '${data[index]['subTitle']}',
                          fweight: FontWeight.w500,
                          fSize: 12,
                          fontColor: AppColors.greyTextColor,
                        ),
                      ],
                    ),
                    CustomText(
                      data: '${data[index]['price']}',
                      fweight: FontWeight.w700,
                      fSize: 15,
                      fontColor: AppColors.blackTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
