// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:airjood/view/navigation_view/add_new_reels/sub_view/upload_image_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';
import '../../../res/components/upload_button.dart';
import '../../../utils/routes/routes_name.dart';
import '../../../view_model/user_view_model.dart';
import '../home_screens/component/login_user.dart';

class ReelsScreen extends StatefulWidget {
  final Function? getImage;
  const ReelsScreen({super.key, this.getImage});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  Future<void> _getImageFromCamera(String screen) async {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickVideo(source: ImageSource.camera);

      if (pickedFile != null) {
        String localPath = await _findLocalPath();
        String thumbnailPath =
            '$localPath${Platform.pathSeparator}thumbnail.png';

        // Delete existing thumbnail if it exists
        File existingThumbnail = File(thumbnailPath);
        if (await existingThumbnail.exists()) {
          await existingThumbnail.delete();
        }

        final session = await FFmpegKit.execute(
          '-i "${pickedFile.path}" -y -ss 00:00:01.000 -vframes 1 "$thumbnailPath"',
        );

        final returnCode = await session.getReturnCode();

        if (ReturnCode.isSuccess(returnCode)) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadImageScreen(
                file: pickedFile,
                thumbNail: thumbnailPath,
                screen: screen,
              ),
            ),
          );
        } else if (ReturnCode.isCancel(returnCode)) {
          // Handle cancellation
        } else {
          // Handle other failure cases
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  Future<String> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await (getExternalStorageDirectory())
        : await getApplicationDocumentsDirectory();
    return directory!.path;
  }

  Future<void> _getImageFromGallery(String screen) async {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickVideo(source: ImageSource.gallery);

      if (pickedFile != null) {
        String localPath = await _findLocalPath();
        String thumbnailPath =
            '$localPath${Platform.pathSeparator}thumbnail.png';

        // Delete existing thumbnail if it exists
        File existingThumbnail = File(thumbnailPath);
        if (await existingThumbnail.exists()) {
          await existingThumbnail.delete();
        }

        final session = await FFmpegKit.execute(
          '-i "${pickedFile.path}" -y -ss 00:00:01.000 -vframes 1 "$thumbnailPath"',
        );

        final returnCode = await session.getReturnCode();
        if (ReturnCode.isSuccess(returnCode)) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadImageScreen(
                file: pickedFile,
                thumbNail: thumbnailPath,
                screen: screen,
              ),
            ),
          );
        } else if (ReturnCode.isCancel(returnCode)) {
          // Handle cancellation
        } else {
          // Handle other failure cases
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    UserViewModel().getUser().then((value) {
      image = value?.profileImageUrl;
      setState(() {});
    });
  }

  String? image;
  String? images;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.whiteColor,
          actions: [
            const SizedBox(
              width: 20,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  data: 'Laqta',
                  fSize: 22,
                  fweight: FontWeight.w700,
                  fontColor: AppColors.blackColor,
                ),
                CustomText(
                  data: 'You can create latqa fom below options',
                  fSize: 12,
                  fweight: FontWeight.w400,
                  fontColor: AppColors.blackColor,
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.userDetail)
                    .then((value) {
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
                  imageUrl: '$image',
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
            /*CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(
                'assets/images/personbig.png',
              ),
            ),*/
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 130,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/image1.png',
                            height: 110,
                            width: 80,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/image1.png',
                            height: 110,
                            width: 80,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/image1.png',
                            height: 110,
                            width: 80,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/image1.png',
                            height: 110,
                            width: 80,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  _getImageFromGallery('Laqta');
                },
                child: const UploadButton(
                  name: 'assets/icons/videoupload.png',
                  title: 'Upload Video',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  _getImageFromCamera('Laqta');
                },
                child: const UploadButton(
                  name: 'assets/icons/uploadCamera.png',
                  title: 'Open Camera',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
