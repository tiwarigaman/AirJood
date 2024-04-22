import 'package:airjood/utils/routes/routes_name.dart';
import 'package:airjood/view/navigation_view/home_screens/component/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/customiconbutton.dart';
import '../../../../view_model/user_view_model.dart';
import '../../../auth_view/login_screen.dart';
import '../../ExitBar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    UserViewModel().getUser().then((value) {
      name = value?.name;
      created_at = value?.createdAt;
      image = value?.profileImageUrl;
      guide = value?.is_upgrade;
      userId = value?.id;
      setState(() {});
    });
  }

  String? name;
  DateTime? created_at;

  String? image;
  bool? guide;
  int? userId;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserViewModel>(context);
    const size = SizedBox(
      height: 15,
    );
    return Scaffold(
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
            data: 'Setting',
            fSize: 22,
            fweight: FontWeight.w700,
            fontColor: AppColors.blackColor,
          ),
          const Spacer(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              size,
              UserProfile(name: name, joinDate: created_at, image: image,userId: userId,screen: 'MyScreen',),
              size,
              guide == false
                  ? InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.upgradeGuide);
                      },
                      child: Image.asset(
                        'assets/images/premium.png',
                        height: 110,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    )
                  : const SizedBox(),
              size,
              const CustomIconButton(
                data: 'Contact Us',
                assetName: 'assets/svg/microphone.svg',
              ),
              size,
              const CustomIconButton(
                data: 'About AirJood',
                assetName: 'assets/svg/about.svg',
              ),
              size,
              const CustomIconButton(
                data: 'Privacy Policy',
                assetName: 'assets/svg/privacy.svg',
              ),
              size,
              const CustomIconButton(
                data: 'Terms & Conditions',
                assetName: 'assets/svg/terms.svg',
              ),
              size,
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) => CustomExitCard(
                      icon: CupertinoIcons.square_arrow_right,
                      title: 'Logout',
                      positiveButton: 'Yes',
                      negativeButton: 'No',
                      subTitle: 'Are you sure you want to Logout ?',
                      onPressed: () {
                        userData.remove().then((value) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        });
                        userData.removeUser();
                      },
                    ),
                  );
                },
                child: const CustomIconButton(
                  data: 'Logout',
                  assetName: 'assets/svg/logout.svg',
                ),
              ),
              size,
              const CustomIconButton(
                data: 'Deactivate Account',
                assetName: 'assets/svg/deactive.svg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
