import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late final controller = SlidableController(this);
  final List data = [
    {
      'Image': 'assets/images/user.png',
      'name': 'Saimon jhonson',
      'dis': ' added a new post',
      'hei': 45,
      'wid':45,
    },
    {
      'Image': 'assets/images/user.png',
      'name': 'Jack Maa',
      'dis': ' Started following you',
      'hei': 45,
      'wid':45,
    },
    {
      'Image': 'assets/icons/like.png',
      'name': 'Saimon jhonson, Leena smith',
      'dis': ' and 25 others liked your post.',
      'hei': 20,
      'wid': 20,
    },
    {
      'Image': 'assets/icons/message.png',
      'name': 'Magdalina Kubica',
      'dis': ' Commented on your post click to reply her.',
      'hei': 20,
      'wid': 20,
    },
    {
      'Image': 'assets/images/user.png',
      'name': 'Anjilina Jolie',
      'dis': 'Started following you',
      'hei': 45,
      'wid':45,
    },
    {
      'Image': 'assets/images/user.png',
      'name': 'Rose Spartain',
      'dis': ' Started following you',
      'hei': 45,
      'wid':45,
    },
    {
      'Image': 'assets/icons/like.png',
      'name': 'Saimon jhonson, Leena smith',
      'dis': ' and 25 others liked your post.',
      'hei': 20,
      'wid': 20,
    },
    {
      'Image': 'assets/icons/message.png',
      'name': 'Magdalina Kubica',
      'dis': ' Commented on your post click to reply her.',
      'hei': 20,
      'wid': 20,
    },
    {
      'Image': 'assets/images/user.png',
      'name': 'Jack Maa',
      'dis': ' Started following you',
      'hei': 45,
      'wid': 45,
    },
    {
      'Image': 'assets/icons/like.png',
      'name': 'Saimon jhonson, Leena smith',
      'dis': ' and 25 others liked your post.',
      'hei': 20,
      'wid': 20,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: AppColors.whiteColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const CustomText(
                    data: 'Notifications',
                    fweight: FontWeight.w700,
                    fSize: 22,
                    fontColor: AppColors.blackTextColor,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      CupertinoIcons.xmark,
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: () {}),
                    extentRatio: 0.20,
                    children: const [
                      SlidableAction(
                        onPressed: doNothing,
                        backgroundColor: Color(0xFFD43672),
                        foregroundColor: Colors.white,
                        icon: CupertinoIcons.trash,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.only(left: 10,right: 10),
                        leading: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: AppColors.textFildBGColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(data[index]['hei'] == 20 ? 00 :100),
                              child: Image.asset(
                                  '${data[index]['Image']}',
                                height: data[index]['hei'].toDouble(),
                                width: data[index]['wid'].toDouble(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: RichText(
                                softWrap: true,
                                maxLines: 2,
                                text: TextSpan(
                                  text: '${data[index]['name']}',
                                  style: GoogleFonts.nunitoSans(
                                    color: AppColors.blackTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '${data[index]['dis']}',
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.tileTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: const CustomText(
                          data: '10 min ago',
                          fSize: 14,
                          fweight: FontWeight.w500,
                          fontColor: AppColors.tileTextColor,
                        ),
                      ),
                      const Divider(
                        height: 0.5,
                        thickness: 0.9,
                        color: AppColors.textFildBGColor,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
