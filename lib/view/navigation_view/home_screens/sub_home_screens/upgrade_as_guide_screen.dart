import 'dart:io';

import 'package:airjood/utils/utils.dart';
import 'package:airjood/view/navigation_view/home_screens/component/upload_conditions_signature.dart';
import 'package:airjood/view/navigation_view/home_screens/component/upload_id.dart';
import 'package:airjood/view/navigation_view/home_screens/component/upload_passport.dart';
import 'package:airjood/view/navigation_view/home_screens/component/upload_tourist_certificate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/mainbutton.dart';
import '../../../../view_model/update_user_view_model.dart';
import '../../../../view_model/user_view_model.dart';

class UpgradeGuideScreen extends StatefulWidget {
  const UpgradeGuideScreen({super.key});

  @override
  State<UpgradeGuideScreen> createState() => _UpgradeGuideScreenState();
}

class _UpgradeGuideScreenState extends State<UpgradeGuideScreen> {
  File? image;
  File? image1;
  File? image2;
  File? image3;
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
    final authViewModel = Provider.of<UpdateUserModel>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.whiteColor,
          actions: [
            const SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.keyboard_arrow_left_rounded,
                size: 35,
                weight: 2,
              ),
            ),
            const CustomText(
              data: 'Upgrade as Guide',
              fSize: 22,
              fweight: FontWeight.w700,
              fontColor: AppColors.blackColor,
            ),
            const Spacer(),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomText(
                  data: 'To sign up as guide, we need following fields',
                  fontColor: AppColors.greyTextColor,
                  fweight: FontWeight.w400,
                  fSize: 14,
                ),
                const SizedBox(
                  height: 20,
                ),
                UploadId(
                  onValue: ((val) {
                    if (kDebugMode) {
                      print('A1 => $val');
                    }
                    setState(() {
                      image = val;
                    });
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                UploadPassport(
                  onValue: ((val) {
                    if (kDebugMode) {
                      print('A2 => $val');
                    }
                    setState(() {
                      image1 = val;
                    });
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                UploadTouristCertificate(
                  onValue: ((val) {
                    if (kDebugMode) {
                      print('A3 => $val');
                    }
                    setState(() {
                      image2 = val;
                    });
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 70,
                  decoration: ShapeDecoration(
                    color: AppColors.textFildBGColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: 238,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Download ',
                                style: GoogleFonts.nunitoSans(
                                  color: AppColors.splashTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.14,
                                ),
                              ),
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: GoogleFonts.nunitoSans(
                                  color: AppColors.blueShadeColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  letterSpacing: 0.14,
                                ),
                              ),
                              TextSpan(
                                text: ' and upload it with signature below.',
                                style: GoogleFonts.nunitoSans(
                                  color: AppColors.splashTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/download.png'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                UploadConditionsSignature(
                  onValue: ((val) {
                    if (kDebugMode) {
                      print('A4 => $val');
                    }
                    setState(() {
                      image3 = val;
                    });
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    if (image == null) {
                      Utils.tostMessage('Please Upload ID');
                    } else if (image1 == null) {
                      Utils.tostMessage('Please Upload Passport');
                    } else if (image2 == null) {
                      Utils.tostMessage('Please Upload Tourist Certificate');
                    } else if (image3 == null) {
                      Utils.tostMessage(
                          'Please Upload Terms & Conditions with Signature');
                    } else {
                      authViewModel.updateUserApi(
                          token!, image, image1, image2, image3, context);
                    }
                  },
                  child: MainButton(
                    loading: authViewModel.updateUserLoading,
                    data: 'Submit Now',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
