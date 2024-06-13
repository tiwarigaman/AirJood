import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../res/components/color.dart';
import '../../res/components/mainbutton.dart';
import '../../res/components/mobilenumbertextfiled.dart';
import '../../utils/utils.dart';
import '../../view_model/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode focusNode = FocusNode();

  TextEditingController controller = TextEditingController();
  String countryCode = '1';
  String? mobileNumber;
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
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
          const Spacer(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login to Continue',
              style: GoogleFonts.nunito(
                color: AppColors.splashTextColor,
                fontSize: 25,
                //fontFamily: 'Euclid Circular A',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Enter your phone number below to Login/Register for a better experience.',
              style: GoogleFonts.nunito(
                color: AppColors.greyTextColor,
                fontSize: 16,
                //fontFamily: 'Euclid Circular A',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MobileTextFiled(
              controller: controller,
              onCountryChanged: (value) {
                countryCode = value.dialCode;
              },
              onChanged: (value) {
                setState(() {
                  mobileNumber = value.number;
                });
              },
            ),
            const Spacer(),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'By signing up you agree to Air Jood ',
                      style: GoogleFonts.nunito(
                        color: AppColors.greyTextColor,
                        fontSize: 12,
                        //fontFamily: 'Euclid Circular A',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: 'Terms & Conditions',
                      style: GoogleFonts.nunito(
                        color: AppColors.splashTextColor,
                        fontSize: 14,
                        //fontFamily: 'Euclid Circular A',
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                if (controller.text.isEmpty) {
                  Utils.toastMessage('Please Enter mobile number');
                } else {
                  Map<String, String> data = {
                    "mobile_number": "+$countryCode $mobileNumber",
                  };
                  authViewModel.mobileSendApi(
                      "+$countryCode $mobileNumber", data, context);
                }
              },
              child: Center(
                child: MainButton(
                  loading: authViewModel.mobileLoading,
                  data: 'Send Code',
                ),
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
