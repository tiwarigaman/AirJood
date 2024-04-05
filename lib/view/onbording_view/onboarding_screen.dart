import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/color.dart';
import '../../res/components/mainbutton.dart';
import '../../res/components/nextbutton.dart';
import '../../res/components/previousbutton.dart';
import '../../utils/routes/routes_name.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pagecontroller = PageController();

  int currentPage = 0;

  onChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List onBordingData = [
      {
        "image": 'assets/images/onboardingone.png',
        "Width": MediaQuery.of(context).size.width,
      },
      {
        "image": 'assets/images/onboardingsecond.png',
        "Width": MediaQuery.of(context).size.width / 1.2,
      },
      {
        "image": 'assets/images/onboardingthree.png',
        "Width": MediaQuery.of(context).size.width,
      },
    ];
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              onPageChanged: onChange,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: pagecontroller,
              itemCount: onBordingData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Image.asset(
                            'assets/images/onboardingBackgroung.png',
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'assets/images/onboardingBack.png',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              currentPage == 0 || currentPage == 1
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, RoutesName.login);
                                      },
                                      child: Align(
                                          alignment:
                                              AlignmentDirectional.topEnd,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 15,top: 35),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Skip',
                                                  textAlign: TextAlign.right,
                                                  style: GoogleFonts.nunito(
                                                    color:
                                                        AppColors.mainColor,
                                                    fontSize: 16,
                                                    //fontFamily: 'Euclid Circular A',
                                                    fontWeight:
                                                        FontWeight.w400,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons
                                                      .keyboard_arrow_right_rounded,
                                                  color: AppColors.mainColor,
                                                )
                                              ],
                                            ),
                                          )),
                                    )
                                  : const SizedBox(),
                              Align(
                                alignment: AlignmentDirectional.bottomCenter,
                                child: Image.asset(
                                  onBordingData[index]['image'],
                                  width: onBordingData[index]['Width'],
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error);
                                  },
                                  //fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'An amazing app for finding \nand booking local happenings \nof all kinds.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        color: AppColors.splashTextColor,
                        fontSize: 22,
                        //fontFamily: 'Euclid Circular A',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet consectetur. Lorem pellentesque vitae non consectetu.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        color: AppColors.greyTextColor,
                        fontSize: 16,
                        //fontFamily: 'Euclid Circular A',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: currentPage == 2
                ? InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.login);
                    },
                    child: const MainButton(
                      data: 'Get Started',
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          pagecontroller.previousPage(
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.bounceIn);
                        },
                        child: const PreviousButton(
                          icon: CupertinoIcons.left_chevron,
                          data: 'Previous',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          pagecontroller.nextPage(
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.bounceIn,
                          );
                        },
                        child: const NextButton(
                          icon: CupertinoIcons.right_chevron,
                          data: 'Next',
                        ),
                      ),
                    ],
                  ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
