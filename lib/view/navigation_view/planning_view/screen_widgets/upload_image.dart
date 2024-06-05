import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';

class UploadImage extends StatefulWidget {
  final String name;
  final Function? onValue;
  const UploadImage({super.key, this.onValue, required this.name});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _image;

  Future<void> _getImageFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        widget.onValue!(_image);
        Navigator.pop(context);
      });
    }
  }

  Future<void> _getImageFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        widget.onValue!(_image);
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                height: 55,
                width: 55,
              ),
              const SizedBox(height: 10),
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
          padding: const EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              _image!,
              height: 140,
              width: 300,
              fit: BoxFit.cover,
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
