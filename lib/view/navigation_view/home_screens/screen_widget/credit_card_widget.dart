// ignore_for_file: library_private_types_in_public_api

import 'package:airjood/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/components/color.dart';

class MyCreditCardPage extends StatefulWidget {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final Function(CreditCardModel) onCreditCardModelChange;

  const MyCreditCardPage({
    super.key,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    required this.onCreditCardModelChange,
  });

  @override
  _MyCreditCardPageState createState() => _MyCreditCardPageState();
}

class _MyCreditCardPageState extends State<MyCreditCardPage> {
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreditCardWidget(
          //padding: 0.0,
          cardNumber: widget.cardNumber,
          expiryDate: widget.expiryDate,
          cardHolderName: widget.cardHolderName,
          cvvCode: widget.cvvCode,
          showBackView: isCvvFocused,
          isHolderNameVisible: true,
          isChipVisible: true,
          obscureCardCvv: false,
          onCreditCardWidgetChange: (brand) {
            if (kDebugMode) {
              // print(brand.brandName);
            }
          },
        ),
        CreditCardForm(
          onCreditCardModelChange: widget.onCreditCardModelChange,
          cardNumber: widget.cardNumber,
          expiryDate: widget.expiryDate,
          cardHolderName: widget.cardHolderName,
          cvvCode: widget.cvvCode,
          formKey: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cvvValidationMessage: 'Please input a valid CVV',
          dateValidationMessage: 'Please input a valid date',
          numberValidationMessage: 'Please input a valid number',
          onFormComplete: () {
            Utils.tostMessage('Complete Details');
          },
          inputConfiguration: InputConfiguration(
            cardNumberTextStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.black,
            ),
            cardHolderTextStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.black,
            ),
            expiryDateTextStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.black,
            ),
            cvvCodeTextStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.black,
            ),
            cardHolderDecoration: InputDecoration(
              filled: true,
              fillColor: AppColors.textFildBGColor,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              hintText: 'Card Holder',
              hintStyle: GoogleFonts.nunitoSans(
                color: AppColors.textFildHintColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              border: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: AppColors.textFildBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: AppColors.textFildBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: AppColors.textFildBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: AppColors.textFildBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            cardNumberDecoration: InputDecoration(
              filled: true,
              fillColor: AppColors.textFildBGColor,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              hintText: 'Card Number',
              hintStyle: GoogleFonts.nunitoSans(
                color: AppColors.textFildHintColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              border: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: AppColors.textFildBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: AppColors.textFildBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: AppColors.textFildBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: AppColors.textFildBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            expiryDateDecoration: InputDecoration(
              filled: true,
              fillColor: AppColors.textFildBGColor,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              hintText: 'Expired Date',
              hintStyle: GoogleFonts.nunitoSans(
                color: AppColors.textFildHintColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              border: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: AppColors.textFildBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: AppColors.textFildBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: AppColors.textFildBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: AppColors.textFildBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            cvvCodeDecoration: InputDecoration(
              filled: true,
              fillColor: AppColors.textFildBGColor,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              hintText: 'CVV',
              hintStyle: GoogleFonts.nunitoSans(
                color: AppColors.textFildHintColor,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              border: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: AppColors.textFildBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: AppColors.textFildBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: AppColors.textFildBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: AppColors.textFildBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
