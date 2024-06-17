import 'package:airjood/view/navigation_view/chat_view/chat_components/full_screen_image.dart';
import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String data;
  final int num;

  const ImageBox({super.key, required this.data, required this.num});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImage(imageUrl: data),
          ),
        );
      },
      child: Align(
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
            child: Image.network(
              data,
              height: 160,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}