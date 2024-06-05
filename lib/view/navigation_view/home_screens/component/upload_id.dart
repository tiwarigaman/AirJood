import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import 'package:file_picker/file_picker.dart';

class UploadId extends StatefulWidget {
  final String name;
  final Function onValue;
  const UploadId({super.key, required this.onValue, required this.name});

  @override
  State<UploadId> createState() => _UploadIdState();
}

class _UploadIdState extends State<UploadId> {
  File? _image;

  Future<void> _getImageFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        widget.onValue(_image);
        Navigator.pop(context);
      });
    }
  }

  Future<void> _getImageFromGallery(BuildContext context) async {
    //final picker = ImagePicker();
    final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      setState(() {
        _image = File('${pickedFile.files.single.path}');
        widget.onValue(_image);
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String fileName = basename('$_image');
    String cleanedFileName = fileName.replaceAll("'", '');
    String displayedFileName = cleanedFileName.length > 15
        ? '${cleanedFileName.substring(0, 15)}...'
        : cleanedFileName;
    String fileExtension =
        cleanedFileName.length > 15 ? cleanedFileName.split('.').last : '';
    String displayedFileNameWithExtension =
        displayedFileName + (fileExtension.isNotEmpty ? '.$fileExtension' : '');
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset('assets/images/document_upload.png'),
        _image == null
            ? InkWell(
                onTap: () {
                  _showImagePickerBottomSheet(context);
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/upload.png',
                      height: 50,
                      width: 50,
                    ),
                     CustomText(
                      data: widget.name,
                      fSize: 14,
                      fweight: FontWeight.w400,
                      fontColor: AppColors.greyTextColor,
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.textFildBorderColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(CupertinoIcons.doc_fill),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            displayedFileNameWithExtension,
                            overflow: TextOverflow.ellipsis,
                          ),
                          IconButton(
                            onPressed: () {
                              _image = null;
                              setState(() {});
                            },
                            icon: const Icon(
                              CupertinoIcons.clear_fill,
                              color: AppColors.mainColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  void _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(CupertinoIcons.camera_on_rectangle_fill,
                      color: AppColors.whiteTextColor),
                  title: const Text(
                    'Camera',
                    style: TextStyle(color: AppColors.whiteTextColor),
                  ),
                  onTap: () {
                    _getImageFromCamera(context);
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(CupertinoIcons.cloud_upload_fill,
                      color: AppColors.whiteTextColor),
                  title: const Text(
                    'Upload',
                    style: TextStyle(color: AppColors.whiteTextColor),
                  ),
                  onTap: () {
                    _getImageFromGallery(context);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
