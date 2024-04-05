import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../res/components/color.dart';

class DrawerCamera extends StatefulWidget {
  final String? image;
  final Function onValue;
  const DrawerCamera({super.key, this.image, required this.onValue});

  @override
  State<DrawerCamera> createState() => _DrawerCameraState();
}

class _DrawerCameraState extends State<DrawerCamera> {
  File? _image;

  Future<void> _getImageFromCamera() async {
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

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        widget.onValue(_image);
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.blueShadeColor),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _image == null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: widget.image ??
                          'https://airjood.neuronsit.in/storage/reels/gcQ5z3MmXbsLfWqcihMg0bXZYNU3Zurlki1Y8lyK.jpg',
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                      errorWidget: (context, url, error) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://airjood.neuronsit.in/storage/profile_images/TOAeh3xMyzAz2SOjz2xYu7GvC2yePHMqoTKd3pWJ.png',
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
                          ),
                        );
                      },
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.file(
                      _image!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
          ),
          InkWell(
            onTap: () {
              _showImagePickerBottomSheet(context);
            },
            child: const CircleAvatar(
              backgroundColor: AppColors.blueShadeColor,
              radius: 15,
              child: Icon(
                Icons.photo_camera,
                color: AppColors.whiteTextColor,
                size: 18,
              ),
            ),
          )
        ],
      ),
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
                    _getImageFromCamera();
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
                  leading: const Icon(
                      CupertinoIcons.photo_fill_on_rectangle_fill,
                      color: AppColors.whiteTextColor),
                  title: const Text(
                    'Gallery',
                    style: TextStyle(color: AppColors.whiteTextColor),
                  ),
                  onTap: () {
                    _getImageFromGallery();
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
