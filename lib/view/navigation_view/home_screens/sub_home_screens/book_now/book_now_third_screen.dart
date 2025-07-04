// import 'package:airjood/res/components/maintextfild.dart';
import 'package:flutter/material.dart';
import '../../../../../res/components/CustomText.dart';
import '../../../../../res/components/color.dart';
import '../../../../../res/components/mainbutton.dart';

class BookNowThirdScreen extends StatefulWidget {
  final Function? onTap;
  final String? totalPrice;
  final String? name;
  final String? address;
  const BookNowThirdScreen({super.key, this.onTap, this.totalPrice, this.name, this.address});

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
            widget.onTap!();
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
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data: widget.name ?? 'AL khayma Camp',
                        fontWeight: FontWeight.w800,
                        fSize: 18,
                        color: AppColors.blackTextColor,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/1.4,
                        child: CustomText(
                          data: widget.address ?? '9 Al Khayma Camp, Dubai, UAE',
                          fontWeight: FontWeight.w600,
                          fSize: 13,
                          color: AppColors.greyTextColor,
                        ),
                      ),
                    ],
                  ),
                  CustomText(
                    data: '\$${widget.totalPrice ?? 195.67}',
                    fontWeight: FontWeight.w800,
                    fSize: 20,
                    color: AppColors.mainColor,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // MyCreditCardPage(
              //   cardNumber: cardNumber ?? '',
              //   expiryDate: expiryDate ?? '',
              //   cardHolderName: cardHolderName ?? '',
              //   cvvCode: cvvCode ?? '',
              //   onCreditCardModelChange: (CreditCardModel creditCardModel) {
              //     setState(() {
              //       cardNumber = creditCardModel.cardNumber;
              //       expiryDate = creditCardModel.expiryDate;
              //       cardHolderName = creditCardModel.cardHolderName;
              //       cvvCode = creditCardModel.cvvCode;
              //     });
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
