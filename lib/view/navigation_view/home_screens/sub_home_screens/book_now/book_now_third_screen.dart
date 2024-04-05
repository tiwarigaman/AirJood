// import 'package:airjood/res/components/maintextfild.dart';
import 'package:airjood/view/navigation_view/home_screens/screen_widget/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import '../../../../../res/components/CustomText.dart';
import '../../../../../res/components/color.dart';
import '../../../../../res/components/mainbutton.dart';

class BookNowThirdScreen extends StatefulWidget {
  final Function? onTap;
  const BookNowThirdScreen({super.key, this.onTap});

  @override
  State<BookNowThirdScreen> createState() => _BookNowThirdScreenState();
}

class _BookNowThirdScreenState extends State<BookNowThirdScreen> {
  String? cardNumber;
  String? expiryDate;
  String? cardHolderName;
  String? cvvCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: InkWell(
          onTap: () {
            //widget.onTap!();
          },
          child: const MainButton(
            data: 'Agree all terms & Pay Secure',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data: 'AL khayma Camp',
                        fweight: FontWeight.w800,
                        fSize: 18,
                        fontColor: AppColors.blackTextColor,
                      ),
                      CustomText(
                        data: '9 Al Khayma Camp, Dubai, UAE',
                        fweight: FontWeight.w600,
                        fSize: 13,
                        fontColor: AppColors.greyTextColor,
                      ),
                    ],
                  ),
                  CustomText(
                    data: '\$195.67',
                    fweight: FontWeight.w800,
                    fSize: 20,
                    fontColor: AppColors.mainColor,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              MyCreditCardPage(
                cardNumber: cardNumber ?? '',
                expiryDate: expiryDate ?? '',
                cardHolderName: cardHolderName ?? '',
                cvvCode: cvvCode ?? '',
                onCreditCardModelChange: (CreditCardModel creditCardModel) {
                  setState(() {
                    cardNumber = creditCardModel.cardNumber;
                    expiryDate = creditCardModel.expiryDate;
                    cardHolderName = creditCardModel.cardHolderName;
                    cvvCode = creditCardModel.cvvCode;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
