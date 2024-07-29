import 'dart:io';

import 'package:airjood/res/components/mainbutton.dart';
import 'package:airjood/res/components/maintextfild.dart';
import 'package:airjood/view_model/add_community_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';
import '../../../utils/utils.dart';
import '../../../view_model/user_view_model.dart';
import '../planning_view/screen_widgets/upload_image.dart';

class AddCommunityScreen extends StatefulWidget {
  const AddCommunityScreen({super.key});

  @override
  State<AddCommunityScreen> createState() => _AddCommunityScreenState();
}

class _AddCommunityScreenState extends State<AddCommunityScreen> {
  @override
  void initState() {
    super.initState();
    UserViewModel().getToken().then((value) {
      token = value;
      setState(() {});
    });
  }

  File? image;
  File? image2;
  String? token;
  final TextEditingController communityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final addCommunity = Provider.of<AddCommunityViewModel>(context);
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
                        color: AppColors.blackTextColor,
                        fontWeight: FontWeight.w700,
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
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                child: UploadImage(
                  name: 'Upload Cover Image',
                  image: image,
                  onValue: ((val) {
                    setState(() {
                      image = val;
                    });
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                child: UploadImage(
                  name: 'Upload Profile Image',
                  image: image2,
                  onValue: ((val) {
                    setState(() {
                      image2 = val;
                    });
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                child: MainTextFild(
                  controller: communityController,
                  hintText: 'Enter Community Name',
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                child: MainTextFild(
                  controller: descriptionController,
                  hintText: 'Write a Description...',
                  maxLines: 3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (image == null) {
                      Utils.toastMessage('Please Upload Cover Image !');
                    } else if (image2 == null) {
                      Utils.toastMessage('Please Upload Profile Image !');
                    } else if (communityController.text.isEmpty) {
                      Utils.toastMessage('Please Enter Community Name!');
                    } else if (descriptionController.text.isEmpty) {
                      Utils.toastMessage('Please Enter Description !');
                    } else {
                      Map<String, String> data = {
                        'name': communityController.text.toString(),
                        'description': descriptionController.text.toString(),
                      };
                      addCommunity.addCommunityApi(
                          token!, data, image!, image2!, context);
                    }
                  },
                  child: MainButton(
                    loading: addCommunity.addCommunityLoadings,
                    data: 'Create Community',
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
