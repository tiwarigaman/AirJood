import 'package:airjood/view/navigation_view/home_screens/component/custom_tab.dart';
import 'package:flutter/material.dart';

import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';

class InviteScreen extends StatefulWidget {
  final int planId;
  const InviteScreen({super.key, required this.planId});

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        actions: [
          const SizedBox(width: 5),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 35,
              weight: 2,
            ),
          ),
          const SizedBox(width: 10),
          const CustomText(
            data: 'Invite users in your plan',
            fSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
          const Spacer(),
        ],
      ),
      body: CustomTabBar(
        planId: widget.planId,
      ),
    );
  }
}
