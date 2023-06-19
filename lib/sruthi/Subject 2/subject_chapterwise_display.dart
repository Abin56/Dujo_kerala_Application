import 'package:dujo_kerala_application/sruthi/Study%20Materials/study_materials_list.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

class SubjectWiseDisplay extends StatelessWidget {
  const SubjectWiseDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white54,
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: const Text("Chapters"),
        ),
        body: Container(
          color: Colors.white54,
          child: ListView.separated(
            itemCount: 7,
            separatorBuilder: (BuildContext context, int index) => kHeight10,
            itemBuilder: (BuildContext context, int index) {
              return ListileCardChapterWidget(leading: const Icon(Icons.note_rounded), title: GooglePoppinsWidgets(
            text: "Chapter 1", fontsize: 20.h,fontWeight: FontWeight.bold,), subtitle:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: GooglePoppinsWidgets(
                  text: "CMOS & NMOS", fontsize: 15.h,fontWeight: FontWeight.bold,),
            ),
            InkWell(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const StudyMaterials()));
              },
              child: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: GooglePoppinsWidgets(
                  text: "Study Materials".tr,
                  fontsize: 16.h,
                  color: adminePrimayColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 18.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GooglePoppinsWidgets(
                      text: "Teacher Name : ",
                      fontsize: 15.h,),
                       GooglePoppinsWidgets(
                      text: "Anupama",
                      fontsize: 15.h,fontWeight: FontWeight.bold,),
                ],
              ),
            ),
          ],
          ) , trailing: null,);
            },
          ),
        ),
      ),
    );
  }
}

class ListileCardChapterWidget extends StatelessWidget {
   ListileCardChapterWidget({
    
    required this.leading,
    required this.title,
    required this.subtitle,
    this.trailing,
    super.key,
  });

Widget leading;
Widget title;
Widget subtitle;
Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card
    (
      child: ListTile(shape: const BeveledRectangleBorder(side:BorderSide(color: cWhite) ),
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing,),
    );
  }
}