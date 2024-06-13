import 'package:airjood/res/components/CustomText.dart';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../data/response/status.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/custom_shimmer.dart';
import '../../../../view_model/get_planning_list_view_model.dart';
import '../../../../view_model/user_view_model.dart';
import '../../planning_view/Add_planning_screen.dart';
import '../../planning_view/planning_details_screen.dart';

class PlanWidgets extends StatefulWidget {
  const PlanWidgets({super.key});

  @override
  State<PlanWidgets> createState() => _PlanWidgetsState();
}

class _PlanWidgetsState extends State<PlanWidgets> {
  @override
  void initState() {
    super.initState();
    _refreshPlanningList();
  }

  Future<void> _refreshPlanningList() async {
    UserViewModel().getToken().then((value) {
      Provider.of<GetPlanningListViewModel>(context, listen: false)
          .planningListGetApi(value!);
    });
  }

  String formatDateString(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return '';
    }
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(parsedDate);
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetPlanningListViewModel>(
      builder: (context, value, child) {
        switch (value.planningData.status) {
          case Status.LOADING:
            return const Padding(
              padding: EdgeInsets.all(20),
              child: PlanningShimmer(),
            );
          case Status.ERROR:
            return Container();
          case Status.COMPLETED:
            return value.planningData.data == null ||
                    value.planningData.data!.data!.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/rejected.png',
                          height: 70,
                          width: 70,
                        ),
                        const SizedBox(height: 10),
                        const CustomText(
                          data: 'Not found',
                          fweight: FontWeight.w700,
                          fontColor: AppColors.blueColor,
                          fSize: 18,
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddPlanningScreen(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColors.blueBGShadeColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.add,
                                    color: AppColors.blueColor, size: 20),
                              ),
                              const SizedBox(width: 5),
                              const CustomText(
                                data: 'Add Plan',
                                fweight: FontWeight.w700,
                                fontColor: AppColors.blueColor,
                                fSize: 18,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.planningData.data?.data?.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data = value.planningData.data?.data?[index];
                      var invitationsLength = data?.invitations?.length ?? 0;
                      return Padding(
                        padding: const EdgeInsets.only(top: 5,bottom: 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlanningDetailsScreen(
                                  id: data?.id,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 2,
                                color: AppColors.textFildBorderColor,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: '${data?.imageUrl}',
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          data: '${data?.title}',
                                          fweight: FontWeight.w700,
                                          fSize: 20,
                                        ),
                                        const SizedBox(height: 5),
                                        data?.invitations == null
                                            ? const SizedBox()
                                            : AvatarStack(
                                                height: 25,
                                                width: 80,
                                                settings: RestrictedAmountPositions(
                                                  maxAmountItems: 6,
                                                  maxCoverage: 0.7,
                                                  minCoverage: 0.1,
                                                ),
                                                avatars: [
                                                  for (var n = 0;
                                                      n < invitationsLength;
                                                      n++)
                                                    CachedNetworkImageProvider(
                                                      '${data?.invitations?[n].user?.profileImageUrl}',
                                                      errorListener: (p0) {
                                                        const Icon(
                                                          CupertinoIcons.person,
                                                        );
                                                      },
                                                    ),
                                                ],
                                              ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Image.asset(
                                      'assets/images/rightconta.png',
                                      height: 40,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                data?.invitations == null
                                    ? const SizedBox()
                                    : Row(
                                        children: [
                                          for (var n = 0;
                                              n <
                                                  (invitationsLength > 3
                                                      ? 3
                                                      : invitationsLength);
                                              n++)
                                            CustomText(
                                              data:
                                                  '@${data?.invitations?[n].user?.name},',
                                              fweight: FontWeight.w400,
                                              fSize: 13,
                                              fontColor: AppColors.greyTextColor,
                                            ),
                                          const SizedBox(width: 5),
                                          if (invitationsLength >= 3)
                                            const CustomText(
                                              data: '+ more ',
                                              fweight: FontWeight.w800,
                                              fSize: 14,
                                              fontColor: AppColors.greyTextColor,
                                            ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          default:
            return Container();
        }
      },
    );
  }
}
