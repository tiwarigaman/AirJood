import 'package:airjood/res/components/CustomText.dart';
import 'package:airjood/res/components/custom_shimmer.dart';
import 'package:airjood/utils/utils.dart';
import 'package:airjood/view_model/add_comment_view_model.dart';
import 'package:airjood/view_model/add_remove_like_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../data/response/status.dart';
import '../../../../res/components/color.dart';
import '../../../../view_model/comment_view_model.dart';
import '../../../../view_model/user_view_model.dart';

class CommentWidget extends StatefulWidget {
  final int? reelsId;
  final Function? commentAdd;
  const CommentWidget({super.key, this.reelsId, this.commentAdd});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  void _openKeyboard() {
    FocusScope.of(context).requestFocus(_focusNode);
  }

  void _offKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    UserViewModel().getUser().then((value) {
      image = value?.profileImageUrl;
      setState(() {});
    });
    super.initState();
  }

  String? image;
  void _setParentId(int? id) {
    newId = id ?? 0;
    setState(() {});
  }

  int newId = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool like = false;

  @override
  Widget build(BuildContext context) {
    final addComment = Provider.of<AddCommentViewModel>(context);
    final addLike = Provider.of<AddRemoveLikeViewModel>(context);
    void handleLike(int index, value) {
      setState(() {
        value.commentData.data!.data![index].liked =
            !value.commentData.data!.data![index].liked;
        if (value.commentData.data!.data![index].liked == true) {
          value.commentData.data!.data![index].likeCount =
              (value.commentData.data!.data![index].likeCount ?? 0) + 1;
        } else {
          value.commentData.data!.data![index].likeCount =
              (value.commentData.data!.data![index].likeCount ?? 0) - 1;
        }
      });
      Map<String, dynamic> data = {
        "is_like": value.commentData.data!.data![index].liked
      };
      UserViewModel().getToken().then((token) async {
        addLike.addRemoveLikeApi(
          token,
          data,
          value.commentData.data!.data![index].id!.toInt(),
          context,
        );
      }).then((value) {});
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          child: Consumer<CommentViewModel>(
            builder: (context, value, child) {
              switch (value.commentData.status) {
                case Status.LOADING:
                  return const ChatShimmer();
                case Status.ERROR:
                  return const ChatShimmer();
                case Status.COMPLETED:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: CustomText(
                          data:
                              'Comments (${value.commentData.data?.data?.length})',
                          fontColor: AppColors.blackTextColor,
                          fweight: FontWeight.w800,
                          fSize: 18,
                        ),
                      ),
                      value.commentData.data!.data!.isEmpty ||
                              value.commentData.data?.data == null
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.67,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  'No Data Found !',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.67,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      value.commentData.data?.data?.length,
                                  itemBuilder: (context, index) {
                                    String? formattedDate =
                                        '${value.commentData.data?.data?[index].updatedAt?.day ?? '00'}-${value.commentData.data?.data?[index].updatedAt?.month ?? '00'}-${value.commentData.data?.data?[index].updatedAt?.year ?? '0000'}';
                                    DateTime dateTime = DateFormat('dd-MM-yyyy')
                                        .parse(formattedDate);
                                    String result = DateFormat('dd MMM yyyy')
                                        .format(dateTime);
                                    DateTime? updatedAt = value.commentData.data
                                        ?.data?[index].updatedAt
                                        ?.toLocal();
                                    String formattedTime =
                                        DateFormat('h:mm a').format(updatedAt!);
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          minVerticalPadding: 0,
                                          contentPadding: const EdgeInsets.only(
                                              left: 0,
                                              right: 0,
                                              top: 10,
                                              bottom: 0),
                                          leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.network(
                                              value
                                                      .commentData
                                                      .data
                                                      ?.data?[index]
                                                      .user
                                                      ?.profileImageUrl ??
                                                  '',
                                              fit: BoxFit.cover,
                                              height: 45,
                                            ),
                                          ),
                                          title: CustomText(
                                            data: value.commentData.data
                                                    ?.data?[index].user?.name ??
                                                '',
                                            fSize: 16,
                                            fweight: FontWeight.w700,
                                            fontColor: AppColors.blackTextColor,
                                          ),
                                          subtitle: CustomText(
                                            data: '$result   @$formattedTime',
                                            fSize: 13,
                                            fweight: FontWeight.w500,
                                          ),
                                          trailing: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  handleLike(index, value);
                                                },
                                                child: Icon(
                                                  value
                                                              .commentData
                                                              .data!
                                                              .data![index]
                                                              .liked ==
                                                          true
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: value
                                                              .commentData
                                                              .data!
                                                              .data![index]
                                                              .liked ==
                                                          true
                                                      ? Colors.red
                                                      : AppColors
                                                          .textFildHintColor,
                                                ),
                                              ),
                                              CustomText(
                                                data:
                                                    '${value.commentData.data!.data![index].likeCount}',
                                                fSize: 12,
                                                fweight: FontWeight.w500,
                                                fontColor:
                                                    AppColors.textFildHintColor,
                                              )
                                            ],
                                          ),
                                        ),
                                        Text(
                                          value.commentData.data?.data?[index]
                                                  .content ??
                                              '',
                                          textAlign: TextAlign.justify,
                                          style: GoogleFonts.nunitoSans(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.greyTextColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Divider(
                                          color: Color(0xFFDBE2EB),
                                          height: 0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.4,
                                              child: ExpansionTile(
                                                expandedAlignment:
                                                    Alignment.bottomCenter,
                                                tilePadding: EdgeInsets.zero,
                                                collapsedShape:
                                                    InputBorder.none,
                                                collapsedIconColor:
                                                    AppColors.transperent,
                                                iconColor:
                                                    AppColors.transperent,
                                                childrenPadding:
                                                    const EdgeInsets.only(
                                                        left: 20),
                                                shape: InputBorder.none,
                                                title: Text(
                                                  '${value.commentData.data?.data?[index].replies?.length} Replies',
                                                  style: GoogleFonts.nunitoSans(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color:
                                                        AppColors.greyTextColor,
                                                    decorationStyle:
                                                        TextDecorationStyle
                                                            .solid,
                                                    decorationColor:
                                                        AppColors.greyTextColor,
                                                  ),
                                                ),
                                                children: [
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount: value
                                                        .commentData
                                                        .data
                                                        ?.data?[index]
                                                        .replies
                                                        ?.length,
                                                    itemBuilder:
                                                        (context, indexs) {
                                                      String? formattedDate =
                                                          '${value.commentData.data?.data?[index].replies?[indexs].updatedAt?.day ?? '00'}-${value.commentData.data?.data?[index].replies?[indexs].updatedAt?.month ?? '00'}-${value.commentData.data?.data?[index].replies?[indexs].updatedAt?.year ?? '0000'}';
                                                      DateTime dateTime =
                                                          DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .parse(
                                                                  formattedDate);
                                                      String result1 =
                                                          DateFormat(
                                                                  'dd MMM yyyy')
                                                              .format(dateTime);
                                                      DateTime? createdAt =
                                                          value
                                                              .commentData
                                                              .data
                                                              ?.data?[index]
                                                              .replies?[indexs]
                                                              .updatedAt
                                                              ?.toLocal();
                                                      String formattedTime1 =
                                                          DateFormat('h:mm a')
                                                              .format(
                                                                  createdAt!);
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          ListTile(
                                                            minVerticalPadding:
                                                                0,
                                                            leading: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              child:
                                                                  Image.network(
                                                                '${value.commentData.data?.data?[index].replies?[indexs].user?.profileImageUrl}',
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 40,
                                                              ),
                                                            ),
                                                            title: CustomText(
                                                              data:
                                                                  '${value.commentData.data?.data?[index].replies?[indexs].user?.name}',
                                                              fSize: 14,
                                                              fweight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontColor: AppColors
                                                                  .blackTextColor,
                                                            ),
                                                            subtitle:
                                                                CustomText(
                                                              data:
                                                                  '$result1   @$formattedTime1',
                                                              fSize: 10,
                                                              fweight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 20),
                                                            child: Text(
                                                              '${value.commentData.data?.data?[index].replies?[indexs].content}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                              style: GoogleFonts
                                                                  .nunitoSans(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: AppColors
                                                                    .greyTextColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
                                                Future.delayed(Duration.zero,
                                                    () => _openKeyboard());
                                                int? passId = value.commentData
                                                    .data?.data?[index].id;
                                                _setParentId(passId);
                                              },
                                              child: const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 14),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.reply),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    CustomText(
                                                      data: 'Reply',
                                                      fSize: 15,
                                                      fweight: FontWeight.w600,
                                                      fontColor: AppColors
                                                          .blackTextColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                      Container(
                        height: 1.5,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          color: AppColors.textFildHintColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl: '$image',
                                fit: BoxFit.cover,
                                height: 45,
                                width: 45,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                focusNode: _focusNode,
                                decoration: const InputDecoration(
                                  hintText: 'Add a comment...',
                                  border: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (_controller.text.isEmpty) {
                                  Utils.tostMessage('Enter comment...');
                                } else {
                                  Map<String, String> data = {
                                    "parent_id": '${newId == 0 ? '' : newId}',
                                    "content": _controller.text,
                                    "reel_id": "${widget.reelsId}"
                                  };
                                  UserViewModel()
                                      .getToken()
                                      .then((token) async {
                                    addComment.addCommentsApi(
                                      token,
                                      data,
                                      context,
                                      widget.reelsId!.toInt(),
                                      () {
                                        widget.commentAdd!();
                                      },
                                    );
                                  }).then((value) {
                                    newId = 0;
                                    _offKeyboard();
                                    _controller.clear();
                                    // widget.commentAdd!();
                                  });
                                }
                              },
                              child: addComment.addCommentLoading == true
                                  ? const Center(
                                      child: SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: CircularProgressIndicator(
                                          color: AppColors.mainColor,
                                          strokeWidth: 1,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'Post',
                                      style: GoogleFonts.nunitoSans(
                                        color: AppColors.mainColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.mainColor,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                default:
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
