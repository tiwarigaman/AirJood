// ignore_for_file: use_build_context_synchronously, duplicate_ignore

// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:ui';

import 'package:airjood/utils/utils.dart';
import 'package:airjood/view/navigation_view/add_new_reels/sub_view/preview_reels_screen.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../../../res/components/color.dart';
import '../../../../view_model/music_view_model.dart';
import '../../../../view_model/user_view_model.dart';
import '../components/bottom_container.dart';

class UploadImageScreen extends StatefulWidget {
  final XFile file;
  final String thumbNail;
  final String? screen;
  const UploadImageScreen({
    super.key,
    required this.file,
    required this.thumbNail,
    this.screen,
  });

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? audioFile;
  TextEditingController captionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    UserViewModel().getToken().then((value) {
      Provider.of<MusicViewModel>(context, listen: false).musicGetApi(value!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image:
                  AssetImage('assets/images/img_bg.png'), // Set the image asset
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildImage(context),
              _buildBottom(context),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickMedia();
    if (pickedFile != null) {
      setState(() {
        audioFile = File(pickedFile.path);
      });
    }
  }

  Widget _buildImage(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Image.file(
              File(widget.thumbNail),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 120.0, sigmaY: 20.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent, // Make the container transparent
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 20, top: 55),
                  child: Icon(
                    CupertinoIcons.clear_thick,
                    color: AppColors.whiteTextColor,
                    size: 25,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 55, bottom: 55),
              child: Align(
                alignment: AlignmentDirectional.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3.5,
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: Image.file(
                      File(widget.thumbNail),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await (getExternalStorageDirectory())
        : await getApplicationDocumentsDirectory();
    return directory!.path;
  }

  String? music;
  String? artName;
  int? musicId;
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('d MMM yyyy').format(selectedDate!);
      });
    }
  }

  String? formattedDate;

  Widget _buildBottom(BuildContext context) {
    return CustomBottomContainer(
      onTap: () {
        _getImageFromGallery();
      },
      controller: captionController,
      lcontroller: locationController,
      onPreviewTapV: () {
        _selectDate(context);
      },
      formattedDate: formattedDate,
      onValue: ((String val) {
        setState(() {
          music = val;
        });
      }),
      onId: ((val) {
        setState(() {
          musicId = val;
        });
      }),
      artistName: ((val) {
        setState(() {
          artName = val;
        });
      }),
      onPreviewTap: () async {
        String f = await _findLocalPath();
        if (music != null) {
          String quotePath(String path) {
            return "'${path.replaceAll("'", "'\\''")}'";
          }

          String videoFilePath = quotePath(widget.file.path);
          String musicFilePath = quotePath(music!);
          String outputFilePath =
              quotePath("$f${Platform.pathSeparator}out.mp4");

          String command =
              "-i $videoFilePath -i $musicFilePath -y -c:v copy -c:a aac -map 0:v:0 -map 1:a:0 -shortest $outputFilePath";

          FFmpegKit.execute(command).then((session) async {
            final returnCode = await session.getReturnCode();
            // final output = await session.getOutput();
            // final log = await session.getLogs();
            // final error = await session.getFailStackTrace();

            if (ReturnCode.isSuccess(returnCode)) {
              if (captionController.text.trim().isEmpty) {
                Utils.toastMessage('please enter caption');
              } else if (formattedDate!.isEmpty) {
                Utils.toastMessage('please select Date');
              } else if (locationController.text.isEmpty) {
                Utils.toastMessage('please enter location');
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreviewReelsScreen(
                      postVideo: '$f${Platform.pathSeparator}out.mp4',
                      thumbnail: widget.thumbNail,
                      caption: captionController.text,
                      location: locationController.text,
                      songId: musicId,
                      artName: artName,
                      date: selectedDate,
                      screen: widget.screen,
                    ),
                  ),
                );
              }
            } else if (ReturnCode.isCancel(returnCode)) {
              Utils.toastMessage('Something went wrong!');
            } else {
              Utils.toastMessage('Something went wrong!');
            }
          });
        } else {
          if (captionController.text.trim().isEmpty) {
            Utils.toastMessage('please enter caption');
          } else if (formattedDate!.isEmpty) {
            Utils.toastMessage('please select Date');
          } else if (locationController.text.isEmpty) {
            Utils.toastMessage('please enter location');
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PreviewReelsScreen(
                  postVideo: widget.file.path,
                  thumbnail: widget.thumbNail,
                  caption: captionController.text.toString(),
                  location: locationController.text,
                  date: selectedDate,
                  screen: widget.screen,
                ),
              ),
            );
          }
        }
      },
    );
  }
}
