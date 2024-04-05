import 'dart:async';

import 'package:airjood/res/components/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../res/components/color.dart';

class TabBarWidget extends StatefulWidget {
  final late;
  final lang;

  const TabBarWidget({super.key, this.late, this.lang});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
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
            const Review(),
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
  const Review({super.key});

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
            const CustomText(
              data: '250 Reviews',
              fweight: FontWeight.w700,
              fSize: 17,
              fontColor: AppColors.blackTextColor,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: CustomText(
                    data: 'Add Review',
                    fontColor: AppColors.whiteTextColor,
                    fSize: 16,
                    fweight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  minVerticalPadding: 0,
                  contentPadding: const EdgeInsets.only(
                      left: 0, right: 0, top: 10, bottom: 0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/user.png',
                      fit: BoxFit.cover,
                      height: 45,
                    ),
                  ),
                  title: const CustomText(
                    data: 'Selina Gomez',
                    fSize: 16,
                    fweight: FontWeight.w700,
                    fontColor: AppColors.blackTextColor,
                  ),
                  subtitle: const CustomText(
                    data: '25th July 2023   @11:45AM',
                    fSize: 13,
                    fweight: FontWeight.w500,
                  ),
                  trailing: RatingBar(
                    initialRating: 3,
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
                    itemSize: 16.0,
                    itemPadding: EdgeInsets.zero,
                    onRatingUpdate: (double value) {},
                  ),
                ),
                const CustomText(
                  data:
                      'Lorem ipsum dolor sit amet consectetur. Enim justo tellus odio vitae ullamcorper adipiscing est. Phellus proin non orci consectetur Id sit letus morbi null.',
                  fSize: 13,
                  fweight: FontWeight.w500,
                  fontColor: AppColors.secondTextColor,
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'View All Review',
          style: GoogleFonts.halant(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: AppColors.blueShadeColor,
            decorationColor: AppColors.blueShadeColor,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}

class ExperienceLocation extends StatefulWidget {
  final late;
  final lang;

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
      target: LatLng(double.parse(widget.late ?? '12.121212'),
          double.parse(widget.lang ?? '11.121212')),
      zoom: 14.4746,
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
