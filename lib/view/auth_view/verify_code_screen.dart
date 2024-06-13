import 'dart:async';
import 'dart:io';
import 'package:airjood/firebase_messanging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import '../../res/components/color.dart';
import '../../res/components/mainbutton.dart';
import '../../utils/utils.dart';
import '../../view_model/auth_view_model.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String? mobile;
  final String? otp;

  const VerifyCodeScreen({super.key, this.otp, this.mobile});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final int _otpCodeLength = 4;
  String _otpCode = "";
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController = TextEditingController();
  String? abc;

  @override
  void initState() {
    super.initState();
    _getSignatureCode();
    _startListeningSms();
    NotificationServices().getDeviceToken().then((value) {
      deviceToken = value;
    });
    if (Platform.isIOS) {
      Future.delayed(Duration.zero, () {
        textEditingController.text = widget.otp ?? '1234';
      });
    } else {
      textEditingController.text = widget.otp ?? '1234';
    }
  }
  String? deviceToken;
  @override
  void dispose() {
    super.dispose();
    SmsVerification.stopListening();
  }

  _getSignatureCode() async {
    String? signature = await SmsVerification.getAppSignature();

    if (kDebugMode) {
      print("signature $signature");
    }
  }

  _startListeningSms() {
    SmsVerification.startListeningSms().then((message) {
      setState(() {
        _otpCode = SmsVerification.getCode(message, intRegex);
        textEditingController.text = _otpCode;
        _onOtpCallBack(_otpCode, true);
      });
    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      _otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
      } else {}
    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(FocusNode());
    Timer(const Duration(milliseconds: 4000), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
        padding:
            const EdgeInsets.only(left: 20.0, right: 20, top: 15, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verify Code',
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
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Enter the 4 digit code sent on your mobile number ',
                    style: GoogleFonts.nunito(
                      color: AppColors.greyTextColor,
                      fontSize: 16,
                      //fontFamily: 'Euclid Circular A',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.mobile}',
                    style: GoogleFonts.nunito(
                      color: AppColors.greyTextColor,
                      fontSize: 17,
                      //fontFamily: 'Euclid Circular A',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFieldPin(
              textController: textEditingController,
              autoFocus: true,
              codeLength: _otpCodeLength,
              alignment: MainAxisAlignment.center,
              defaultBoxSize: 55.0,
              margin: 10,
              selectedBoxSize: 55.0,
              textStyle:
                  const TextStyle(fontSize: 25, color: AppColors.mainColor),
              defaultDecoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.textFildBorderColor,
                ),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.textFildBGColor,
              ),
              selectedDecoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.mainColor,
                ),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.textFildBGColor,
              ),
              onChange: (code) {
                _onOtpCallBack(code, false);
              },
            ),
            const Spacer(),
            Center(
              child: Image.asset(
                'assets/icons/tabler_refresh.png',
                height: 20,
                width: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Resend Code : 00.20',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  color: AppColors.secondTextColor,
                  fontSize: 14,
                  //fontFamily: 'Euclid Circular A',
                  fontWeight: FontWeight.w400,
                  //height: 0,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                if (textEditingController.text.isEmpty) {
                  Utils.toastMessage('Plase enter OTP !');
                } else {
                  print('DEVICE TOKEN => $deviceToken');
                  Map<String, String> data = {
                    "otp": textEditingController.text.toString(),
                    "firebase_token":deviceToken.toString(),
                  };
                  authViewModel.OTPVerifyApi('${widget.mobile}', data, context);
                }
              },
              child: Center(
                child: MainButton(
                  loading: authViewModel.otpLoading_,
                  data: 'Verify',
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
