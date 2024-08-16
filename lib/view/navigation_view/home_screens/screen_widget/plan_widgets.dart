import 'package:airjood/res/components/CustomText.dart';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/response/status.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/custom_shimmer.dart';
import '../../../../view_model/get_planning_list_view_model.dart';
import '../../../../view_model/user_view_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<GetPlanningListViewModel>(
      builder: (context, value, child) {
        switch (value.planningData.status) {
          case Status.LOADING:
            return const PlanningShimmer();
          case Status.ERROR:
            return Container();
          case Status.COMPLETED:
            return value.planningData.data == null ||
                    value.planningData.data!.data!.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Image(
                        image: AssetImage('assets/images/noData.png'),
                        height: 200,
                        width: 300,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.planningData.data?.data?.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data = value.planningData.data?.data?[index];
                      var invitationsLength =
                          data?.acceptedInvitations?.length ?? 0;
                      return Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
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
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(9),
                                    topLeft: Radius.circular(9),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: '${data?.imageUrl}',
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          CustomText(
                                            data: '${data?.title}',
                                            fontWeight: FontWeight.w700,
                                            fSize: 20,
                                          ),
                                          data?.acceptedInvitations == null ||
                                                  data!.acceptedInvitations!
                                                      .isEmpty
                                              ? const SizedBox()
                                              : AvatarStack(
                                                  height: 25,
                                                  width: 80,
                                                  settings:
                                                      RestrictedAmountPositions(
                                                    maxAmountItems: 6,
                                                    maxCoverage: 0.7,
                                                    minCoverage: 0.1,
                                                  ),
                                                  avatars: [
                                                    for (var n = 0;
                                                        n < invitationsLength;
                                                        n++)
                                                      CachedNetworkImageProvider(
                                                        '${data.acceptedInvitations?[n].user?.profileImageUrl}',
                                                        errorListener: (p0) {
                                                          const Icon(
                                                            CupertinoIcons
                                                                .person,
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
                                ),
                                data?.acceptedInvitations == null ||
                                        data!.acceptedInvitations!.isEmpty
                                    ? const SizedBox()
                                    : Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                                      child: Row(
                                        children: [
                                          for (var n = 0;
                                              n <
                                                  (invitationsLength > 3
                                                      ? 3
                                                      : invitationsLength);
                                              n++)
                                            CustomText(
                                              data:
                                                  '@${data.acceptedInvitations?[n].user?.name},',
                                              fontWeight: FontWeight.w400,
                                              fSize: 13,
                                              color: AppColors.greyTextColor,
                                            ),
                                          const SizedBox(width: 5),
                                          if (invitationsLength >= 3)
                                            const CustomText(
                                              data: '+ more ',
                                              fontWeight: FontWeight.w800,
                                              fSize: 14,
                                              color: AppColors.greyTextColor,
                                            ),
                                        ],
                                      ),
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
