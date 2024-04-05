import 'package:airjood/res/components/CustomText.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../model/reels_model.dart';
import '../../../../res/components/color.dart';

class SelectLaqtaReels extends StatefulWidget {
  final List<ReelsData>? item;
  final Function? onTap;

  const SelectLaqtaReels({super.key, this.item, this.onTap});

  @override
  State<SelectLaqtaReels> createState() => _SelectLaqtaReelsState();
}

class _SelectLaqtaReelsState extends State<SelectLaqtaReels> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Color(0xFFF1F1F8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const Spacer(),
                const CustomText(
                  data: 'Select Laqta',
                  fontColor: AppColors.mainColor,
                  fSize: 20,
                  fweight: FontWeight.w700,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(CupertinoIcons.xmark),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: widget.item!.isEmpty
                  ? Center(
                      child: Text(
                        'No Data Found ! \nPlease add new reels !',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  : GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1 / 1.3,
                      ),
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(left: 10, bottom: 20),
                      children: List.generate(
                        widget.item!.length,
                        (index) {
                          return InkWell(
                            onTap: () {
                              if (widget.onTap != null) {
                                widget.onTap!(widget.item?[index]);
                              }
                            },
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            child: Container(
                              width: 110,
                              height: 180,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              margin: const EdgeInsets.only(top: 10, right: 10),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: widget
                                              .item?[index].videoThumbnailUrl ??
                                          'https://airjood.neuronsit.in/storage/reels/gcQ5z3MmXbsLfWqcihMg0bXZYNU3Zurlki1Y8lyK.jpg',
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            'https://airjood.neuronsit.in/storage/profile_images/TOAeh3xMyzAz2SOjz2xYu7GvC2yePHMqoTKd3pWJ.png',
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(Icons.error);
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional.bottomCenter,
                                      child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin:
                                                AlignmentDirectional.topStart,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Colors.black.withOpacity(0.0),
                                              Colors.black.withOpacity(0.1),
                                              Colors.black.withOpacity(0.2),
                                              Colors.black.withOpacity(0.3),
                                              Colors.black.withOpacity(0.4),
                                              Colors.black.withOpacity(0.6),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Image.asset(
                                          'assets/icons/play-button.png',
                                          height: 25,
                                          width: 20,
                                          fit: BoxFit.cover,
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
            ),
          ),
        ],
      ),
    );
  }
}
