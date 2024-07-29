import 'dart:async';

import 'package:airjood/model/experience_rating_model.dart';
import 'package:airjood/res/components/CustomText.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../res/components/color.dart';

class TabBarWidget extends StatefulWidget {
  final double? late;
  final double? lang;
  final List<Datum>? data;
  const TabBarWidget({super.key, this.late, this.lang, this.data});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int? indexs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            onTap: (p0) {
              indexs == p0;
              setState(() {});
            },
            controller: _tabController,
            tabs: const [
              Tab(text: 'Reviews'),
              Tab(text: 'Experience Location'),
            ]),
        Center(
          child: [
            Review(
              data: widget.data,
            ),
            ExperienceLocation(
              late: widget.late,
              lang: widget.lang,
            ),
          ][_tabController.index],
        ),
      ],
    );
  }
}

class Review extends StatefulWidget {
  final List<Datum>? data;
  const Review({super.key, this.data});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              data: '${widget.data?.length} Reviews',
              fontWeight: FontWeight.w700,
              fSize: 17,
              color: AppColors.blackTextColor,
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.data?.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            var reviewData = widget.data?[index];
            DateTime utcDateTime = DateTime.parse('${reviewData?.createdAt}').toUtc();
            DateTime localDateTime = utcDateTime.toLocal();
            String formattedDate = DateFormat('d MMMM yyyy   @hh:mma').format(localDateTime);
            formattedDate = formattedDate.replaceFirst('${localDateTime.day}','${localDateTime.day}');
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  minVerticalPadding: 0,
                  contentPadding: const EdgeInsets.only(
                      left: 0, right: 0, top: 10, bottom: 0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: '${reviewData?.user?.profileImageUrl}',
                      fit: BoxFit.cover,
                      height: 45,
                      width: 45,
                    ),
                  ),
                  title: CustomText(
                    data: reviewData?.user?.name ?? 'Selina Gomez',
                    fSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackTextColor,
                  ),
                  subtitle:  CustomText(
                    data: formattedDate,
                    fSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  trailing: RatingBar(
                    initialRating: reviewData!.rating!.toDouble(),
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
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
                    itemSize: 16.0,
                    itemPadding: EdgeInsets.zero,
                    onRatingUpdate: (double value) {},
                  ),
                ),
                CustomText(
                  data: '${reviewData.comment}',
                  fSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondTextColor,
                   textAlign: TextAlign.justify,
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height:
          20,
        ),
        // Text(
        //   'View All Review',
        //   style: GoogleFonts.halant(
        //     fontSize: 17,
        //     fontWeight: FontWeight.w800,
        //     color: AppColors.blueShadeColor,
        //     decorationColor: AppColors.blueShadeColor,
        //     decoration: TextDecoration.underline,
        //   ),
        // ),
      ],
    );
  }
}

class ExperienceLocation extends StatefulWidget {
  final double? late;
  final double? lang;

  const ExperienceLocation({super.key, this.late, this.lang});

  @override
  State<ExperienceLocation> createState() => _ExperienceLocationState();
}

class _ExperienceLocationState extends State<ExperienceLocation> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late CameraPosition _kGooglePlex;

  @override
  void initState() {
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.late ?? 12.121212, widget.lang ?? 11.121212),
      zoom: 10.4746,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 180,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black12,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ),
      ],
    );
  }
}
