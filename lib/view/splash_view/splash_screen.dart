import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/color.dart';
import '../../view_model/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    splashServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/splashscreen.png',
              width: 313.74,
              height: 273.54,
            ),
            const Spacer(),
            Text(
              'Copyright © All Rights ',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                color: AppColors.splashTextColor,
                fontSize: 12,
                //fontFamily: 'Euclid Circular A',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'AIR JOOD 2024',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                color: AppColors.splashTextColor,
                fontSize: 12,
                //fontFamily: 'Euclid Circular A',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
