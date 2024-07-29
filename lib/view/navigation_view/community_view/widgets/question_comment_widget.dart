import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';

class QuestionCommentWidget extends StatefulWidget {
  final String? profileImage;
  final String? description;
  final String? name;
  final String? attachment;
  final DateTime? createDate;

  const QuestionCommentWidget({
    super.key,
    this.profileImage,
    this.description,
    this.name,
    this.attachment,
    this.createDate,
  });

  @override
  State<QuestionCommentWidget> createState() => _QuestionCommentWidgetState();
}

class _QuestionCommentWidgetState extends State<QuestionCommentWidget> {
  final FocusNode _focusNode = FocusNode();
  bool _showAttachment = false;
  String? _localPdfPath;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    if (widget.attachment != null && widget.attachment!.endsWith('.pdf')) {
      _downloadPdf(widget.attachment!);
    }
  }

  Future<void> _downloadPdf(String url) async {
    setState(() {
      _isDownloading = true;
    });

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/temp.pdf');
        await file.writeAsBytes(bytes, flush: true);
        setState(() {
          _localPdfPath = file.path;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error downloading PDF: $e');
      }
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  void _openKeyboard() {
    FocusScope.of(context).requestFocus(_focusNode);
  }

  void _toggleAttachment() {
    setState(() {
      _showAttachment = !_showAttachment;
    });
  }

  Widget _buildAttachment() {
    if (widget.attachment == null) {
      return Container();
    }
    if (widget.attachment!.endsWith('.pdf')) {
      if (_isDownloading) {
        return const Center(child: CircularProgressIndicator());
      } else if (_localPdfPath != null) {
        return Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: PDFView(
              filePath: _localPdfPath,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: true,
            ),
          ),
        );
      } else {
        return Container();
      }
    } else if (widget.attachment!.endsWith('.jpg') || widget.attachment!.endsWith('.png')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: widget.attachment!,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = widget.createDate != null
        ? DateFormat("d'th' MMMM yyyy @hh:mma").format(widget.createDate!)
        : '';

    return Column(
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
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                      GestureDetector(
                        onTap: _toggleAttachment,
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
        const SizedBox(height: 10),
        CustomText(
          data: '${widget.description}',
          fSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.tileTextColor,
          textAlign: TextAlign.justify,
          maxLines: 10,
        ),
        const SizedBox(height: 10),
        _showAttachment ? _buildAttachment() : Container(),
        const Divider(
          height: 0,
          thickness: 1,
          color: AppColors.deviderColor,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ExpansionTile(
                expandedAlignment: Alignment.bottomCenter,
                tilePadding: EdgeInsets.zero,
                collapsedShape: InputBorder.none,
                collapsedIconColor: AppColors.transperent,
                iconColor: AppColors.transperent,
                childrenPadding: const EdgeInsets.only(left: 20),
                shape: InputBorder.none,
                title: const CustomText(
                  data: '1 Replies',
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
                    itemCount: 1,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, indexs) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            minVerticalPadding: 0,
                            contentPadding: EdgeInsets.zero,
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                'assets/images/user.png',
                                fit: BoxFit.cover,
                                height: 40,
                              ),
                            ),
                            title: const CustomText(
                              data: 'Selina Gomez',
                              fSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.blackTextColor,
                            ),
                            subtitle: const CustomText(
                              data: '25th July 2023   @11:45AM',
                              fSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const CustomText(
                            data: 'Lvitae ullamcorper adipiscing est. Phasellus proin non',
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
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Future.delayed(Duration.zero, () => _openKeyboard());
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
          ],
        ),
        const Divider(height: 0, thickness: 1, color: AppColors.deviderColor),
        const SizedBox(height: 15),
      ],
    );
  }
}
