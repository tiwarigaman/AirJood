import 'dart:io';

import 'package:airjood/model/reels_model.dart';
import 'package:airjood/res/components/color.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/experience_screens/add_experience_step1.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/experience_screens/add_experience_step2.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/experience_screens/add_experience_step3.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/experience_screens/add_experience_step4.dart';
import 'package:airjood/view_model/add_experiance_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../model/FormData.dart';
import '../../../../../view_model/user_view_model.dart';

class AddExperienceScreen extends StatefulWidget {
  const AddExperienceScreen({super.key});

  @override
  State<AddExperienceScreen> createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  PageController pagecontroller = PageController();

  int currentPage = 0;

  onChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
    UserViewModel().getToken().then((value) {
      token = value;
      setState(() {});
    });
  }

  String? token;
  List<int> id = [];
  String? image;
  String? video;
  String? activity;
  String? description;
  String? location;
  String? city;
  String? country;
  String state = 'abc';
  String? lat;
  String? lng;
  String? radioValue;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  File? fridgeImage;
  String? minPerson;
  String? maxPerson;
  String? price;
  List? mood;
  List? facilities;
  List selectedReels = [];
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AddExperianceViewModel>(context);
    List onBordingData = [
      AddExperienceStep1(
        onCameraTap: (value) {
          id = value['id'];
          video = value['video_url'];
          image = value['video_thumbnail_url'];
          pagecontroller.nextPage(
            duration: const Duration(milliseconds: 1),
            curve: Curves.bounceIn,
          );
        },
        onVideoTap: (value) {
          id = value['id'];
          video = value['video_url'];
          image = value['video_thumbnail_url'];
          pagecontroller.nextPage(
            duration: const Duration(milliseconds: 1),
            curve: Curves.bounceIn,
          );
        },
        onLaqtaTap: (ReelsData value) {
          Navigator.pop(context);
          id = [value.id!.toInt()];
          image = value.videoThumbnailUrl;
          video = value.videoUrl;
          pagecontroller.nextPage(
            duration: const Duration(milliseconds: 1),
            curve: Curves.bounceIn,
          );
        },
      ),
      AddExperienceStep2(
        id: id.isEmpty ? 0 : id[0],
        image: image,
        video: video,
        onNextTap: (value) {
          for (int i = 0; i < value['reels'].length; i++) {
            id.add(value['reels'][i].reelsId);
          }
          activity = value['name'];
          description = value['description'];
          pagecontroller.nextPage(
            duration: const Duration(milliseconds: 1),
            curve: Curves.bounceIn,
          );
        },
      ),
      AddExperienceStep3(
        image: image,
        video: video,
        activity: activity,
        description: description,
        onNextTap: (value) {
          location = value['location'];
          city = value['city'];
          country = value['country'];
          state = value['state'];
          lat = value['lat'];
          lng = value['lng'];
          radioValue = value['radio'];
          fridgeImage = value['fridgeImage'];
          startDate = value['startDate'];
          endDate = value['endDate'];
          startTime = value['startTime'];
          endTime = value['endTime'];
          minPerson = value['minPerson'];
          maxPerson = value['maxPerson'];
          price = value['price'];
          mood = value['mood'];
          facilities = value['facilities'];
          pagecontroller.nextPage(
            duration: const Duration(milliseconds: 1),
            curve: Curves.bounceIn,
          );
        },
      ),
      AddExperienceStep4(onTap: (List<AddonData> val) {
        print(id);
        Map<String, dynamic> data = {
          'name': '$activity',
          'description': '$description',
          'location': '$location',
          'country': '$country',
          'state': state,
          'city': '$city',
          'start_date': '$startDate $startTime',
          'end_date': '$endDate $endTime',
          'max_person': '$maxPerson',
          'min_person': '$minPerson',
          'price_type': '$radioValue',
          'price': '$price',
          // 'reel_id': id,
          'longitude': '$lng',
          'latitude': '$lat',
        };
        for (int i = 0; i < id.length; i++) {
          data['reel_id[$i]'] = id[i];
        }
        if (val[0].name.trim().isNotEmpty &&
            val[0].description.trim().isNotEmpty &&
            val[0].price.trim().isNotEmpty &&
            val[0].latqaId.trim().isNotEmpty) {
          for (int i = 0; i < val.length; i++) {
            data['addons[$i][name]'] = val[i].name;
            data['addons[$i][description]'] = val[i].description;
            data['addons[$i][price]'] = val[i].price;
            data['addons[$i][price_type]'] = val[i].priceType;
            data['addons[$i][reel_id]'] = val[i].latqaId;
          }
        }
        for (int i = 0; i < facilities!.length; i++) {
          data['facility_id[$i]'] = facilities?[i];
        }
        for (int i = 0; i < mood!.length; i++) {
          data['mood_id[$i]'] = mood?[i];
        }
        authViewModel.addExperianceApi(token!, data, fridgeImage!, context);
      }),
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
