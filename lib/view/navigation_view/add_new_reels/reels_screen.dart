// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:airjood/view/navigation_view/add_new_reels/sub_view/upload_image_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';
import '../../../res/components/upload_button.dart';
import '../../../view_model/user_view_model.dart';
import '../home_screens/sub_home_screens/user_details_screen.dart';

class ReelsScreen extends StatefulWidget {
  final Function? getImage;
  const ReelsScreen({super.key, this.getImage});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  static const int maxFileSize = 16 * 1024 * 1024; // 200 MB in bytes
  bool _isLoading = false;
  Future<void> _getImageFromCamera(String screen) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickVideo(source: ImageSource.camera);

      if (pickedFile != null) {
        final File videoFile = File(pickedFile.path);
        if (await videoFile.length() > maxFileSize) {
          _showFileSizeError();
          setState(() {
            _isLoading = false;
          });
          return;
        }
        String localPath = await _findLocalPath();
        String thumbnailPath =
            '$localPath${Platform.pathSeparator}thumbnail.png';

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
    } finally {
      setState(() {
        _isLoading = false;
      });
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
      setState(() {
        _isLoading = true;
      });
      final picker = ImagePicker();
      final XFile? pickedFile;
      if (Platform.isIOS) {
        pickedFile = await picker.pickMedia();
      } else {
        pickedFile = await picker.pickVideo(source: ImageSource.gallery);
      }
      if (pickedFile != null) {
        final File videoFile = File(pickedFile.path);
        if (await videoFile.length() > maxFileSize) {
          _showFileSizeError();
          setState(() {
            _isLoading = false;
          });
          return;
        }

        String localPath = await _findLocalPath();
        String thumbnailPath =
            '$localPath${Platform.pathSeparator}thumbnail.png';

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
                file: pickedFile!,
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
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showFileSizeError() {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const CustomText(
            data: 'File Size Error',
            color: AppColors.blackColor,
            fontWeight: FontWeight.w800,
            fSize: 18,
          ),
          content: const CustomText(
            data: 'Please select a video file smaller than 16 MB.',
            color: AppColors.blackColor,
            fontWeight: FontWeight.w400,
            fSize: 14,
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColor,
                ),
                CustomText(
                  data: 'You can create latqa fom below options',
                  fSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor,
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {
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
                  imageUrl: '$image',
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                  errorWidget: (context, url, error) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://i.pinimg.com/736x/44/4f/66/444f66853decdc7f052868bf357a0826.jpg',
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
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Column(
          children: [
            _isLoading
                ? const Center(
                    child: LinearProgressIndicator(
                      color: AppColors.mainColor,
                      minHeight: 2,
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
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
                    height: 40,
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
          ],
        ),
      ),
    );
  }
}
