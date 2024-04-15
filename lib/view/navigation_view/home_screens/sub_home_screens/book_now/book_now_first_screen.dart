import 'package:airjood/res/components/mainbutton.dart';
import 'package:airjood/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../data/response/status.dart';
import '../../../../../model/experience_model.dart';
import '../../../../../res/components/CustomText.dart';
import '../../../../../res/components/color.dart';
import '../../../../../res/components/custom_shimmer.dart';
import '../../../../../view_model/upload_experiance_view_model.dart';
import '../../../../../view_model/user_view_model.dart';
import '../../screen_widget/content_details_widget.dart';

class BookNowFirstScreen extends StatefulWidget {
  final Function? onTap;
  final int? experienceId;
  const BookNowFirstScreen({super.key, this.onTap, this.experienceId});

  @override
  State<BookNowFirstScreen> createState() => _BookNowFirstScreenState();
}

class _BookNowFirstScreenState extends State<BookNowFirstScreen> {
  @override
  void initState() {
    super.initState();
    fetchExperianceData();
  }

  late List<bool> isSelected;
  late List<Addon> addonsData;
  List<Addon> selectedAddons = [];
  final List<ExperienceModel> data = [];

  Future<void> fetchExperianceData() async {
    UserViewModel().getToken().then((value) async {
      final experianceProvider =
          Provider.of<UploadExperianceViewModel>(context, listen: false);
      await experianceProvider.getUploadExperianceListApi(
          value!, widget.experienceId!);
      setState(() {
        isSelected = List.generate(
          experianceProvider.getUploadExperianceData.data?.addons?.length ?? 0 ,
              (index) => false,
        );
      });
      addonsData = experianceProvider.getUploadExperianceData.data?.addons ?? [];
    });
  }
  int calculateSelectedAddonsPrice() {
    int totalPrice = 0;
    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i]) {
        totalPrice += addonsData[i].price!;
      }
    }
    return totalPrice;
  }
  @override
  Widget build(BuildContext context) {
    final experianceProvider = Provider.of<UploadExperianceViewModel>(context);
    var experiance = experianceProvider.getUploadExperianceData.data;
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: InkWell(
          onTap: () {
            // if(selectedAddons.isEmpty) {
            //   Utils.tostMessage('Please select any 1 addons');
            // } else{}
            widget.onTap!(
              {
                "experience_id": experiance?.id,
                'name':experiance?.name,
                'reelsUserProfileImage':experiance?.reel?.user?[0].profileImageUrl,
                'addon':selectedAddons,
                'reelsUserName' :experiance?.reel?.user?[0].name,
                'reels':experiance?.reel?.id,
                'totalPrice':(calculateSelectedAddonsPrice() + (experiance?.price ?? 0)).toStringAsFixed(0),
                'userCharges':experiance?.price.toString(),
                'reelsUrl':experiance?.reel?.videoUrl,
                'videoThumbnailUrl':experiance?.reel?.videoThumbnailUrl,
                'address':experiance?.location,
                'price': calculateSelectedAddonsPrice().toStringAsFixed(0),
                'facilitates': experiance?.facility,
                'minGuest':experiance?.minPerson,
                'maxGuest':experiance?.maxPerson,
              }
            );
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
          child: Consumer<UploadExperianceViewModel>(
            builder: (context, value, child) {
              switch (value.getUploadExperianceData.status) {
                case Status.LOADING:
                  return const BookNowShimmer();
                case Status.ERROR:
                  return Container();
                case Status.COMPLETED:
                  var data = value.getUploadExperianceData.data;
                  // isSelected = List.generate(
                  //   data?.addons?.length ?? 0,
                  //   (index) => false,
                  // );
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            data: '\$${data?.price}',
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
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            onRatingUpdate: (double value) {},
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ContentDetailsWidget(
                        name: data?.name ?? "AL khayma Camp",
                        discription: data?.description ??
                            "Lorem ipsum dolor sit amet consectetur. Enim justo tellus odio vitae ullamcorper adipiscing est. Phasellus proin non orci consectetur Id sit letus morbi null.",
                        location: data?.location ?? '9 Al Khayma Camp, Dubai, UAE',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl:'${data?.reel?.videoThumbnailUrl}',
                          height: 110,
                          width: 85,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CustomText(
                            data: 'Add ons (${data?.addons?.length ?? 0})',
                            fontColor: AppColors.blackTextColor,
                            fSize: 18,
                            fweight: FontWeight.w600,
                          ),
                          const Spacer(),
                          CustomText(
                            data: '\$${calculateSelectedAddonsPrice().toStringAsFixed(0)}',
                            fontColor: AppColors.mainColor,
                            fSize: 18,
                            fweight: FontWeight.w700,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      buildContainer(data?.addons),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                default:
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget buildContainer(List<Addon>? data) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data?.length,
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
                  selectedAddons.add(addonsData[index]);
                  isSelected[index] = !isSelected[index];
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          data: '${data?[index].name}',
                          fweight: FontWeight.w700,
                          fSize: 15,
                          fontColor: AppColors.blackTextColor,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Text(
                            '${data?[index].description}',
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColors.greyTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomText(
                      data: '${data?[index].price}',
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
