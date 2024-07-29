import 'package:airjood/view/navigation_view/home_screens/screen_widget/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../model/experience_model.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../component/read_more_text.dart';

class AddonesListWidget extends StatefulWidget {
  final List<Addon>? data;
  const AddonesListWidget({super.key, this.data});

  @override
  State<AddonesListWidget> createState() => _AddonesListWidgetState();
}

class _AddonesListWidgetState extends State<AddonesListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.data?.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        var newData = widget.data?[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              data: 'Addons ${index + 1} :',
              fontWeight: FontWeight.w600,
              fSize: 16,
              color: AppColors.greyTextColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerWidget(
                          image: newData?.reel?.user?[0].profileImageUrl,
                          createdAt: newData?.reel?.user?[0].createdAt,
                          number: newData?.reel?.user?[0].contactNo,
                          guide: newData?.reel?.user?[0].isUpgrade,
                          email: newData?.reel?.user?[0].email,
                          userId: newData?.reel?.user?[0].id,
                          dateTime: newData?.reel?.user?[0].createdAt,
                          about: newData?.reel?.user?[0].about,
                          name: newData?.reel?.user?[0].name,
                          language: newData?.reel?.user?[0].languages,
                          screen: 'Laqta',
                          commentCount: newData?.reel?.commentCount,
                          videoUrl: '${newData?.reel?.videoUrl}',
                          index: index,
                          likeCount: newData?.reel?.likeCount,
                          videoImage: newData?.reel?.videoThumbnailUrl,
                          isLike: newData?.reel?.liked,
                          reelsId: newData?.reel?.id,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: '${newData?.reel?.videoThumbnailUrl}',
                      height: 110,
                      width: 85,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CustomText(
                            data: 'Addons Name : ',
                            fontWeight: FontWeight.w500,
                            fSize: 14,
                            color: AppColors.greyTextColor,
                          ),
                          Expanded(
                            child: Text(
                              '${newData?.name}',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const CustomText(
                            data: 'Price : ',
                            fontWeight: FontWeight.w500,
                            fSize: 14,
                            color: AppColors.greyTextColor,
                          ),
                          CustomText(
                            data: '\$${newData!.price}',
                            fontWeight: FontWeight.w600,
                            fSize: 14,
                            color: AppColors.blackTextColor,
                          ),
                        ],
                      ),
                      CustomReadMoreText(
                        mColor: AppColors.mainColor,
                        rColor: AppColors.mainColor,
                        trimLines: 3,
                        content: '${newData?.description}',
                        color: AppColors.secondTextColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}
