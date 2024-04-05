import 'package:airjood/res/components/maintextfild.dart';
import 'package:flutter/material.dart';

import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  @override
  Widget build(BuildContext context) {
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
              data: 'Following (3214)',
              fSize: 20,
              fweight: FontWeight.w700,
              fontColor: AppColors.blackColor,
            ),
            const Spacer(),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              children: [
                const MainTextFild(
                  hintText: 'Search People...',
                  prefixIcon: Icon(
                    Icons.search_sharp,
                    color: AppColors.textFildHintColor,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListView.builder(
                  itemCount: 15,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/user.png',
                          height: 45,
                          width: 45,
                        ),
                      ),
                      title: const CustomText(
                        data: 'Skarlet Jhonson',
                        fontColor: AppColors.blackTextColor,
                        fSize: 14,
                        fweight: FontWeight.w500,
                      ),
                      subtitle: const CustomText(
                        data: 'davidwarner21@gmail.com',
                        fontColor: AppColors.greyTextColor,
                        fSize: 14,
                        fweight: FontWeight.w500,
                      ),
                      trailing: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: CustomText(
                            data: 'Following',
                            fontColor: Color(0xFF14C7FF),
                            fSize: 13,
                            fweight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
