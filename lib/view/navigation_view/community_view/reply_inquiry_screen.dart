import 'dart:io';
import 'package:airjood/view/navigation_view/home_screens/component/upload_id.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';
import '../../../res/components/mainbutton.dart';
import '../../../res/components/maintextfild.dart';
import '../../../utils/utils.dart';
import '../../../view_model/add_community_comment_view_model.dart';

class PostInquiryScreen extends StatefulWidget {
  final BuildContext? context;
  final int? communityId;
  final int? parentId;
  final String? token;
  const PostInquiryScreen({super.key, this.context, this.communityId, this.parentId, this.token});

  @override
  State<PostInquiryScreen> createState() => _PostInquiryScreenState();
}

class _PostInquiryScreenState extends State<PostInquiryScreen> {
  final TextEditingController replyController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  File? image;
  @override
  Widget build(BuildContext context) {
    final addCommunityComment =
    Provider.of<AddCommunityCommentViewModel>(context);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F1F8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        data: 'Reply Enquiry',
                        color: AppColors.blackTextColor,
                        fontWeight: FontWeight.w700,
                        fSize: 22,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(CupertinoIcons.xmark),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16,),
                child: UploadId(
                  name: 'Upload Attachment',
                  onValue: ((val) {
                    setState(() {
                      image = val;
                    });
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                child: MainTextFild(
                  controller: replyController,
                  hintText: 'Type Enquiry or Comment...',
                  maxLines: 3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                child: MainTextFild(
                  controller: priceController,
                  hintText: 'Enter your price',
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    if (replyController.text.isEmpty) {
                      Utils.toastMessage('Please Type Comment...');
                    } else {
                      Map<String, String> data = {
                        'description': replyController.text.toString(),
                        'type_id': 'inquiry',
                        'community_id': '${widget.communityId}',
                        'parent_id': '${widget.parentId}',
                        'price': priceController.text.toString(),
                      };
                      addCommunityComment
                          .addCommunityCommentApi(
                          widget.token, data, widget.context ?? context,
                          attachment: image,
                          communityId: widget.communityId)
                          .then((value) {
                        replyController.clear();
                        priceController.clear();
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: MainButton(
                    loading: addCommunityComment.addCommunityCommentsLoading,
                    data: 'Post Enquiry',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
