import 'dart:ui';

import 'package:airjood/view/navigation_view/chat_view/chat_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';
import '../../../res/components/maintextfild.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List data = [
    {'image':'assets/images/person.png','message': '05', 'time': '12 Min'},
    {'image':'assets/images/personbig.png','message': '', 'time': 'Tue'},
    {'image':'assets/images/user.png','message': '', 'time': 'Sun'},
    {'image':'assets/images/person.png','message': '02', 'time': 'Mon'},
    {'image':'assets/images/personbig.png','message': '', 'time': 'Tue'},
    {'image':'assets/images/user.png','message': '', 'time': 'Sun'},
    {'image':'assets/images/person.png','message': '02', 'time': 'Mon'},
    {'image':'assets/images/personbig.png','message': '02', 'time': 'Mon'},
    {'image':'assets/images/user.png','message': '', 'time': 'Sun'},
    {'image':'assets/images/person.png','message': '05', 'time': '12 Min'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        actions: const [
          SizedBox(width: 20),
          CustomText(
            data: 'My Chats',
            fSize: 22,
            fweight: FontWeight.w600,
            fontColor: AppColors.blackColor,
          ),
          Spacer(),
          CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage(
              'assets/images/personbig.png',
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const MainTextFild(
                hintText: 'Search People...',
                maxLines: 1,
                prefixIcon: Icon(
                  Icons.search_sharp,
                  color: AppColors.textFildHintColor,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatDetailsScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Row(
                        children: [
                           CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                AssetImage(data[index]['image']),
                          ),
                          const SizedBox(width: 10),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                data: 'Saimon Jhonson',
                                fSize: 15,
                                fontColor: AppColors.blackTextColor,
                                fweight: FontWeight.w600,
                              ),
                              CustomText(
                                data: 'Driver location would be here',
                                fSize: 13,
                                fontColor: AppColors.secondTextColor,
                                fweight: FontWeight.w500,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              data[index]['message'] == ''
                                  ? const SizedBox()
                                  : CircleAvatar(
                                      backgroundColor: AppColors.mainColor,
                                      radius: 10,
                                      child: Center(
                                        child: CustomText(
                                          data: '${data[index]['message']}',
                                          fontColor: AppColors.whiteTextColor,
                                          fSize: 10,
                                        ),
                                      ),
                                    ),
                              const SizedBox(height: 5),
                              CustomText(
                                data: '${data[index]['time']}',
                                fontColor: AppColors.secondTextColor,
                                fweight: FontWeight.w500,
                                fSize: 13,
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
