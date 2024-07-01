import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../../../../res/components/color.dart';

class GoogleLocationBox extends StatefulWidget {
  final Function? setLocation;
  const GoogleLocationBox({super.key, this.setLocation});

  @override
  State<GoogleLocationBox> createState() => _GoogleLocationBoxState();
}

class _GoogleLocationBoxState extends State<GoogleLocationBox> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        googleAPIKey: 'AIzaSyC5npjbUL8pKHqNXkl7ps3E1H4f9hh8lgo',
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
        countries: const ["in", "fr"],
        isLatLngRequired: false,
        itemClick: (Prediction prediction) {
          setState(() {
            controller.text = prediction.description ?? '';
            widget.setLocation!(prediction.description ?? controller.text);
          });
        },
        seperatedBuilder: const Divider(),
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 2, bottom: 2),
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
    );
  }
}
