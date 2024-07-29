import 'package:airjood/view/navigation_view/community_view/add_community_screen.dart';
import 'package:airjood/view/navigation_view/community_view/community_details_screen.dart';
import 'package:airjood/view/navigation_view/community_view/widgets/list_container_widget.dart';
import 'package:airjood/view_model/get_community_list_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/response/status.dart';
import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';
import '../../../res/components/custom_shimmer.dart';
import '../../../res/components/maintextfild.dart';
import '../../../view_model/user_view_model.dart';
import '../home_screens/sub_home_screens/user_details_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  void initState() {
    super.initState();
    UserViewModel().getUser().then((value) {
      image = value?.profileImageUrl;
      setState(() {});
    });
    _refreshPlanningList();
  }

  Future<void> _refreshPlanningList() async {
    UserViewModel().getToken().then((value) {
      Provider.of<GetCommunityListViewModel>(context, listen: false)
          .communityListGetApi(value!, '');
    });
  }

  String? image;
  String? images;
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height * 0.90,
                width: MediaQuery.of(context).size.width),
            isScrollControlled: true,
            builder: (_) => const AddCommunityScreen(),
          );
        },
        child: Container(
          height: 56,
          width: 56,
          margin: const EdgeInsets.only(bottom: 60),
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(
            Icons.add,
            color: AppColors.whiteColor,
            size: 30,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        actions: [
          const SizedBox(
            width: 20,
          ),
          const CustomText(
            data: 'Community',
            fSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserDetailsScreen(
                    screen: 'MyScreen',
                  ),
                ),
              ).then((value) {
                UserViewModel().getUser().then((value) {
                  images = value?.profileImageUrl;
                  // widget.getImage!(value?.profileImageUrl);
                  setState(() {});
                });
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: '$image',
                fit: BoxFit.cover,
                height: 40,
                width: 40,
                errorWidget: (context, url, error) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://i.pinimg.com/736x/44/4f/66/444f66853decdc7f052868bf357a0826.jpg',
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              MainTextFild(
                controller: searchController,
                hintText: 'Search Community...',
                maxLines: 1,
                prefixIcon: const Icon(
                  Icons.search_sharp,
                  color: AppColors.textFildHintColor,
                ),
                onChanged: (values) {
                  if (values.length == 3 || values.isEmpty) {
                    UserViewModel().getToken().then((value) {
                      Provider.of<GetCommunityListViewModel>(context, listen: false)
                          .communityListGetApi(value!, values);
                    });
                  }
                },
                onFieldSubmitted: (values) {
                  UserViewModel().getToken().then((value) {
                    Provider.of<GetCommunityListViewModel>(context, listen: false)
                        .communityListGetApi(value!, values);
                  });
                },
              ),
              const SizedBox(height: 10),
              RefreshIndicator(
                onRefresh: _refreshPlanningList,
                child: Consumer<GetCommunityListViewModel>(
                  builder: (context, value, child) {
                    switch (value.communityData.status) {
                      case Status.LOADING:
                        return const PlanningShimmer();
                      case Status.ERROR:
                        return Container();
                      case Status.COMPLETED:
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 80),
                          child: value.communityData.data == null ||
                                  value.communityData.data!.data!.data!.isEmpty
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
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.blueColor,
                                        fSize: 18,
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: value.communityData.data!.data!.data?.length,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var community = value.communityData.data!.data!.data?[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CommunityDetailsScreen(
                                                  communityId: community?.id,
                                                ),
                                          ),
                                        );
                                      },
                                      child: ListContainerWidget(
                                        title: community?.name,
                                        member: community?.memberCount,
                                        coverImage: community?.coverImage,
                                        profileImage: community?.profileImage,
                                      ),
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
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
