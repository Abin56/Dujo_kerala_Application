import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/fonts/google_poppins.dart';
import '../../../sruthi/Study Materials/study_materials_list.dart';

class SubjectWiseDisplay extends StatelessWidget {
  const SubjectWiseDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
backgroundColor: adminePrimayColor,title: Text("Chapters"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(onTap: () {
                         Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>SubjectWiseDisplay()));
                                                     
                    },
                      child: Container(height: 180.h,
                      decoration: BoxDecoration(border: Border.all(width: 0.02)),
                        child: Padding(
                          padding:  EdgeInsets.only(top: 20.h),
                          child: ListTile(
                              leading: const Icon(Icons.note_rounded),
                              
                              title: GooglePoppinsWidgets(text: "Chapter 1", fontsize: 19.h),
                              
                              subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(top: 10.h),
                                    child: GooglePoppinsWidgets(
                                        text: "CMOS & NMOS", fontsize: 15.h),

                                  ),
                                   InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => StudyMaterials(subjectID:,)));
                                },
                                child: Padding(
                                  padding:  EdgeInsets.only(top: 10.h),
                                  child: GooglePoppinsWidgets(
                                    text: "Study Materials",
                                    fontsize: 16.h,
                                    color: adminePrimayColor,
                                  ),
                                ),
                              ),
                                      
                                      Padding(
                                        padding:  EdgeInsets.only(top:18.h),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            GooglePoppinsWidgets(
                                            text: "Teacher Name : Anupama", fontsize: 15.h),
                                          ],
                                        ),
                                      ),
                                ],
                              )),
                        ),
                      ),
                    );
                  }),
            ),
        ],
      ),


    );
  }
}