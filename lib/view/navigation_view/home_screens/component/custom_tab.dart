import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/maintextfild.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int? index;

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
          contentPadding: const EdgeInsets.symmetric(horizontal: 19),
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
          tabs: const [
            Tab(text: 'All Users'),
            Tab(text: 'Followers'),
            Tab(text: 'Followings'),
          ],
        ),
        Center(
          child: [
            const AllUsers(),
            const SizedBox(),
            const SizedBox(),
          ][_tabController.index],
        ),
      ],
    );
  }
}

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  final List data = [
    {'image':'assets/images/person.png'},
    {'image':'assets/images/personbig.png'},
    {'image':'assets/images/user.png'},
    {'image':'assets/images/person.png'},
    {'image':'assets/images/personbig.png'},
    {'image':'assets/images/user.png'},
    {'image':'assets/images/person.png'},
    {'image':'assets/images/personbig.png'},
    {'image':'assets/images/user.png'},
    {'image':'assets/images/person.png'},
  ];
  List<bool> invitedList = List<bool>.generate(10, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          MainTextFild(
            hintText: 'Search People...',
            onChanged: (values) {},
            onFieldSubmitted: (values) {},
            maxLines: 1,
            prefixIcon: const Icon(
              Icons.search_sharp,
              color: AppColors.textFildHintColor,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                      AssetImage(data[index]['image']),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          data: 'Saimon Jhonson',
                          fSize: 15,
                          fontColor: AppColors.blackTextColor,
                          fweight: FontWeight.w600,
                        ),
                        CustomText(
                          data: 'davidwarner21@gmail.com',
                          fSize: 13,
                          fontColor: AppColors.secondTextColor,
                          fweight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          invitedList[index] = !invitedList[index];
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          color: invitedList[index]
                              ? Colors.grey.shade300 // Change to invited style
                              : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: CustomText(
                            data: invitedList[index] ? 'Invited' : 'Invite Now',
                            fontColor: invitedList[index]
                                ? Colors.black // Change to invited text color
                                : Color(0xFF14C7FF),
                            fSize: 13,
                            fweight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
