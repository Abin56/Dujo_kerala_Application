import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/search/search_school/search_school_searchdeligate.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../controllers/schoo_selection_controller/school_class_selection_controller.dart';
import '../../../widgets/fonts/google_monstre.dart';
import '../../../widgets/fonts/google_poppins.dart';

class SearchSchoolScreen extends StatelessWidget {
  SearchSchoolScreen({super.key});
  final SchoolClassSelectionController schoolClassSelectionController =
      Get.put(SchoolClassSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: GestureDetector(
              onTap: () async {
                await schoolClassSelectionController.fetchAllSchoolData();
                if (context.mounted) {
                  _showSearch(context);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GoogleMonstserratWidgets(
                    text: "Search  School".tr,
                    fontsize: 23,
                  ),
                  const Icon(
                    Icons.search,
                    size: 30,
                    weight: 300,
                  )
                ],
              ),
            ),
          ),
          kHeight50,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ContainerImage(
                      height: 80.h,
                      width: 110.w,
                      imagePath: 'assets/images/leptonlogo.png'),
                ],
              ),
              GoogleMonstserratWidgets(
                  text: "Welcome To".tr,
                  fontsize: 25,
                  fontWeight: FontWeight.bold),
              kHeight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GoogleMonstserratWidgets(
                    text: 'COSTECH',
                    fontsize: 20,
                    color: const Color.fromARGB(255, 230, 18, 3),
                    fontWeight: FontWeight.bold,
                  ),
                  GoogleMonstserratWidgets(
                    text: ' DuJo',
                    fontsize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              kHeight20,
              GoogleMonstserratWidgets(
                  text: "Set Up Your App".tr,
                  fontsize: 20,
                  fontWeight: FontWeight.w600),
              kHeight10,
              GestureDetector(
                onTap: () async {
                  await schoolClassSelectionController.fetchAllSchoolData();
                  if (context.mounted) {
                    _showSearch(context);
                  }
                },
                child: LottieBuilder.network(
                    'https://assets2.lottiefiles.com/packages/lf20_itvvjtah.json'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                
                children: [
                  GooglePoppinsWidgets(text: "Developed by", fontsize: 12),
                  kHeight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/leptonlogo.png'))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GoogleMonstserratWidgets(
                            text: "Lepton Communications",
                            fontsize: 13,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      )),
    );
  }

  Future<void> _showSearch(BuildContext context) async {
    await showSearch(context: context, delegate: SearchSchoolBar());
  }
}
