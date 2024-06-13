import 'dart:ui';

import 'package:airjood/res/components/mainbutton.dart';
import 'package:airjood/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../../../res/components/color.dart';
import '../../../../../res/components/maintextfild.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 350,
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
                            // Image is fully loaded
                            return child;
                          } else {
                            // Show a loading indicator while the image is loading
                            return Center(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
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
                          color: Colors
                              .transparent, // Make the container transparent
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 25),
                      child: Align(
                        alignment: AlignmentDirectional.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 2,
                            child: Image.network(
                              '${widget.image}',
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  // Image is fully loaded
                                  return child;
                                } else {
                                  // Show a loading indicator while the image is loading
                                  return Center(
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
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
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MainTextFild(
                controller: nameController,
                labelText: "Enter Activity Name",
                maxLines: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              MainTextFild(
                controller: contentController,
                labelText: "Write a Description...",
                maxLines: 4,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  if (nameController.text.isEmpty) {
                    Utils.toastMessage('Please Enter Activity Name');
                  } else if (contentController.text.isEmpty) {
                    Utils.toastMessage('Please Enter Description');
                  } else {
                    widget.onNextTap!({
                      'name': nameController.text,
                      'description': contentController.text
                    });
                  }
                },
                child: const MainButton(
                  data: 'Next ',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
