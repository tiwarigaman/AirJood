import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import '../../res/components/color.dart';

class CustomExitCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final String positiveButton;
  final String negativeButton;
  final VoidCallback? onPressed;
  const CustomExitCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.positiveButton,
      required this.negativeButton,
      this.onPressed,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 40, top: 15),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(.5),
                borderRadius: BorderRadius.circular(20)),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade50,
              ),
              child: Icon(icon),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: GoogleFonts.salsa(fontSize: 17),
          ),
          const SizedBox(height: 10),
          Text(
            subTitle,
            style: GoogleFonts.salsa(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      foregroundColor: AppColors.whiteColor,
                      backgroundColor: AppColors.mainColor // Background color
                      ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    negativeButton,
                    style: GoogleFonts.salsa(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      foregroundColor: AppColors.whiteColor,
                      backgroundColor: AppColors.mainColor // Background color
                      ),
                  onPressed: onPressed,
                  child: Text(
                    positiveButton,
                    style: GoogleFonts.salsa(fontSize: 16),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
