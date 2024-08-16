import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:airjood/model/community_comment_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/maintextfild.dart';
import '../../../../utils/utils.dart';
import '../../../../view_model/add_community_comment_view_model.dart';
import '../reply_inquiry_screen.dart';

class TaskInfo {
  TaskInfo({this.name, this.link});

  final String? name;
  final String? link;

  String? taskId;
  int? progress = 0;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;
}

class InquiryCommentWidget extends StatefulWidget {
  final String? profileImage;
  final String? description;
  final String? name;
  final String? attachment;
  final DateTime? createDate;
  final String? typeId;
  final int? communityId;
  final int? parentId;
  final String? token;
  final List<Datum>? replies;
  final bool? hasJoined;

  const InquiryCommentWidget({
    super.key,
    this.profileImage,
    this.description,
    this.name,
    this.attachment,
    this.createDate,
    this.typeId,
    this.communityId,
    this.parentId,
    this.token,
    this.replies,
    this.hasJoined,
  });

  @override
  State<InquiryCommentWidget> createState() => _InquiryCommentWidgetState();
}

class _InquiryCommentWidgetState extends State<InquiryCommentWidget> {
  final TextEditingController _replyController = TextEditingController();
  final ReceivePort _port = ReceivePort();
  List<TaskInfo>? _tasks;

  @override
  void initState() {
    super.initState();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback, step: 1);
  }

  void _bindBackgroundIsolate() {
    final isSuccess = IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      final taskId = (data as List<dynamic>)[0] as String;
      final status = DownloadTaskStatus.fromInt(data[1] as int);
      final progress = data[2] as int;

      if (progress == 100) {
        Utils.toastMessage('Download completed');
      }
      if (kDebugMode) {
        print(
          'Callback on UI isolate: '
          'task ($taskId) is in status ($status) and process ($progress)',
        );
      }

      if (_tasks != null && _tasks!.isNotEmpty) {
        final task = _tasks!.firstWhere((task) => task.taskId == taskId);
        setState(() {
          task
            ..status = status
            ..progress = progress;
        });
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    int status,
    int progress,
  ) {
    if (kDebugMode) {
      print(
        'Callback on background isolate: '
        'task ($id) is in status ($status) and process ($progress)',
      );
    }

    IsolateNameServer.lookupPortByName('downloader_send_port')
        ?.send([id, status, progress]);
  }

  Future<void> downloadFile(String url) async {
    await Permission.storage.request();
    Directory? baseStorage;

    if (Platform.isAndroid) {
      baseStorage = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      baseStorage = await getApplicationDocumentsDirectory();
    }

    if (baseStorage != null) {
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: baseStorage.path,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: true,
      );
      if (taskId != null) {
        Utils.toastMessage('Downloading...');
      }
    } else {
      Utils.toastMessage('Failed to get storage directory');
    }
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _showReplyInput(formattedDate, ctx) {
    final addCommunityComment =
        Provider.of<AddCommunityCommentViewModel>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        double keyboardHeight = MediaQuery.of(context).viewInsets.bottom / 2.1;
        return Padding(
          padding: EdgeInsets.only(
            bottom: keyboardHeight,
          ),
          child: Container(
            height: 220 + keyboardHeight,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
                left: 10,
                right: 10,
                top: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: '${widget.profileImage}',
                          height: 40,
                          width: 40,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            data: '${widget.name}',
                            fSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.tileTextColor,
                          ),
                          CustomText(
                            data: formattedDate,
                            fSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.tileTextColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomText(
                    data: '${widget.description}',
                    fSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.tileTextColor,
                    textAlign: TextAlign.justify,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  MainTextFild(
                    controller: _replyController,
                    hintText: 'Type your reply',
                    maxLines: 1,
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (_replyController.text.isEmpty) {
                          Utils.toastMessage('Please Type Comment...');
                        } else {
                          Map<String, String> data = {
                            'description': _replyController.text.toString(),
                            'type_id': 'question',
                            'community_id': '${widget.communityId}',
                            'parent_id': '${widget.parentId}',
                          };
                          addCommunityComment
                              .addCommunityCommentApi(widget.token, data, ctx,
                                  communityId: widget.communityId)
                              .then((value) {
                            _replyController.clear();
                            Navigator.pop(context);
                          });
                        }
                      },
                      icon: const Icon(
                        CupertinoIcons.paperplane_fill,
                        color: AppColors.mainColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String originalTimestamp = "${widget.createDate}";
    DateTime parsedDate = DateTime.parse(originalTimestamp);
    String formattedDate =
        DateFormat("d'th' MMMM yyyy @hh:mma").format(parsedDate);
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: widget.typeId != 'question'
            ? AppColors.blueShade
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: '${widget.profileImage}',
                  height: 40,
                  width: 40,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          data: '${widget.name}',
                          fSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.tileTextColor,
                        ),
                        if (widget.attachment != null &&
                            widget.attachment!.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              downloadFile(widget.attachment!);
                            },
                            child: const Icon(
                              Icons.attach_file_rounded,
                              color: AppColors.mainColor,
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                    CustomText(
                      data: formattedDate,
                      fSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.tileTextColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          CustomText(
            data: '${widget.description}',
            fSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.tileTextColor,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 15),
          const Divider(height: 0, thickness: 1, color: AppColors.deviderColor),
          Stack(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ExpansionTile(
                  expandedAlignment: Alignment.bottomCenter,
                  tilePadding: EdgeInsets.zero,
                  collapsedShape: InputBorder.none,
                  collapsedIconColor: AppColors.transperent,
                  iconColor: AppColors.transperent,
                  childrenPadding: const EdgeInsets.all(10),
                  shape: InputBorder.none,
                  title: CustomText(
                    data: '${widget.replies?.length} Replies',
                    decoration: TextDecoration.underline,
                    color: AppColors.greyTextColor,
                    fontWeight: FontWeight.w500,
                    fSize: 16,
                    decorationColor: AppColors.greyTextColor,
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.replies?.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        var data = widget.replies?[index];
                        String originalTimestamp = "${data?.updatedAt}";
                        DateTime parsedDate = DateTime.parse(originalTimestamp);
                        String formattedDate2 =
                            DateFormat("d'th' MMMM yyyy @hh:mma")
                                .format(parsedDate);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              minVerticalPadding: 0,
                              contentPadding: EdgeInsets.zero,
                              horizontalTitleGap: 7,
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl: '${data?.user?.profileImageUrl}',
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              title: CustomText(
                                data: data?.user?.name ?? 'Deleted User',
                                fSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blackTextColor,
                              ),
                              subtitle: CustomText(
                                data: formattedDate2,
                                fSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (data?.attachment != null &&
                                      data!.attachment!.isNotEmpty)
                                    GestureDetector(
                                      onTap: () {
                                        downloadFile(data.attachment!);
                                      },
                                      child: const Icon(
                                        Icons.attach_file_rounded,
                                        color: AppColors.mainColor,
                                        size: 18,
                                      ),
                                    ),
                                  const SizedBox(height: 5),
                                  if (data?.price != null)
                                    CustomText(
                                      data: '  \$${data?.price}',
                                      fSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.mainColor,
                                    ),
                                ],
                              ),
                            ),
                            CustomText(
                              data: data?.description ??
                                  'Lvitae ullamcorper adipiscing est. Phasellus proin non',
                              color: AppColors.greyTextColor,
                              fontWeight: FontWeight.w500,
                              fSize: 13,
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 15),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                width: 70,
                child: InkWell(
                  onTap: () {
                    if (widget.hasJoined == false) {
                      Utils.toastMessage('Please Join Community...');
                    } else if (widget.typeId == 'question') {
                      _showReplyInput(formattedDate, context);
                    } else {
                      showModalBottomSheet(
                        context: context,
                        constraints: BoxConstraints.expand(
                          height: MediaQuery.of(context).size.height * 0.70,
                          width: MediaQuery.of(context).size.width,
                        ),
                        isScrollControlled: true,
                        builder: (_) => PostInquiryScreen(
                          context: context,
                          parentId: widget.parentId,
                          token: widget.token,
                          communityId: widget.communityId,
                        ),
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 18),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.reply, size: 20),
                        SizedBox(width: 5),
                        CustomText(
                          data: 'Reply',
                          fSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackTextColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
