import 'package:flutter/material.dart';

import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../component/read_more_text.dart';

class ContentDetailsWidget extends StatefulWidget {
  final String? name;
  final String? discription;
  final String? location;
  const ContentDetailsWidget(
      {super.key, this.name, this.discription, this.location});

  @override
  State<ContentDetailsWidget> createState() => _ContentDetailsWidgetState();
}

class _ContentDetailsWidgetState extends State<ContentDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/dotline.png',
          height: 110,
          width: 10,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                data: widget.name ?? "AL khayma Camp",
                fontWeight: FontWeight.w700,
                fSize: 18,
                color: AppColors.blackTextColor,
              ),
              const SizedBox(
                height: 4,
              ),
              CustomText(
                data: widget.location ?? "9 Al Khayma Camp, Dubai, UAE",
                fontWeight: FontWeight.w600,
                fSize: 14,
                color: AppColors.greyTextColor,
              ),
              const SizedBox(
                height: 6,
              ),
              SizedBox(
                //width: MediaQuery.of(context).size.width / 1.2,
                child: CustomReadMoreText(
                  content: widget.discription ??
                      'Lorem ipsum dolor sit amet consectetur. Enim justo tellus odio vitae ullamcorper adipiscing est. Phasellus proin non orci consectetur Id sit letus morbi null a Tristique',
                  color: AppColors.secondTextColor,
                  mColor: AppColors.mainColor,
                  rColor: AppColors.mainColor,
                  trimLines: 3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
