import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:provider/provider.dart';

import '../../../../data/response/status.dart';
import '../../../../res/components/CustomText.dart';
import '../../../../res/components/color.dart';
import '../../../../res/components/datebutton.dart';
import '../../../../res/components/mainbutton.dart';
import '../../../../res/components/maintextfild.dart';
import '../../../../view_model/music_view_model.dart';

class CustomBottomContainer extends StatefulWidget {
  // final musicDataModel;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onPreviewTap;
  final GestureTapCallback? onPreviewTapV;
  final TextEditingController? controller;
  final TextEditingController? lcontroller;
  final Function? onValue;
  final Function? onId;
  final Function? artistName;
  final String? formattedDate;

  const CustomBottomContainer(
      {super.key,
      // this.musicDataModel,
      this.onTap,
      this.onPreviewTap,
      this.controller,
      this.onValue,
      this.lcontroller,
      this.onId,
      this.artistName,
      this.formattedDate,
      this.onPreviewTapV});

  @override
  State<CustomBottomContainer> createState() => _CustomBottomContainerState();
}

class _CustomBottomContainerState extends State<CustomBottomContainer> {
  var location;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    widget.lcontroller?.text = controller.text;
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: const BoxDecoration(
        color: AppColors.whiteTextColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MainTextFild(
              controller: widget.controller,
              labelText: "Write a Caption...",
              maxLines: 3,
            ),
            const SizedBox(
              height: 15,
            ),
            DateButton(
              data: 'Date of shooting (not in case of record video)',
              onTap: widget.onPreviewTapV,
              formattedDate: widget.formattedDate,
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 50,
              child: GooglePlaceAutoCompleteTextField(
                textEditingController: controller,
                googleAPIKey: 'AIzaSyCixBRBBiL0cWT7JleGlVIE3tYoee9Aa00',
                inputDecoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.my_location_rounded,
                    color: AppColors.mainColor,
                  ),
                  hintText: "Add Location..",
                  hintStyle: GoogleFonts.nunitoSans(
                      fontSize: 17,
                      color: AppColors.textFildHintColor,
                      fontWeight: FontWeight.w500),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                debounceTime: 400,
                // countries: const ["in", "fr"],
                isLatLngRequired: false,
                itemClick: (Prediction prediction) {
                  setState(() {
                    controller.text = prediction.description ?? '';
                  });
                },
                seperatedBuilder: const Divider(),
                itemBuilder: (context, index, Prediction prediction) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 2, bottom: 2),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          child: Text(
                            prediction.description ?? "",
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  );
                },
                boxDecoration: BoxDecoration(
                  color: AppColors.textFildBGColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.textFildBorderColor),
                ),
                isCrossBtnShown: true,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              //onTap: widget.onTap,
              onTap: () {
                _showImagePickerBottomSheet(context);
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.tabBGColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      'assets/svg/music.svg',
                      height: 20,
                    ),
                    const Spacer(),
                    const CustomText(
                      data: 'Add Music',
                      fontWeight: FontWeight.w600,
                      fSize: 16,
                      color: AppColors.mainColor,
                    ),
                    const Spacer(),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                audioPlayer.pause();
                if (widget.onPreviewTap != null) {
                  widget.onPreviewTap!();
                }
              },
              child: const MainButton(
                data: 'Preview',
              ),
            ),
          ],
        ),
      ),
    );
  }

  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  void _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height/1.2
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 5,
                  width: 60,
                  decoration: const BoxDecoration(
                    color: AppColors.tabBGColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const MainTextFild(
                  hintText: 'Search Music...',
                  maxLines: 1,
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: AppColors.textFildHintColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Consumer<MusicViewModel>(
                    builder: (context, value, child) {
                      switch (value.musicData.status) {
                        case Status.LOADING:
                          return const Text('');
                        case Status.ERROR:
                          return Center(
                              child: Text(value.musicData.message.toString()));
                        case Status.COMPLETED:
                          return ListView.builder(
                            itemCount: value.musicData.data?.data?.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  widget.onValue!(value
                                      .musicData.data?.data?[index].songPathUrl);
                                  widget.onId!(
                                      value.musicData.data?.data?[index].id);
                                  widget.artistName!(value
                                      .musicData.data?.data?[index].artistName);
                                  Navigator.pop(context);
                                },
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: value.musicData.data?.data?[index]
                                                    .thumbnailPathUrl ==
                                                null ||
                                            value.musicData.data?.data?[index]
                                                    .thumbnailPathUrl ==
                                                ''
                                        ? Image.asset(
                                            'assets/images/music_image.png',
                                            height: 40,
                                            width: 40,
                                          )
                                        : Image.network(
                                            '${value.musicData.data?.data?[index].thumbnailPathUrl}',
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.fill,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.error,
                                                    color: AppColors.mainColor,
                                                    size: 20,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                                  title: CustomText(
                                    data:
                                        '${value.musicData.data?.data?[index].title}',
                                    fSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  subtitle: Row(
                                    children: [
                                      const Icon(
                                        Icons.circle,
                                        size: 5,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      CustomText(
                                        data:
                                            '${value.musicData.data?.data?[index].artistName}',
                                        fSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(
                                        Icons.circle,
                                        size: 5,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const CustomText(
                                        data: '4:18',
                                        fSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                  trailing: InkWell(
                                    onTap: () async {
                                      if (value.musicData.data!.data![index]
                                          .isPlaying!) {
                                        value.musicData.data?.data?[index]
                                            .isPlaying = !(value.musicData.data
                                                ?.data?[index].isPlaying ??
                                            false);
                                        await audioPlayer.pause();
                                      } else {
                                        value.musicData.data?.data
                                            ?.forEach((element) {
                                          element.isPlaying = false;
                                        });
                                        await audioPlayer.play(UrlSource(value
                                            .musicData
                                            .data!
                                            .data![index]
                                            .songPathUrl!));
                                        value.musicData.data?.data?[index]
                                            .isPlaying = !(value.musicData.data
                                                ?.data?[index].isPlaying ??
                                            false);
                                      }
                                      setState(() {});
                                    },
                                    child: value.musicData.data?.data?[index]
                                                .isPlaying ==
                                            true
                                        ? const Icon(
                                            CupertinoIcons.stop_circle,
                                            size: 35,
                                            color: AppColors.mainColor,
                                            weight: 0.1,
                                          )
                                        : const Icon(
                                            CupertinoIcons.play_circle,
                                            size: 35,
                                            color: AppColors.mainColor,
                                            weight: 0.1,
                                          ),
                                  ),
                                ),
                              );
                            },
                          );
                        default:
                      }
                      return Container();
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    super.dispose();
  }
}
