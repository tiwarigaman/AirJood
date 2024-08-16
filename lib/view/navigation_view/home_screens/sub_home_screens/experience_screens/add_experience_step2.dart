import 'dart:io';
import 'dart:ui';
import 'package:airjood/res/components/mainbutton.dart';
import 'package:airjood/utils/utils.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../model/reels_model.dart';
import '../../../../../res/components/color.dart';
import '../../../../../res/components/maintextfild.dart';
import '../../../../../res/components/upload_button.dart';
import '../../../../../view_model/get_reels_view_model.dart';
import '../../../../../view_model/user_view_model.dart';
import '../../../add_new_reels/sub_view/upload_image_screen.dart';
import '../../screen_widget/select_laqta_reels.dart';

class Laqta {
  final int reelsId;
  final String thumbnailUrl;
  final String videoUrl;

  Laqta({required this.reelsId,required this.thumbnailUrl, required this.videoUrl});
}

class AddExperienceStep2 extends StatefulWidget {
  final int? id;
  final String? image;
  final String? video;
  final Function? onNextTap;
  const AddExperienceStep2({
    super.key,
    this.id,
    this.image,
    this.video,
    this.onNextTap,
  });

  @override
  State<AddExperienceStep2> createState() => _AddExperienceStep2State();
}

class _AddExperienceStep2State extends State<AddExperienceStep2> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

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
  List<Laqta> laqtaList = [];

  void addLaqta(int reelsId , String thumbnailUrl, String videoUrl) {
    setState(() {
      laqtaList.add(Laqta(reelsId : reelsId,thumbnailUrl: thumbnailUrl, videoUrl: videoUrl));
    });
  }

  void removeLaqta(int index) {
    setState(() {
      laqtaList.removeAt(index);
    });
  }

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
            addLaqta(value['id'],'${value['video_thumbnail_url']}',
                '${value['video_url']}');
            Navigator.pop(context);
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
            addLaqta(value['id'],'${value['video_thumbnail_url']}',
                '${value['video_url']}');
            Navigator.pop(context);
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
      child: Column(
        children: [
          SizedBox(
            height: 370,
            child: PageView.builder(
              controller: pageController,
              itemCount: laqtaList.length + 1, // +1 for the initial image
              physics: const BouncingScrollPhysics(),
              scrollBehavior: const ScrollBehavior(),
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                if (index == 0) {
                  return buildInitialImage();
                } else {
                  return buildLaqtaPage(index - 1);
                }
              },
            ),
          ),
          buildPageIndicator(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: MainTextFild(
              controller: nameController,
              labelText: "Enter Activity Name",
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: MainTextFild(
              controller: contentController,
              labelText: "Write a Description...",
              maxLines: 4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (laqtaList.length >= 5) {
                        Utils.toastMessage('You can select up to 6 Laqta');
                      } else {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          constraints: BoxConstraints.loose(
                            Size(MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height * 0.85),
                          ),
                          isScrollControlled: true,
                          isDismissible: true,
                          builder: (_) => Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    getImageFromGallery();
                                  },
                                  child: const UploadButton(
                                    name: 'assets/icons/videoupload.png',
                                    title: 'Upload Video',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    getImageFromCamera();
                                  },
                                  child: const UploadButton(
                                    name: 'assets/icons/uploadCamera.png',
                                    title: 'Open Camera',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      constraints: BoxConstraints.loose(
                                        Size(
                                            MediaQuery.of(context).size.width,
                                            MediaQuery.of(context).size.height *
                                                0.85),
                                      ),
                                      isScrollControlled: true,
                                      builder: (_) => SelectLaqtaReels(
                                        item: data,
                                        onTap: (ReelsData val) {
                                          addLaqta(val.id!.toInt(),'${val.videoThumbnailUrl}',
                                              '${val.videoUrl}');
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
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
                    },
                    child: const MainButton(
                      data: 'Add Laqta',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (nameController.text.isEmpty) {
                        Utils.toastMessage('Please Enter Activity Name');
                      } else if (contentController.text.isEmpty) {
                        Utils.toastMessage('Please Enter Description');
                      } else {
                        widget.onNextTap!({
                          'reels' : laqtaList,
                          'name': nameController.text,
                          'description': contentController.text
                        });
                      }
                    },
                    child: const MainButton(
                      data: 'Next',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInitialImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              '${widget.image}',
              width: MediaQuery.of(context).size.width,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                        color: AppColors.mainColor,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                }
              },
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 120.0, sigmaY: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 2,
                child: Image.network(
                  '${widget.image}',
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                            color: AppColors.mainColor,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLaqtaPage(int index) {
    final laqta = laqtaList[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              laqta.thumbnailUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 120.0, sigmaY: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 2,
                child: Image.network(
                  laqta.thumbnailUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 1,
            child: IconButton(
              icon: const Icon(
                Icons.cancel,
                color: AppColors.mainColor,
                size: 25,
              ),
              onPressed: () {
                removeLaqta(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        laqtaList.length + 1, // +1 for the initial image
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == index ? AppColors.mainColor : Colors.grey,
          ),
        ),
      ),
    );
  }
}
