import 'dart:io';

import 'package:airjood/res/components/mainbutton.dart';
import 'package:airjood/res/components/maintextfild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';
import '../planning_view/screen_widgets/upload_image.dart';

class AddCommunityScreen extends StatefulWidget {
  const AddCommunityScreen({super.key});

  @override
  State<AddCommunityScreen> createState() => _AddCommunityScreenState();
}

class _AddCommunityScreenState extends State<AddCommunityScreen> {
  File? image;
  File? image2;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                   color: Color(0xFFF1F1F8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        data: 'Add New Community',
                        fontColor: AppColors.blackTextColor,
                        fweight: FontWeight.w700,
                        fSize: 22,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(CupertinoIcons.xmark),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16,),
                child: UploadImage(
                  name: 'Upload Cover Image',
                  onValue: ((val) {
                    setState(() {
                      image = val;
                    });
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16,),
                child: UploadImage(
                  name: 'Upload Profile Image',
                  onValue: ((val) {
                    setState(() {
                      image2 = val;
                    });
                  }),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16,),
                child: MainTextFild(
                  hintText: 'Enter Community Name',
                  maxLines: 1,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16,),
                child: MainTextFild(
                  hintText: 'Write a Description...',
                  maxLines: 3,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16,),
                child: MainButton(
                  data: 'Create Community',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
