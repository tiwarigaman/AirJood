import 'package:airjood/res/components/color.dart';
import 'package:airjood/view_model/get_fridge_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../view_model/user_view_model.dart';

class FridgeDoor extends StatefulWidget {
  const FridgeDoor({super.key});

  @override
  State<FridgeDoor> createState() => _FridgeDoorState();
}

class _FridgeDoorState extends State<FridgeDoor> {
  List<String> firstGridData = [];
  List<String> secondGridData = [];

  @override
  void initState() {
    super.initState();
    fetchFridgeData();
  }

  Future<void> fetchFridgeData() async {
    final token = await UserViewModel().getToken();
    if (token != null) {
      final fridgeProvider = Provider.of<FridgeViewModel>(context, listen: false);
      await fridgeProvider.fridgeGetApi(token).then((value) {
        final allData = fridgeProvider.fridgeData.data?.data ?? [];
        setState(() {
          firstGridData = allData.take(12).toList();
          secondGridData = allData.skip(12).toList();
        });
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 300,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.mainColor, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.mainColor.withOpacity(0.1),
                    spreadRadius: 10,
                    blurRadius: 10,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.mainColor, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mainColor.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: const Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: GridData(data: firstGridData),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.mainColor, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mainColor.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: const Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: SecondGridData(data: secondGridData),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 11)
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 25, // Set the desired width
              height: 15, // Set the desired height
              decoration: const BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0), // Adjust to make it half-round
                  topRight: Radius.circular(0), // Adjust to make it half-round
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 25, // Set the desired width
              height: 15, // Set the desired height
              decoration: const BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0), // Adjust to make it half-round
                  topRight: Radius.circular(0), // Adjust to make it half-round
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class GridData extends StatelessWidget {
  final List<String> data;

  const GridData({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              data[index],
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}

class SecondGridData extends StatelessWidget {
  final List<String> data;

  const SecondGridData({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ScrollbarTheme(
      data: ScrollbarThemeData(
        thumbColor: MaterialStateProperty.all<Color>(AppColors.mainColor), // Change to your desired color
        radius: const Radius.circular(100),
        interactive: true,
        crossAxisMargin: 5,
        mainAxisMargin: 50,
      ),
      child: Scrollbar(
        thumbVisibility: true,
        interactive: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    data[index],
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
