import 'package:airjood/model/planning_details_model.dart';
import 'package:airjood/view/navigation_view/planning_view/edit_planning_screen.dart';
import 'package:airjood/view/navigation_view/planning_view/invite_screen.dart';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';

class PlanContainer extends StatefulWidget {
  final int planId;
  final String? imageUrl;
  final String screen;
  final String? title;
  final String? location;
  final String? date;
  final String? startDate;
  final String? endDate;
  final String? duration;
  final String? country;
  final String? state;
  final List<Invitation>? invitation;
  const PlanContainer(
      {super.key,
      required this.screen,
      this.title,
      this.location,
      this.date,
      required this.planId,
      this.startDate,
      this.endDate,
      this.duration,
      this.country,
      this.state,
      this.imageUrl,
      this.invitation});

  @override
  State<PlanContainer> createState() => _PlanContainerState();
}

class _PlanContainerState extends State<PlanContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: BoxDecoration(
        color: AppColors.blueShade,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                CustomText(
                  data: widget.title ?? 'Plan Title Name Here',
                  fontWeight: FontWeight.w700,
                  fSize: 16,
                  color: AppColors.blackTextColor,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPlanningScreen(
                          planId: widget.planId,
                          imageUrl: widget.imageUrl,
                          title: widget.title,
                          endDate: widget.endDate,
                          startDate: widget.startDate,
                          country: widget.country,
                          state: widget.state,
                          duration: widget.duration,
                        ),
                      ),
                    );
                  },
                  child: SvgPicture.asset('assets/svg/editIcon.svg'),
                ),
                const SizedBox(width: 15),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.textFildHintColor,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomText(
                    data: widget.location ?? 'Mumbai, Maharastra',
                    fontWeight: FontWeight.w400,
                    fSize: 15,
                    color: AppColors.greyTextColor,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.calendar_month_sharp,
                  color: AppColors.textFildHintColor,
                  size: 16,
                ),
                const SizedBox(width: 10),
                CustomText(
                  data: widget.date ?? '25th Jan 2023 - 30th Jan 2023 (5 Days)',
                  fontWeight: FontWeight.w400,
                  fSize: 14,
                  color: AppColors.greyTextColor,
                ),
              ],
            ),
            const SizedBox(height: 10),
            widget.invitation!.isEmpty && widget.screen == 'planScreen'
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AvatarStack(
                        height: 25,
                        width: 80,
                        settings: RestrictedAmountPositions(
                          maxAmountItems: 6,
                          maxCoverage: 0.7,
                          minCoverage: 0.1,
                        ),
                        avatars: [
                          for (var n = 0; n < widget.invitation!.length; n++)
                            CachedNetworkImageProvider(
                              '${widget.invitation?[n].user?.profileImageUrl}',
                              errorListener: (p0) {
                                const Icon(CupertinoIcons.person);
                              },
                            ),
                        ],
                      ),
                      if (widget.screen != 'planScreen')
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InviteScreen(
                                  planId: widget.planId,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const CustomText(
                              data: 'Invite',
                              fontWeight: FontWeight.w600,
                              fSize: 15,
                              color: AppColors.whiteTextColor,
                            ),
                          ),
                        )
                    ],
                  ),
            widget.invitation!.isEmpty
                ? const SizedBox()
                : const SizedBox(height: 10),
            widget.invitation!.isEmpty
                ? const SizedBox()
                : Row(
                    children: [
                      for (var n = 0;
                          n <
                              (widget.invitation!.length > 3
                                  ? 3
                                  : widget.invitation!.length);
                          n++)
                        CustomText(
                          data: '@${widget.invitation?[n].user?.name},',
                          fontWeight: FontWeight.w400,
                          fSize: 13,
                          color: AppColors.greyTextColor,
                        ),
                      const SizedBox(width: 5),
                      if (widget.invitation!.length >= 3)
                        const CustomText(
                          data: '+ more ',
                          fontWeight: FontWeight.w800,
                          fSize: 14,
                          color: AppColors.greyTextColor,
                        ),
                    ],
                  ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
