import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../res/components/CustomText.dart';
import '../../../../../res/components/color.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final Set<Marker> _markers = {};
  final LatLng _center = const LatLng(37.42796133580664, -122.085749655962);
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        const Marker(
          markerId: MarkerId('marker_1'),
          position: LatLng(37.42796133580664, -122.085749655962),
          infoWindow: InfoWindow(
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
            fweight: FontWeight.w700,
            fontColor: AppColors.blackColor,
          ),
          const Spacer(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                data:
                    'Lorem ipsum dolor sit amet consectetur. Enim justo tellus odio vitae ullamcorper adipiscing est Phasellus proin no.',
                fSize: 14,
                fweight: FontWeight.w400,
                fontColor: AppColors.tileTextColor,
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
                        blurRadius: 1)
                  ],
                  color: AppColors.whiteTextColor,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      data: 'Contact Support',
                      fSize: 16,
                      fweight: FontWeight.w700,
                      fontColor: AppColors.tileTextColor,
                    ),
                    CustomListTile(
                      title: 'Contact Number',
                      subTitle: '+00 1234567890',
                      icon: CupertinoIcons.phone,
                    ),
                    CustomListTile(
                      title: 'Email Address',
                      subTitle: 'wheelmansupport@gmail.com',
                      icon: CupertinoIcons.mail,
                    ),
                    CustomListTile(
                      title: 'Address',
                      subTitle: '17/K/10 Mumbai, Maharastra',
                      icon: CupertinoIcons.location_solid,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const CustomText(
                data: 'Location On Map',
                fSize: 18,
                fweight: FontWeight.w700,
                fontColor: AppColors.blackTextColor,
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
                    mapType: MapType.satellite,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    markers: _markers,
                    onMapCreated: _onMapCreated,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: Image.asset(
                  'assets/images/appicon.png',
                  height: 100,
                  width: 100,
                ),
              ),
            ],
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
  const CustomListTile(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: const Color(0xFFF0F7FA),
            borderRadius: BorderRadius.circular(100)),
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
        fweight: FontWeight.w400,
        fontColor: AppColors.tileTextColor,
      ),
      subtitle: CustomText(
        data: subTitle,
        fSize: 15,
        fweight: FontWeight.w700,
        fontColor: AppColors.blackTextColor,
      ),
    );
  }
}
