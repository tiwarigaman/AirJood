import 'package:airjood/res/components/maintextfild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/CustomText.dart';
import '../../../res/components/color.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({super.key});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), // Adjust the duration as needed
        curve: Curves.easeOut, // Adjust the curve as needed
      );
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        actions: [
          const SizedBox(width: 5),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 45,
              weight: 2,
            ),
          ),
          const SizedBox(width: 10),
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/user.png'),
          ),
          const SizedBox(width: 15),
          const CustomText(
            data: 'Saimon Jhonson',
            fSize: 22,
            fweight: FontWeight.w700,
            fontColor: AppColors.blackColor,
          ),
          const Spacer(),
          const Icon(CupertinoIcons.ellipsis_vertical),
          const SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                TextBox(
                  data:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ultricies eget felis senectus faucibus diam.',
                  num: 1,
                ),
                TextBox(
                  data:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ultricies eget felis.',
                  num: 0,
                ),
                TextBox(
                  data: 'Didn’t Understand Your Question.',
                  num: 1,
                ),
                TextBox(
                  data: 'Please Repeat It Once.',
                  num: 1,
                ),
                TextBox(
                  data:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ultricies eget felis.',
                  num: 0,
                ),
                TextBox(
                  data: 'Please Repeat It Once.',
                  num: 0,
                ),
                ImageBox(data: 'assets/images/reels_bg_image.png', num: 1),
              ],
            ),
          ),
          Container(
            color: AppColors.textFildBGColor,
            padding: const EdgeInsets.all(10),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                const Icon(
                  CupertinoIcons.photo_on_rectangle,
                  color: AppColors.textFildHintColor,
                ),
                const SizedBox(width: 15),
                const Icon(
                  Icons.mic_none,
                  color: AppColors.textFildHintColor,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: MainTextFild(
                    focusNode: _focusNode,
                    hintText: 'Type Message...',
                    minLines: 1,
                    maxLines: 3,
                    suffixIcon: const Icon(
                      Icons.sentiment_neutral_sharp,
                      color: AppColors.textFildHintColor,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                const Icon(Icons.send),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  const TextBox({super.key, required this.data, required this.num});

  final String data;
  final int num;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: num == 0 ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(
          right: num == 0 ? 5 : 50,
          left: num == 0 ? 50 : 5,
          top: 5,
          bottom: 5,
        ),
        decoration: BoxDecoration(
          color: num == 0 ? AppColors.mainColor : AppColors.textFildHintColor,
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(15),
            topLeft: Radius.circular(num == 0 ? 15 : 0),
            bottomLeft: const Radius.circular(15),
            bottomRight: Radius.circular(num == 0 ? 0 : 15),
          ),
        ),
        child: Text(
          data,
          style: GoogleFonts.nunito(
            color:
                num == 0 ? AppColors.whiteTextColor : AppColors.blackTextColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class ImageBox extends StatelessWidget {
  final String data;
  final int num;

  const ImageBox({super.key, required this.data, required this.num});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: num == 0 ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          right: num == 0 ? 5 : 50,
          left: num == 0 ? 50 : 5,
          top: 5,
          bottom: 5,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(15),
            topLeft: Radius.circular(num == 0 ? 15 : 0),
            bottomLeft: const Radius.circular(15),
            bottomRight: Radius.circular(num == 0 ? 0 : 15),
          ),
          child: Image.asset(
            data,
            height: 160,
            width: 200,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
