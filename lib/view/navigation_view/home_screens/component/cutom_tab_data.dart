import 'package:airjood/view/navigation_view/home_screens/screen_widget/fridge_door_widget.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/show_upload_reels.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../model/booking_list_model.dart';
import '../../../../model/get_experiance_model.dart';
import '../../../../model/reels_model.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../view_model/delete_experiance_view_model.dart';
import '../../../../view_model/user_view_model.dart';
import '../../ExitBar.dart';
import '../../planning_view/Add_planning_screen.dart';
import '../screen_widget/dashboard_widget.dart';
import '../screen_widget/plan_widgets.dart';

class CustomTabData extends StatefulWidget {
  final List<ReelsData>? items;
  final List<Datum>? list;
  final List<BookingData>? bookingList;
  final String? screen;
  const CustomTabData({super.key, this.items, this.list, this.screen, this.bookingList});

  @override
  State<CustomTabData> createState() => _CustomTabDataState();
}

class _CustomTabDataState extends State<CustomTabData>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    //initializePlayer();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonsTabBar(
          onTap: (p0) {
            index = p0;
            setState(() {});
          },
          controller: _tabController,
          borderWidth: 0,
          backgroundColor: AppColors.mainColor,
          unselectedBackgroundColor: AppColors.tabBGColor,
          splashColor: AppColors.transperent,
          labelSpacing: 7,
          contentPadding: const EdgeInsets.symmetric(horizontal: 7),
          labelStyle: GoogleFonts.nunitoSans(
            color: AppColors.whiteTextColor,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: GoogleFonts.nunitoSans(
            color: AppColors.mainColor,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          tabs: [
            Tab(
              text: 'Laqta',
              icon: SvgPicture.asset(
                'assets/svg/reels.svg',
                color:
                    index == 0 ? AppColors.whiteTextColor : AppColors.mainColor,
              ),
            ),
            Tab(
              text: 'Experiences',
              icon: SvgPicture.asset(
                'assets/svg/users.svg',
                color:
                    index == 1 ? AppColors.whiteTextColor : AppColors.mainColor,
              ),
            ),
            Tab(
              text: 'Plans',
              icon: SvgPicture.asset(
                'assets/svg/planning.svg',
                color:
                    index == 2 ? AppColors.whiteTextColor : AppColors.mainColor,
              ),
            ),
            Tab(
              text: 'Fridge Door',
              icon: SvgPicture.asset(
                'assets/svg/frige.svg',
                color:
                    index == 3 ? AppColors.whiteTextColor : AppColors.mainColor,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Center(
            child: [
              TabData(
                item: widget.items,
                screen: widget.screen,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: DashBoardWidget(
                  bookingList: widget.bookingList,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Column(
                  children: [
                    if (widget.screen == 'UserDetails')
                      Container()
                    else
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const AddPlanningScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              data: 'Programs',
                              fontColor: AppColors.blackTextColor,
                              fweight: FontWeight.w800,
                              fSize: 22,
                            ),
                            Image.asset(
                              'assets/icons/plusbutton.png',
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    const PlanWidgets(),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: FridgeDoor(),
              ),
            ][_tabController.index],
          ),
        ),
      ],
    );
  }
}

class TabData extends StatefulWidget {
  final List<ReelsData>? item;
  final String? screen;

  const TabData({super.key, this.item, this.screen});

  @override
  State<TabData> createState() => _TabDataState();
}

class _TabDataState extends State<TabData> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: widget.item!.isEmpty
          ? SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: Image(
                  image: AssetImage('assets/images/noData.png'),
                  height: 200,
                  width: 300,
                  fit: BoxFit.fill,
                ),
              ),
            )
          : GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1.3,
              ),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: 10, bottom: 20),
              children: List.generate(
                widget.item!.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowUploadReels(
                            index: index,
                            data: widget.item!,
                            screen: 'Laqta',
                          ),
                        ),
                      );
                    },
                    onLongPress: () {
                      if (widget.screen != 'UserDetails') {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (_) => CustomExitCard(
                            icon: CupertinoIcons.delete_solid,
                            title: 'Delete',
                            subTitle: 'Are you sure want to Delete Laqta ?',
                            positiveButton: 'Delete',
                            negativeButton: 'Cancel',
                            onPressed: () {
                              UserViewModel().getToken().then((value) {
                                Provider.of<DeleteExperianceViewModel>(context,
                                    listen: false)
                                    .deleteExperianceApi(value!,
                                    widget.item![index].id!, context,
                                    reels: true,
                                    userId: widget.item![index].userId);
                              });
                            },
                          ),
                        );
                      }
                    },
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    child: Container(
                      width: 110,
                      height: 180,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      margin: const EdgeInsets.only(top: 10, right: 10),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: widget.item?[index].videoThumbnailUrl ??
                                  'https://airjood.neuronsit.in/storage/reels/gcQ5z3MmXbsLfWqcihMg0bXZYNU3Zurlki1Y8lyK.jpg',
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    'https://airjood.neuronsit.in/storage/reels/gcQ5z3MmXbsLfWqcihMg0bXZYNU3Zurlki1Y8lyK.jpg',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error);
                                    },
                                  ),
                                );
                              },
                            ),
                            Container(
                              height: 30,
                              width: 180,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.0),
                                    Colors.black.withOpacity(0.2),
                                    Colors.black.withOpacity(0.5),
                                    Colors.black.withOpacity(0.8),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
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
    );
  }
}
