import 'package:airjood/view_model/get_contactus_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../../data/response/status.dart';
import '../../../../../res/components/CustomText.dart';
import '../../../../../res/components/color.dart';
import '../../../../../res/components/custom_shimmer.dart';
import '../../../../../view_model/user_view_model.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final Set<Marker> _markers = {};

  @override
  void initState() {
    UserViewModel().getToken().then((value) {
      Provider.of<GetContactUsViewModel>(context, listen: false)
          .getContactUsApi(value!);
      setState(() {});
    });
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller, double lat, double lng) {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('marker_1'),
          position: LatLng(lat, lng),
          infoWindow: const InfoWindow(
            title: 'Marker Title',
            snippet: 'Marker Snippet',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
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
              size: 35,
              weight: 2,
            ),
          ),
          const SizedBox(width: 10),
          const CustomText(
            data: 'Contact Us',
            fSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
          const Spacer(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<GetContactUsViewModel>(
            builder: (context, value, child) {
              switch (value.getContactUsData.status) {
                case Status.LOADING:
                  return const BookNowShimmer();
                case Status.ERROR:
                  return const BookNowShimmer();
                case Status.COMPLETED:
                  final contactData = value.getContactUsData.data?.data;
                  final lat = double.tryParse(contactData?.latitude ?? '23.0555648') ?? 0.0;
                  final lng = double.tryParse(contactData?.longitude ?? '72.5188608') ?? 0.0;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data: contactData?.siteDescription,
                        fSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.tileTextColor,
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.greyTextColor.withOpacity(0.3),
                              offset: const Offset(0, 0),
                              blurRadius: 1,
                            ),
                          ],
                          color: AppColors.whiteTextColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              data: 'Contact Support',
                              fSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.tileTextColor,
                            ),
                            CustomListTile(
                              title: 'Contact Number',
                              subTitle: '${contactData?.contactNumber}',
                              icon: CupertinoIcons.phone,
                            ),
                            CustomListTile(
                              title: 'Email Address',
                              subTitle: '${contactData?.emailAddress}',
                              icon: CupertinoIcons.mail,
                            ),
                            CustomListTile(
                              title: 'Address',
                              subTitle: '${contactData?.address}',
                              icon: CupertinoIcons.location_solid,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      const CustomText(
                        data: 'Location On Map',
                        fSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackTextColor,
                      ),
                      const SizedBox(height: 15),
                      Container(
                        height: 200,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GoogleMap(
                            mapType: MapType.hybrid,
                            myLocationEnabled: true,
                            myLocationButtonEnabled: true,
                            mapToolbarEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(lat,lng),
                              zoom: 10.0,
                            ),
                            markers: _markers,
                            onMapCreated: (controller) {
                              _onMapCreated(controller, lat,lng);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Center(
                        child: Image.asset(
                          'assets/images/appicon.png',
                          height: 80,
                          width: 80,
                        ),
                      ),
                      const SizedBox(height: 25),
                    ],
                  );
                default:
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;

  const CustomListTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F7FA),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 25,
            color: AppColors.textFildHintColor,
          ),
        ),
      ),
      title: CustomText(
        data: title,
        fSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.tileTextColor,
      ),
      subtitle: CustomText(
        data: subTitle,
        fSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.blackTextColor,
      ),
    );
  }
}
