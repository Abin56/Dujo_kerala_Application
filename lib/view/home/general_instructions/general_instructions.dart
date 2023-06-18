import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/general_instructions/general_instructions_controller.dart';

class GeneralInstruction extends StatelessWidget {
  GeneralInstruction({
    super.key,
  });

  final GeneralInstructionsController generalInstructionsController =
      Get.put(GeneralInstructionsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: adminePrimayColor,
        title:
            GooglePoppinsWidgets(text: "General Instructions".tr, fontsize: 20.h),
      ),
      body: FutureBuilder(
          future: generalInstructionsController.getInstruction(),
          builder: (context, snapshot) {
            return Obx(() => generalInstructionsController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : generalInstructionsController.listOfGeneralIModel.isEmpty
                    ? const Center(
                        child: Text("No data found"),
                      )
                    : ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          Container(
                            height: 200,
                            color: Colors.lightBlue[900],
                            child: Stack(children: [
                              Opacity(
                                  opacity: 0.5,
                                  child: ClipPath(
                                    clipper: WaveClipper(),
                                    child: Container(
                                      color: Colors.white,
                                      height: 150,
                                    ),
                                  )),
                              ClipPath(
                                clipper: WaveClipper(),
                                child: Container(
                                  color: Colors.blueGrey,
                                  height: 130,
                                  alignment: Alignment.bottomCenter,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  maxRadius: 40,
                                ),
                              ),
                              Obx(() => Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Text(
                                        generalInstructionsController
                                            .schoolName.value,
                                        style: GoogleFonts.adamina(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  )),
                            ]),
                          ),
                          kHeight40,
                          Center(
                              child: Text(
                            "General Instructions",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                decoration: TextDecoration.underline),
                          )),
                          kHeight20,
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: SingleChildScrollView(
                              child: ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        const SizedBox(width: 10),
                                        Row(children: [
                                          Icon(
                                            Icons.circle,
                                            size: 8.h,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.h),
                                              child: Text(
                                                generalInstructionsController
                                                    .listOfGeneralIModel[index]
                                                    .instruction,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18),
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return kHeight20;
                                  },
                                  itemCount: generalInstructionsController
                                      .listOfGeneralIModel.length),
                            ),
                          ),
                          kHeight20,
                          Container(
                            width: double.infinity,
                            color: adminePrimayColor,
                            child: const Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(" "),
                                )),
                          )
                        ],
                      ));
          }),
    );
  }
}

class InstructionTextWidget extends StatelessWidget {
  const InstructionTextWidget({
    super.key,
    required this.text,
    required this.count,
  });
  final String text;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Flexible(
        child: Text(
          "$count.  $text",
          style: GoogleFonts.openSans(fontSize: 18),
          softWrap: true,
        ),
      ),
    ]);
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    {
      debugPrint(size.width.toString());
      var path = Path();
      path.lineTo(0, size.height);
      var firstStart = Offset(size.width / 5, size.height);
      //first point
      var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
      //second point
      path.quadraticBezierTo(
          firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
      var secondStart =
          Offset(size.width - (size.width / 3.24), size.height - 105);
      //third
      var secondEnd = Offset(size.width, size.height - 10);
      //fourth
      path.quadraticBezierTo(
          secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
      //
      path.lineTo(size.width, 0);
      path.close();
      return path;
    }
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
