import 'dart:io';
import 'package:airjood/utils/utils.dart';
import 'package:airjood/view/navigation_view/home_screens/component/drawer_cam_gallery.dart';
import 'package:airjood/view/navigation_view/home_screens/component/multiselect_dropdown.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/datebutton.dart';
import '../../../../res/components/dropdownbutton.dart';
import '../../../../res/components/maintextfild.dart';
import '../../../../view_model/auth_view_model.dart';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';

class EditProfileScreen extends StatefulWidget {
  final String? token;
  final String? image;
  final String? name;
  final String? email;
  final String? gender;
  final DateTime? dob;
  final List<String>? language;
  final String? about;
  final String? number;

  const EditProfileScreen(
      {super.key,
      this.name,
      this.email,
      this.gender,
      this.dob,
      this.language,
      this.about,
      this.image,
      this.token,
      this.number});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('d MMM yyyy').format(selectedDate!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _downloadImage();
    setState(() {
      selectedDate = widget.dob;
      formattedDate = DateFormat('d MMM yyyy').format(selectedDate!);
    });
  }

  Future<void> _downloadImage() async {
    final response = await http.get(Uri.parse(widget.image!));
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final filePath = '${documentsDirectory.path}/profile_image.png';
    image = File(filePath);
    await image!.writeAsBytes(response.bodyBytes);
    setState(() {});
  }

  String? formattedDate;
  String? selectedItem;
  List? selected;
  File? image;
  String? result;
  String? results;

  @override
  Widget build(BuildContext context) {
    List<dynamic>? dynamicList = widget.language;
    String? stringList =
        selected?.map((element) => element.toString()).join(',');
    nameController.text = widget.name ?? '';
    emailController.text = widget.email ?? '';
    aboutController.text = widget.about ?? '';
    results = widget.language?.join(',');
    result = stringList ?? results;
    const size = SizedBox(
      height: 15,
    );
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
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
            data: 'Edit Profile',
            fSize: 22,
            fweight: FontWeight.w700,
            fontColor: AppColors.blackColor,
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              if (nameController.text.isEmpty) {
                Utils.toastMessage('please enter name');
              } else if (emailController.text.isEmpty ||
                  !EmailValidator.validate(emailController.text)) {
                Utils.toastMessage('please enter valid email !');
              } else {
                Map<String, String> data = {
                  'contact_no': '${widget.number}',
                  'name': nameController.text.toString(),
                  'email': emailController.text.toString(),
                  'gender': selectedItem ??
                      (widget.gender == 'Male'
                          ? '0'
                          : widget.gender == 'Female'
                              ? '1'
                              : widget.gender == 'Other'
                                  ? '2'
                                  : 'Gender'),
                  'dob': '$selectedDate',
                  'languages': '$result',
                  'about': aboutController.text.toString(),
                };
                authViewModel.updateProfileApi(
                    widget.token, data, image, context);
              }
            },
            child: Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0x1914C7FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: authViewModel.updateLoading == true
                    ? const Center(
                        child: SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            color: AppColors.mainColor,
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          Image.asset(
                            'assets/icons/calender.png',
                            color: AppColors.blueShadeColor,
                            height: 20,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const CustomText(
                            data: 'Save',
                            fSize: 14,
                            fweight: FontWeight.w400,
                            fontColor: AppColors.blueShadeColor,
                          )
                        ],
                      ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              size,
              DrawerCamera(
                image: widget.image,
                onValue: ((val) {
                  setState(() {
                    image = val;
                  });
                }),
              ),
              size,
              size,
              MainTextFild(
                labelText: 'Enter your full name *',
                controller: nameController,
                prefixIcon: const Icon(
                  CupertinoIcons.person,
                  color: AppColors.textFildHintColor,
                  weight: 5,
                ),
                maxLines: 1,
              ),
              size,
              MainTextFild(
                labelText: 'Enter your email address',
                controller: emailController,
                prefixIcon: const Icon(
                  CupertinoIcons.envelope,
                  color: AppColors.textFildHintColor,
                  weight: 5,
                ),
                maxLines: 1,
              ),
              size,
              Row(
                children: [
                  Expanded(
                    child: CustomDropdownButton(
                      onChanged: (value) {
                        setState(() {
                          selectedItem = value as String?;
                        });
                      },
                      value: selectedItem ??
                          (widget.gender == 'Male'
                              ? '0'
                              : widget.gender == 'Female'
                                  ? '1'
                                  : widget.gender == 'Other'
                                      ? '2'
                                      : 'Gender'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DateButton(
                      data: 'Select DOB',
                      onTap: () {
                        _selectDate(context);
                      },
                      formattedDate: formattedDate,
                    ),
                  ),
                ],
              ),
              size,
              MultiSelectDrop(
                initialValue: dynamicList,
                onConfirm: (results) {
                  setState(() {
                    selected = results;
                  });
                },
              ),
              size,
              MainTextFild(
                controller: aboutController,
                labelText: 'Enter your about',
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
