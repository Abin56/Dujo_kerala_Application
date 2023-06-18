import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../colors/colors.dart';
import '../../widgets/fonts/google_poppins.dart';
import '../Subject/chapterdisplay.dart';



class StudyMaterials extends StatelessWidget {
  const StudyMaterials({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white70,
            appBar: AppBar(
              title: Row(
                children:  [
           
                  Text("Study Materials".tr),
                ],
              ),
              backgroundColor: adminePrimayColor,
            ),
            body: ListView.separated(
                itemCount: 8,
                 separatorBuilder: ((context, index) {
        return kHeight10;
      }),
                itemBuilder: (BuildContext context, int index) {
                  return ListileCardChapterWidget(leading:  const Image(
                                image: NetworkImage(
                                    "https://media.istockphoto.com/id/926144358/photo/portrait-of-a-little-bird-tit-flying-wide-spread-wings-and-flushing-feathers-on-white-isolated.jpg?b=1&s=170667a&w=0&k=20&c=DEARMqqAI_YoA5kXtRTyYTYU9CKzDZMqSIiBjOmqDNY=")), subtitle:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              
                                Padding(
                                  padding:  EdgeInsets.only(top: 5.h),
                                  child: GooglePoppinsWidgets(
                                    fontsize: 15.h,
                                    text: 'Chapter 3',fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                    padding:  EdgeInsets.only(top: 5.h),
                                  child: GooglePoppinsWidgets(
                                    fontsize: 15.h,
                                    text: 'Topic',
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Padding(
                                      padding:  EdgeInsets.only(top: 5.h),
                                  child: GooglePoppinsWidgets(
                                    fontsize: 14.h,
                                    text: 'Pdf',
                                                                    fontWeight: FontWeight.bold
                                                        
                                  ),
                                ),kHeight10,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GooglePoppinsWidgets(
                                        text: "Posted By :", fontsize: 15.h),
                                        GooglePoppinsWidgets(
                                        text: "Anupama", fontsize: 15.h,fontWeight: FontWeight.bold,),
                                  ],
                                ),
                              ],
                            ), title: Padding(
                              padding:  EdgeInsets.only(top: 10.h),
                              child: GooglePoppinsWidgets(
                                fontsize: 20.h,
                                text: 'Chemistry',fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: InkWell(
                              child: GooglePoppinsWidgets(
                                  text: "View".tr,
                                  fontsize: 16.h,
                                  fontWeight: FontWeight.w500,
                                  color: adminePrimayColor),
                              onTap: () {},
                            ),
                          );}
         ))) ;
                }
  }



