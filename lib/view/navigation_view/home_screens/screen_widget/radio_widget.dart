import 'package:airjood/res/components/color.dart';
import 'package:flutter/material.dart';

class RadioWidget extends StatefulWidget {
  final String? selectedOption;
  final Function? setValue;

  const RadioWidget({super.key, this.setValue, this.selectedOption = 'person'});

  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  String? selectedOption;

  @override
  void initState() {
    setState(() {
      selectedOption = widget.selectedOption;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RadioListTile(
          title: const Text('Price Per Person',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          value: 'person',
          contentPadding: EdgeInsets.zero,
          groupValue: selectedOption,
          toggleable: false,
          dense: true,
          activeColor: AppColors.mainColor,
          onChanged: (value) {
            setState(() {
              selectedOption = value;
              if (widget.setValue != null) {
                widget.setValue!(value);
              }
            });
          },
        ),
        RadioListTile(
          title: const Text('Price Per Experience',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          value: 'experience',
          contentPadding: EdgeInsets.zero,
          toggleable: false,
          dense: true,
          activeColor: AppColors.mainColor,
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value;
              if (widget.setValue != null) {
                widget.setValue!(value);
              }
            });
          },
        ),
      ],
    );
  }
}
