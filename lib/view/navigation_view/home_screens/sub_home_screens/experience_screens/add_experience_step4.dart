import 'package:airjood/model/FormData.dart';
import 'package:airjood/res/components/mainbutton.dart';
import 'package:airjood/res/components/maintextfild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../model/reels_model.dart';
import '../../../../../res/components/CustomText.dart';
import '../../../../../res/components/color.dart';
import '../../../../../view_model/add_experiance_view_model.dart';
import '../../../../../view_model/get_reels_view_model.dart';
import '../../../../../view_model/user_view_model.dart';
import '../../screen_widget/radio_widget.dart';
import '../../screen_widget/select_laqta_reels.dart';

class AddExperienceStep4 extends StatefulWidget {
  final Function? onTap;

  const AddExperienceStep4({super.key, this.onTap});

  @override
  State<AddExperienceStep4> createState() => _AddExperienceStep4State();
}

class _AddExperienceStep4State extends State<AddExperienceStep4> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  int currentPage = 0;

  Future<void> fetchData() async {
    UserViewModel().getToken().then((value) async {
      final reelsProvider = Provider.of<ReelsViewModel>(context, listen: false);
      await reelsProvider.reelsGetApi(value!, currentPage);
      reelsProvider.reelsData.data?.data?.forEach((element) {
        data.add(element);
      });
      setState(() {});
    });
  }

  final List<AddonData> forms = [
    AddonData(
        name: '',
        description: '',
        latqaId: '',
        laqtaImage: '',
        priceType: '',
        price: ''),
  ];

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AddExperianceViewModel>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              data: 'Addons',
              color: AppColors.blackTextColor,
              fSize: 22,
              fontWeight: FontWeight.w700,
            ),
            const CustomText(
              data: 'You can add extra facilities from here',
              color: AppColors.secondTextColor,
              fSize: 12,
              fontWeight: FontWeight.w300,
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: forms.length,
              itemBuilder: (context, index) {
                return formWidget(index);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  forms.add(AddonData(
                    name: '',
                    description: '',
                    latqaId: '',
                    laqtaImage: '',
                    priceType: '',
                    price: '',
                  ));
                });
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: AppColors.blueShadeColor,
                  ),
                  CustomText(
                    data: 'Add More Addon',
                    color: AppColors.blueShadeColor,
                    fSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                widget.onTap!(forms);
              },
              child: MainButton(
                loading: authViewModel.addExperianceLoadings,
                data: 'Save & Upload',
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ReelsData> data = [];

  Widget formWidget(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ExpansionTile(
        collapsedBackgroundColor: Colors.blue.shade50,
        collapsedShape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.transperent,
          ),
        ),
        collapsedIconColor: AppColors.mainColor,
        shape: InputBorder.none,
        title: CustomText(
          data: 'Addon ${index + 1}',
          fontWeight: FontWeight.w700,
          fSize: 18,
          color: AppColors.mainColor,
        ),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.textFildBorderColor),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainTextFild(
                    initialValue: forms[index].name,
                    labelText: 'Name',
                    maxLines: 1,
                    onChanged: (value) {
                      setState(() {
                        forms[index].name = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MainTextFild(
                    initialValue: forms[index].description,
                    labelText: 'Description',
                    maxLines: 3,
                    onChanged: (value) =>
                        setState(() => forms[index].description = value),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        constraints: BoxConstraints.expand(
                            height: MediaQuery.of(context).size.height * 0.85,
                            width: MediaQuery.of(context).size.width),
                        isScrollControlled: true,
                        builder: (_) => SelectLaqtaReels(
                          item: data,
                          onTap: (ReelsData value) {
                            Navigator.pop(context);
                            forms[index].latqaId = value.id.toString();
                            forms[index].laqtaImage =
                                value.videoThumbnailUrl.toString();
                            setState(() {});
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFDADDEE),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            'assets/icons/uploadLaqta.png',
                            height: 20,
                          ),
                          const Spacer(),
                          const CustomText(
                            data: 'Add Latqa',
                            fSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainColor,
                          ),
                          const Spacer(),
                          forms[index].laqtaImage == ''
                              ? const SizedBox(
                                  width: 30,
                                )
                              : Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        forms[index].laqtaImage,
                                        height: 30,
                                        width: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomText(
                    data: 'Addons Price',
                    color: AppColors.blackTextColor,
                    fSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  RadioWidget(
                    firstData: 'Price Per Person',
                    secondData: 'Price Per Experience',
                    selectedOption: forms[index].priceType,
                    setValue: ((val) {
                      forms[index].priceType = val;
                      setState(() {});
                    }),
                  ),
                  MainTextFild(
                    keyboardType: TextInputType.number,
                    initialValue: forms[index].price,
                    labelText: "Enter price",
                    maxLines: 1,
                    onChanged: (value) =>
                        setState(() => forms[index].price = value),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
