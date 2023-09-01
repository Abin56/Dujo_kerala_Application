import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

import '../../../model/notice_model/school_level_notice_model.dart';

class NoticeClassDisplayPage extends StatelessWidget {
  const NoticeClassDisplayPage({super.key, required this.noticeModel});
  final SchoolLevelNoticeModel noticeModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: GooglePoppinsWidgetsNotice(
            fontsize: 20.h,
            text: 'Notices'.tr,
          ),
        ),
        body: ListView(children: [
          Container(
            width: 90.w,
            height: 900.h,
            decoration: const BoxDecoration(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  kHeight30,
                  GestureDetector(
                    onTap: () {
                      if (noticeModel.imageUrl.isNotEmpty) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PhotoViewerWidget(imageurl: noticeModel.imageUrl),
                        ));
                      }
                    },
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: Image(
                        image: noticeModel.imageUrl.isEmpty
                            ? const NetworkImage(
                                "https://media.istockphoto.com/id/926144358/photo/portrait-of-a-little-bird-tit-flying-wide-spread-wings-and-flushing-feathers-on-white-isolated.jpg?b=1&s=170667a&w=0&k=20&c=DEARMqqAI_YoA5kXtRTyYTYU9CKzDZMqSIiBjOmqDNY=")
                            : NetworkImage(noticeModel.imageUrl),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  kHeight30,
                  Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Container(
                            height: 600.h,
                            width: 360.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: Padding(
                              padding: EdgeInsets.all(8.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GooglePoppinsWidgetsNotice(
                                        text: noticeModel.heading,
                                        fontsize: 22.h,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                  kHeight20,
                                  GooglePoppinsWidgetsNotice(
                                      text:
                                          "This is to inform all the students that  ${noticeModel.customContent}  will be  conducted on ${noticeModel.dateofoccation}, at the ${noticeModel.venue} with various cultural programs. The ${noticeModel.chiefGuest} will grace the occasion. Students who would like to participate in various programs should contact their\nrespective class teacher by ${noticeModel.dateOfSubmission}.",
                                      fontsize: 19.h),
                                  kHeight30,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GooglePoppinsWidgetsNotice(
                                        text:
                                            "Date : ${noticeModel.publishedDate}",
                                        fontsize: 17.h,
                                      ),
                                    ],
                                  ),
                                  kHeight10,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GooglePoppinsWidgetsNotice(
                                          text: "Signed by: Principal",
                                          fontsize: 17.h)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          )
        ]),
      ),
    );
  }
}

class GooglePoppinsWidgetsNotice extends StatelessWidget {
  String text;
  double fontsize;
  FontWeight? fontWeight;
  Color? color;
  VoidCallback? onTap;
  GooglePoppinsWidgetsNotice({
    required this.text,
    required this.fontsize,
    this.fontWeight,
    this.color,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

class PhotoViewerWidget extends StatelessWidget {
  const PhotoViewerWidget({super.key, required this.imageurl});
  final String imageurl;

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      loadingBuilder: (context, event) => const Center(
        child: CircularProgressIndicator(),
      ),
      imageProvider: NetworkImage(
        imageurl,
      ),
    );
  }
}
