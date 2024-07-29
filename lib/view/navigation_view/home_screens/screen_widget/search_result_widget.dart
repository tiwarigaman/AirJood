import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/res/components/custom_shimmer.dart';
import 'package:airjood/res/components/maintextfild.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../data/response/status.dart';
import '../../../../res/components/color.dart';
import '../../../../view_model/search_view_model.dart';

class SearchResultWidget extends StatefulWidget {
  const SearchResultWidget({super.key});

  @override
  State<SearchResultWidget> createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Color(0xFFF1F1F8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  data: 'Search Results',
                  fSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackTextColor,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(CupertinoIcons.xmark))
              ],
            ),
          ),
          Consumer<SearchViewModel>(
            builder: (context, value, child) {
              switch (value.searchData.status) {
                case Status.LOADING:
                  return const SmallShimmer();
                case Status.ERROR:
                  return const SmallShimmer();
                case Status.COMPLETED:
                  return value.searchData.data?.data == null ||
                          value.searchData.data!.data!.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height / 1.5,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              'No Data Found !',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunitoSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Container(
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: AppColors.whiteColor,
                            ),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    MainTextFild(
                                      maxLines: 1,
                                      readOnly: true,
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      hintText: 'Search People...',
                                      prefixIcon: const Icon(
                                        Icons.search_rounded,
                                        color: AppColors.textFildHintColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    GridView(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 1 / 1.3,
                                      ),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 20),
                                      children: List.generate(
                                        value.searchData.data!.data!.length,
                                        (index) {
                                          var newData = value
                                              .searchData.data!.data?[index];
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      VideoPlayerWidget(
                                                        experienceId: newData?.id,
                                                    description:
                                                        newData?.description,
                                                    name: newData?.user?.name,
                                                    image: newData
                                                        ?.user?.profileImageUrl,
                                                    createdAt: newData
                                                        ?.user?.createdAt,
                                                    number: newData
                                                        ?.user?.contactNo,
                                                    guide: newData
                                                        ?.user?.isUpgrade,
                                                    email: newData?.user?.email,
                                                    userId: newData?.user?.id,
                                                    dateTime: newData
                                                        ?.user?.createdAt,
                                                    about: newData?.user?.about,
                                                    commentCount: newData
                                                        ?.reel?.commentCount,
                                                    language: newData
                                                        ?.user?.languages,
                                                    videoUrl:
                                                        '${newData?.reel?.videoUrl}',
                                                    reelsId: newData?.reel?.id,
                                                    isLike:
                                                        newData?.reel?.liked,
                                                    videoImage: newData?.reel
                                                        ?.videoThumbnailUrl,
                                                    likeCount: newData
                                                        ?.reel?.likeCount,
                                                    index: index,
                                                    screen: 'UserDetails',
                                                  ),
                                                ),
                                              );
                                            },
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            overlayColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            child: Container(
                                              width: 110,
                                              height: 180,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                              ),
                                              margin: const EdgeInsets.only(
                                                  top: 10, right: 10),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(8)),
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    CachedNetworkImage(
                                                      imageUrl:
                                                          '${newData?.reel?.videoThumbnailUrl}',
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Container(
                                                      height: 30,
                                                      width: 180,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Colors.black
                                                                .withOpacity(
                                                                    0.0),
                                                            Colors.black
                                                                .withOpacity(
                                                                    0.2),
                                                            Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                            Colors.black
                                                                .withOpacity(
                                                                    0.8),
                                                          ],
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Image.asset(
                                                            'assets/icons/play-button.png',
                                                            height: 25,
                                                            width: 25,
                                                          ),
                                                        ),
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                default:
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
