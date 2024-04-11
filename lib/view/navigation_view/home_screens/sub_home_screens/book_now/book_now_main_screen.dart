import 'package:airjood/res/components/color.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/book_now/book_now_fourth_screen.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/book_now/book_now_second_screen.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/book_now/book_now_third_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../view_model/user_view_model.dart';
import 'book_now_first_screen.dart';

class BookNowMainScreen extends StatefulWidget {
  final int? experienceId;
  const BookNowMainScreen({super.key, this.experienceId});

  @override
  State<BookNowMainScreen> createState() => _BookNowMainScreenState();
}

class _BookNowMainScreenState extends State<BookNowMainScreen> {
  PageController pagecontroller = PageController();

  int currentPage = 0;

  onChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

  String? token;
  @override
  void initState() {
    super.initState();
    UserViewModel().getToken().then((value) {
      token = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // final authViewModel = Provider.of<AddExperianceViewModel>(context);
    List onBordingData = [
      BookNowFirstScreen(
        experienceId: widget.experienceId,
        onTap: () {
          pagecontroller.nextPage(
            duration: const Duration(milliseconds: 1),
            curve: Curves.bounceIn,
          );
        },
      ),
      BookNowSecondScreen(
        onTap: () {
          pagecontroller.nextPage(
            duration: const Duration(milliseconds: 1),
            curve: Curves.bounceIn,
          );
        },
      ),
      BookNowFourthScreen(
        onTap: () {
          pagecontroller.nextPage(
            duration: const Duration(milliseconds: 1),
            curve: Curves.bounceIn,
          );
        },
      ),
      const BookNowThirdScreen(),
    ];

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color(0xFFF1F1F8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        pagecontroller.previousPage(
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.bounceIn);
                      },
                      child: const Icon(Icons.arrow_back_ios_rounded),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: onBordingData.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => pagecontroller.animateToPage(entry.key,
                              duration: const Duration(seconds: 0),
                              curve: Curves.linear),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    width: 1.5,
                                    color: currentPage == entry.key
                                        ? AppColors.mainColor
                                        : AppColors.transperent)),
                            child: Container(
                              width: currentPage == entry.key ? 10 : 10,
                              height: 10,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: currentPage == entry.key
                                    ? AppColors.mainColor
                                    : AppColors.blueGray,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        CupertinoIcons.xmark,
                        weight: 5,
                        size: 28,
                      ),
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
                  child: PageView.builder(
                    itemCount: onBordingData.length,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pagecontroller,
                    onPageChanged: (value) {
                      currentPage = value;
                      setState(() {});
                    },
                    itemBuilder: (context, index) {
                      return onBordingData[index];
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
