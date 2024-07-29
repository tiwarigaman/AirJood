import 'package:airjood/res/components/mainbutton.dart';
import 'package:airjood/res/components/maintextfild.dart';
import 'package:airjood/utils/utils.dart';
import 'package:airjood/view_model/add_review_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../view_model/user_view_model.dart';

class ReviewScreen extends StatefulWidget {
  final String? title;
  final String? location;
  final DateTime? date;
  final int? id;
  const ReviewScreen({super.key, this.title, this.location, this.date, this.id});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    super.initState();
    UserViewModel().getToken().then((value) {
      token = value;
      setState(() {});
    });
  }

  String? token;
  double review = 4.0;
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final addReview = Provider.of<AddReviewViewModel>(context);
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
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
          const Spacer(),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
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
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          CustomText(
                            data: widget.title ?? 'Plan Title Name Here',
                            fontWeight: FontWeight.w700,
                            fSize: 16,
                            color: AppColors.blackTextColor,
                          ),
                          const SizedBox(height: 10),
                          Row(
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
                                  fontWeight: FontWeight.w400,
                                  fSize: 15,
                                  color: AppColors.greyTextColor,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            children: [
                              Icon(
                                Icons.calendar_month_sharp,
                                color: AppColors.textFildHintColor,
                                size: 16,
                              ),
                              SizedBox(width: 10),
                              CustomText(
                                data: '25th Jan 2023 - 30th Jan 2023 (5 Days)',
                                fontWeight: FontWeight.w400,
                                fSize: 14,
                                color: AppColors.greyTextColor,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const CustomText(
                  data: 'How was your experience?',
                  fSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.blackTextColor,
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
                  onRatingUpdate: (double value) {
                    review = value;
                  },
                ),
                const SizedBox(height: 20),
                MainTextFild(
                  controller: textController,
                  hintText: 'Write your experience here..',
                  maxLines: 5,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (textController.text.isEmpty) {
                      Utils.toastMessage('Please Write Your Experience...');
                    } else {
                      Map<String, String> data = {
                        "booking_id": widget.id.toString(),
                        "comment": textController.text.toString(),
                        "rating": '$review',
                      };
                      addReview.addReviewApi(token!, data, context);
                    }
                  },
                  child: MainButton(
                    loading: addReview.addReviewsLoading,
                    data: 'Post Now',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
