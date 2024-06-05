import 'package:airjood/view/navigation_view/home_screens/screen_widget/search_widget.dart';
import 'package:airjood/view/navigation_view/home_screens/sub_home_screens/user_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../view_model/user_view_model.dart';
import 'custom_tab.dart';

class LoginUser extends StatefulWidget {
  final String? image;
  final Function? getImage;

  final TabController? controller;

  const LoginUser({super.key, this.image, this.getImage, this.controller});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  String? images;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const CustomTabBar(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    constraints: BoxConstraints.loose(
                      Size(MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.height * 0.85),
                    ),
                    isScrollControlled: true,
                    isDismissible: false,
                    enableDrag: false,
                    builder: (_) => const SearchWidget(),
                  );
                },
                child: const Image(
                  image: AssetImage('assets/icons/search.png'),
                  height: 20,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Image(
                image: AssetImage('assets/icons/notification.png'),
                height: 20,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                // Navigator.pushNamed(context, RoutesName.userDetail)
                //     .then((value) {});A
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserDetailsScreen(
                      screen: 'MyScreen',
                    ),
                  ),
                ).then((value) {
                  UserViewModel().getUser().then((value) {
                    images = value?.profileImageUrl;
                    widget.getImage!(value?.profileImageUrl);
                    setState(() {});
                  });
                });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: '${widget.image}',
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                  errorWidget: (context, url, error) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://airjood.neuronsit.in/storage/profile_images/TOAeh3xMyzAz2SOjz2xYu7GvC2yePHMqoTKd3pWJ.png',
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
