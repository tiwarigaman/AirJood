// ignore_for_file: use_build_context_synchronously

import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/res/components/color.dart';
import 'package:airjood/res/components/upload_button.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../model/reels_model.dart';
import '../../../../../view_model/get_reels_view_model.dart';
import '../../../../../view_model/user_view_model.dart';
import '../../../add_new_reels/sub_view/upload_image_screen.dart';
import '../../screen_widget/select_laqta_reels.dart';
import 'dart:io';

class AddExperienceStep1 extends StatefulWidget {
  final Function? onLaqtaTap;
  final Function? onCameraTap;
  final Function? onVideoTap;
  const AddExperienceStep1(
      {super.key, this.onLaqtaTap, this.onCameraTap, this.onVideoTap});

  @override
  State<AddExperienceStep1> createState() => _AddExperienceStep1State();
}

class _AddExperienceStep1State extends State<AddExperienceStep1> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  int currentPage = 0;
  Future<void> fetchData() async {
    UserViewModel().getToken().then((value) async {
      final reelsProvider = Provider.of<ReelsViewModel>(context, listen: false);
      await reelsProvider.reelsGetApi(value!, currentPage);
      reelsProvider.reelsData.data?.data?.data?.forEach((element) {
        data.add(element);
      });
    });
  }

  List<ReelsData> data = [];
  Future<void> getImageFromCamera() async {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickVideo(source: ImageSource.camera);

      if (pickedFile != null) {
        String localPath = await findLocalPath();
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
              ),
            ),
          ).then((value) {
            widget.onCameraTap!({
              'id': value['id'],
              'video_url': value['video_url'],
              'video_thumbnail_url': value['video_thumbnail_url']
            });
          });
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

  Future<String> findLocalPath() async {
    final directory = Platform.isAndroid
        ? await (getExternalStorageDirectory())
        : await getApplicationDocumentsDirectory();
    return directory!.path;
  }

  Future<void> getImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickVideo(source: ImageSource.gallery);

      if (pickedFile != null) {
        String localPath = await findLocalPath();
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
              ),
            ),
          ).then((value) {
            widget.onVideoTap!({
              'id': value['id'],
              'video_url': value['video_url'],
              'video_thumbnail_url': value['video_thumbnail_url']
            });
          });
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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CustomText(
              data: 'Add Latqa',
              color: AppColors.blackTextColor,
              fSize: 22,
              fontWeight: FontWeight.w700,
            ),
            const CustomText(
              data: 'You can create latqa fom below options',
              color: AppColors.secondTextColor,
              fSize: 12,
              fontWeight: FontWeight.w300,
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                getImageFromGallery();
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
                getImageFromCamera();
              },
              child: const UploadButton(
                name: 'assets/icons/uploadCamera.png',
                title: 'Open Camera',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  constraints: BoxConstraints.loose(
                    Size(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height * 0.85),
                  ),
                  isScrollControlled: true,
                  builder: (_) => SelectLaqtaReels(
                    item: data,
                    onTap: widget.onLaqtaTap,
                  ),
                );
              },
              child: const UploadButton(
                name: 'assets/icons/uploadLaqta.png',
                title: 'Upload From Laqta',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
