import 'dart:io';

import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/res/components/color.dart';
import 'package:airjood/utils/utils.dart';
import 'package:airjood/view/navigation_view/community_view/widgets/inquiry_comment_widget.dart';
import 'package:airjood/view/navigation_view/community_view/widgets/stack_container_widget.dart';
import 'package:airjood/view/navigation_view/home_screens/component/read_more_text.dart';
import 'package:airjood/view_model/add_community_comment_view_model.dart';
import 'package:airjood/view_model/get_community_comment_view_model.dart';
import 'package:airjood/view_model/get_community_details_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../data/response/status.dart';
import '../../../res/components/custom_shimmer.dart';
import '../../../view_model/user_view_model.dart';
import '../home_screens/screen_widget/radio_widget.dart';

class CommunityDetailsScreen extends StatefulWidget {
  final int? communityId;
  const CommunityDetailsScreen({super.key, this.communityId});

  @override
  State<CommunityDetailsScreen> createState() => _CommunityDetailsScreenState();
}

class _CommunityDetailsScreenState extends State<CommunityDetailsScreen> {
  @override
  void initState() {
    super.initState();
    fetchExperianceData();
  }

  Future<void> fetchExperianceData() async {
    UserViewModel().getToken().then((value) async {
      Provider.of<GetCommunityDetailsViewModel>(context, listen: false)
          .getCommunityDetailsApi(value!, widget.communityId!);
      Provider.of<GetCommunityCommentViewModel>(context, listen: false)
          .communityCommentGetApi(value, widget.communityId!);
      token = value;
      setState(() {});
    });
  }

  String? token;
  File? attachment;
  File? attachmentName;
  String selectedValue = 'person';
  final TextEditingController commentController = TextEditingController();

  Future<void> _getStorage(BuildContext context) async {
    final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      setState(() {
        attachment = File('${pickedFile.files.single.path}');
        attachmentName = File(pickedFile.files.single.name);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final addCommunityComment =
        Provider.of<AddCommunityCommentViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 00,
      ),
      body: Column(
        children: [
          Consumer<GetCommunityDetailsViewModel>(
            builder: (context, value, child) {
              switch (value.getCommunityDetailsData.status) {
                case Status.LOADING:
                  return const SafeArea(child: ShimmerScreen());
                case Status.ERROR:
                  return Container();
                case Status.COMPLETED:
                  var community = value.getCommunityDetailsData.data?.data;
                  return Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(0),
                      children: [
                        StackContainerWidget(
                          profileImage: community?.profileImage,
                          coverImage: community?.coverImage,
                          member: community?.memberCount,
                          name: community?.name,
                          latestMembers: community?.latestMembers,
                          hasJoined: community?.hasJoined,
                          token: token,
                          communityId: widget.communityId,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: CustomReadMoreText(
                            content: '${community?.description}',
                            color: AppColors.secondTextColor,
                            mColor: AppColors.mainColor,
                            rColor: AppColors.mainColor,
                            trimLines: 3,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: commentController,
                            style: GoogleFonts.nunito(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor,
                            ),
                            minLines: 3,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: AppColors.textFildBGColor,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              hintText: 'Type Enquiry or Comment...',
                              hintStyle:
                                  TextStyle(color: AppColors.textFildHintColor),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: AppColors.textFildBorderColor),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: AppColors.textFildBorderColor),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: AppColors.textFildBorderColor),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.only(left: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            border: Border.all(
                              color: AppColors.textFildBorderColor,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomText(
                                  data: attachmentName?.path.toString() ??
                                      'Upload Attachments...',
                                  fSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: attachmentName?.path != null
                                      ? AppColors.blackColor
                                      : AppColors.textFildHintColor,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _getStorage(context);
                                },
                                icon: const Icon(
                                  Icons.attach_file_rounded,
                                  color: AppColors.mainColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: RadioWidget(
                            firstData: 'Post as Question',
                            secondData: 'Post as Enquiry',
                            selectedOption: selectedValue == 'person'
                                ? 'person'
                                : 'experience',
                            setValue: ((val) {
                              selectedValue = val;
                              setState(() {});
                            }),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if(community?.hasJoined  == false){
                              Utils.toastMessage('Please Join Community...');
                            } else if (commentController.text.isEmpty) {
                              Utils.toastMessage('Please Type Comment...');
                            } else {
                              Map<String, String> data = {
                                'description':
                                    commentController.text.toString(),
                                'type_id': selectedValue == 'person'
                                    ? 'question'
                                    : 'inquiry',
                                'community_id': '${widget.communityId}',
                              };
                              addCommunityComment
                                  .addCommunityCommentApi(token, data, context,
                                      attachment: attachment,
                                      communityId: widget.communityId)
                                  .then((value) {
                                commentController.clear();
                                attachment = null;
                                attachmentName = null;
                                setState(() {});
                              });
                            }
                          },
                          child: Container(
                            height: 45,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.textFildBGColor,
                              border: Border.all(
                                color: AppColors.mainColor,
                              ),
                            ),
                            child: Center(
                              child: addCommunityComment
                                      .addCommunityCommentsLoading
                                  ? const Center(
                                      child: SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                    )
                                  : const CustomText(
                                      data: 'Post Now',
                                      fSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.mainColor,
                                    ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: CustomText(
                            data: 'Recent Questions & Enquiry',
                            color: AppColors.splashTextColor,
                            fontWeight: FontWeight.w700,
                            fSize: 17,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Consumer<GetCommunityCommentViewModel>(
                          builder: (context, value, child) {
                            switch (value.communityCommentData.status) {
                              case Status.LOADING:
                                return const FollowersShimmer();
                              case Status.ERROR:
                                return Container();
                              case Status.COMPLETED:
                                var communityComment =
                                    value.communityCommentData.data?.data;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: ListView.builder(
                                    itemCount: communityComment?.data?.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      var data = communityComment?.data?[index];
                                      return InquiryCommentWidget(
                                        profileImage: data?.user
                                            ?.profileImageUrl,
                                        description: data?.description,
                                        name: data?.user?.name,
                                        attachment: data?.attachment,
                                        createDate: data?.createdAt,
                                        typeId: data?.typeId,
                                        communityId: widget.communityId,
                                        token: token,
                                        parentId: data?.id,
                                        replies: data?.replies,
                                        hasJoined: community?.hasJoined,
                                      );
                                    },
                                  ),
                                );
                              default:
                            }
                            return Container();
                          },
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  );
                default:
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
