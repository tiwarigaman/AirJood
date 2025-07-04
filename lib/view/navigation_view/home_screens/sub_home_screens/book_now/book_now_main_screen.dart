import 'dart:convert';
import 'dart:developer';

import 'package:airjood/model/experience_model.dart';
import 'package:airjood/res/components/color.dart';
import 'package:airjood/utils/utils.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/book_now/book_now_fourth_screen.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/book_now/book_now_second_screen.dart';
import 'package:airjood/view_model/create_booking_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import '../../../../../res/components/CustomText.dart';
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

  String? name;
  String? address;
  int? exId;
  int? reelsId;
  List<Addon>? addon;
  String? reelsUrl;
  String? videoThumbnailUrl;
  String? price;
  String? totalPrice;
  String? userCharges;
  List? facilitates;
  int? minGuest;
  int? maxGuest;
  String? date;
  String? noOfGuest;
  String? comment;
  List? selectedFacilitates;
  String? reelsUserProfileImage;
  String? reelsUserName;
  String? priceType;
  String? totalOfPrice;
  Map<String, dynamic>? paymentIntent;

  /// Stripe Payment
  Future<void> makePayment(int totalOfPrice) async {
    try {
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent(totalOfPrice.toString(), 'USD');
      final user = await UserViewModel().getUser();

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret:
                  paymentIntent!['client_secret'], //Gotten from payment intent
              style: ThemeMode.light,
              merchantDisplayName: 'Airjood',
              customerId: user!.id.toString(),
            ),
          )
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      Utils.toastMessage(err.toString());
      throw Exception(err);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      Utils.toastMessage(err.toString());
      throw Exception(err.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        await paymentSuccessApi('Stripe');
        if (mounted) {
          Utils.flushBarErrorMessage("Payment Successful!", context,Colors.green);
          paymentIntent = null;
        }
      }).onError((error, stackTrace) {
        if (mounted) {
          Utils.toastMessage(error.toString());
          throw Exception(error);
        }
      });
    } on StripeException catch (e) {
      if (kDebugMode) {
        print('$e');
      }
      if (mounted) {
        Utils.flushBarErrorMessage("Payment Failed!", context,Colors.red);
      }
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  void makePaymentWithPaypal(int totalOfPrice) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId:
            "Ad-OolkrYST_44CF3IA7AiK_8TA_dTs4MAzj8MS6c3SZzK3a6Jsr1hxANRgYGcKfaBBCC_L06xRC2D2C",
        secretKey:
            "EHXDer72gUmu-TBVVAdQIYA0nwiv3MnbEnnaNfjCPmyujgMebQ_9aUgS5oUt4HQOMihTjKTFJzgR_03W",
        transactions: [
          {
            "amount": {
              "total": '$totalOfPrice',
              "currency": "USD",
              "details": {
                "subtotal": '$totalPrice',
                "shipping": '0',
                "shipping_discount": 0
              }
            },
            "description": "",
            "item_list": {
              "items": [
                {
                  "name": "$name",
                  "quantity": 1,
                  "price": '$totalPrice',
                  "currency": "USD"
                }
              ],
            }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          log("onSuccess: $params");
          Navigator.pop(context);
          await paymentSuccessApi('Paypal');
          Navigator.pop(context);
        },
        onError: (error) {
          log("onError: $error");
          Utils.toastMessage(error);
          Navigator.pop(context);
        },
        onCancel: () {
          Navigator.pop(context);
        },
      ),
    ));
  }

  Future<void> paymentSuccessApi(String paymentMethod) async {
    List<int?>? addonIds = addon?.map((e) => e.id).toList();
    List<dynamic>? facilityIds = selectedFacilitates?.map((e) => e).toList() ?? [];
    Map<String, dynamic> data = {
      'experience_id': '$exId',
      'payment_method': paymentMethod,
      'date': '$date',
      'no_of_guests': '$noOfGuest',
      'booking_charges': '$userCharges',
      'total_amount': '$totalOfPrice',
      'addons': "$addonIds",
      'comment': '$comment',
      'facility_id': facilityIds.toString(),
    };
    await Provider.of<CreateBookingViewModel>(context, listen: false)
        .createBookingApi(token!, data, context);
  }

  Future<String?> _showMyDialog() async {
    String? selectedPaymentMethod;
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const CustomText(
            data: 'Select Payment',
            color: AppColors.blackColor,
            fSize: 20,
            fontWeight: FontWeight.w700,
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    minVerticalPadding: 0,
                    title: const CustomText(
                      data: 'PayPal',
                      color: AppColors.mainColor,
                      fSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    dense: false,
                    contentPadding: EdgeInsets.zero,
                    leading: Radio<String>(
                      value: 'PayPal',
                      groupValue: selectedPaymentMethod,
                      activeColor: AppColors.mainColor,
                      onChanged: (String? value) {
                        setState(() {
                          selectedPaymentMethod = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 0,
                    title: const CustomText(
                      data: 'Stripe',
                      color: AppColors.mainColor,
                      fSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    dense: false,
                    contentPadding: EdgeInsets.zero,
                    leading: Radio<String>(
                      value: 'Stripe',
                      groupValue: selectedPaymentMethod,
                      activeColor: AppColors.mainColor,
                      onChanged: (String? value) {
                        setState(() {
                          selectedPaymentMethod = value;
                        });
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 38,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.mainColor,
                ),
                child: const Center(
                  child: CustomText(
                    data: 'cancel',
                    color: AppColors.whiteColor,
                    fSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context, selectedPaymentMethod);
              },
              child: Container(
                height: 38,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.mainColor,
                ),
                child: const Center(
                  child: CustomText(
                    data: 'Confirm',
                    color: AppColors.whiteColor,
                    fSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final authViewModel = Provider.of<AddExperianceViewModel>(context);
    List onBordingData = [
      BookNowFirstScreen(
        experienceId: widget.experienceId,
        onTap: (value) {
          exId = value['experience_id'];
          name = value['name'];
          reelsId = value['reels'];
          addon = value['addon'];
          totalPrice = value['totalPrice'];
          userCharges = value['userCharges'];
          videoThumbnailUrl = value['videoThumbnailUrl'];
          reelsUserProfileImage = value['reelsUserProfileImage'];
          reelsUserName = value['reelsUserName'];
          reelsUrl = value['reelsUrl'];
          address = value['address'];
          price = value['price'];
          facilitates = value['facilitates'];
          minGuest = value['minGuest'];
          maxGuest = value['maxGuest'];
          priceType = value['price_type'];
          setState(() {});
          pagecontroller.nextPage(
            duration: const Duration(milliseconds: 1),
            curve: Curves.bounceIn,
          );
        },
      ),
      BookNowSecondScreen(
        address: address,
        facilitates: facilitates,
        maxGuest: maxGuest,
        minGuest: minGuest,
        name: name,
        price: totalPrice,
        onTap: (value) {
          date = value['date'];
          selectedFacilitates = value['selectFacilities'];
          comment = value['comment'];
          noOfGuest = value['noOfGuest'];
          pagecontroller.nextPage(
            duration: const Duration(milliseconds: 1),
            curve: Curves.bounceIn,
          );
        },
      ),
      BookNowFourthScreen(
        date: date,
        price: price,
        totalPrice: totalPrice,
        userCharges: userCharges,
        comment: comment,
        noOfGuest: noOfGuest,
        reelsUrl: reelsUrl,
        addon: addon,
        videoThumbnailUrl: videoThumbnailUrl,
        selectedFacilitates: facilitates,
        reelsUserName: reelsUserName,
        reelsUserProfileImage: reelsUserProfileImage,
        address: address,
        priceType: priceType,
        onTap: (value) async {
          totalOfPrice = value.toString();
          String? paymentMethod = await _showMyDialog();
          if (paymentMethod == 'PayPal') {
            makePaymentWithPaypal(value);
          } else if (paymentMethod == 'Stripe') {
            makePayment(value);
          }
        },
      ),
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
