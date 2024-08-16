import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/res/components/color.dart';
import 'package:airjood/res/components/custom_shimmer.dart';
import 'package:airjood/view/navigation_view/planning_view/Add_planning_screen.dart';
import 'package:airjood/view/navigation_view/planning_view/screen_widgets/listContainer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../data/response/status.dart';
import '../../../view_model/get_planning_list_view_model.dart';
import '../../../view_model/user_view_model.dart';

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({super.key});

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        actions: [
          const SizedBox(width: 20),
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                data: 'My Planning',
                fSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
              CustomText(
                data: 'Create a plan & add or schedule plan from Laqta.',
                fSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.greyTextColor,
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPlanningScreen(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.blueBGShadeColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  const Icon(Icons.add, color: AppColors.blueColor, size: 26),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPlanningList,
        child: SingleChildScrollView(
          child: Consumer<GetPlanningListViewModel>(
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
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 80),
                    child: value.planningData.data == null ||
                            value.planningData.data!.data!.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 200),
                                Image.asset(
                                  'assets/images/rejected.png',
                                  height: 70,
                                  width: 70,
                                ),
                                const SizedBox(height: 10),
                                const CustomText(
                                  data: 'Not found',
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.blueColor,
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
                                        child:
                                        const Icon(Icons.add, color: AppColors.blueColor, size: 20),
                                      ),
                                      const SizedBox(width: 5),
                                      const CustomText(
                                        data: 'Add Plan',
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.blueColor,
                                        fSize: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: value.planningData.data?.data?.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var data = value.planningData.data?.data?[index];
                              String formattedStartDate =
                                  formatDateString(data?.startDate?.toString());
                              String formattedEndDate =
                                  formatDateString(data?.endDate?.toString());
                              return ListContainer(
                                id: data?.id,
                                imageUrl: data?.imageUrl,
                                duration: data?.planDuration.toString(),
                                location: data?.stateName != null
                                    ? '${data?.countryName} , ${data?.stateName}'
                                    : '${data?.countryName}',
                                planningName: data?.title,
                                startDate: formattedStartDate,
                                endDate: formattedEndDate,
                              );
                            },
                          ),
                  );
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
