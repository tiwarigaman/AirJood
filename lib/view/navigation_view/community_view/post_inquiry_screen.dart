import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';
import '../../../res/components/mainbutton.dart';
import '../../../res/components/maintextfild.dart';
import '../planning_view/screen_widgets/upload_image.dart';

class PostInquiryScreen extends StatefulWidget {
  const PostInquiryScreen({super.key});

  @override
  State<PostInquiryScreen> createState() => _PostInquiryScreenState();
}

class _PostInquiryScreenState extends State<PostInquiryScreen> {
  File? image;
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
                        data: 'Post Inquiry',
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
                  name: 'Upload Attachment',
                  image: image,
                  onValue: ((val) {
                    setState(() {
                      image = val;
                    });
                  }),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16,),
                child: MainTextFild(
                  hintText: 'Type Inquiry or Comment...',
                  maxLines: 3,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16,),
                child: MainTextFild(
                  hintText: 'Enter your price',
                  maxLines: 1,
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16,),
                child: MainButton(
                  data: 'Post Inquiry',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
