import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/res/components/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListContainerWidget extends StatefulWidget {
  final String? coverImage;
  final String? profileImage;
  final String? title;
  final int? member;

  const ListContainerWidget(
      {super.key, this.coverImage, this.profileImage, this.title, this.member});

  @override
  State<ListContainerWidget> createState() => _ListContainerWidgetState();
}

class _ListContainerWidgetState extends State<ListContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.textFildBorderColor,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: '${widget.profileImage}',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    margin: const EdgeInsets.only(left: 10, bottom: 15),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: AppColors.greenColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: '${widget.coverImage}',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 250,
                        child: CustomText(
                          data: '${widget.title}',
                          fSize: 17,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackTextColor,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                       CustomText(
                        data: '${widget.member} Members',
                        fSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondTextColor,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
