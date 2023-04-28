import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view/colors/colors.dart';

import '../../view/widgets/fonts/google_poppins.dart';


class StudyMaterials extends StatelessWidget {
  const StudyMaterials({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                
                  Text("Study Materials"),
                ],
              ),
              backgroundColor: adminePrimayColor,
            ),
            body: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.4))),
                        child: ListTile(
                          leading: Image(
                              image: NetworkImage(
                                  "https://media.istockphoto.com/id/926144358/photo/portrait-of-a-little-bird-tit-flying-wide-spread-wings-and-flushing-feathers-on-white-isolated.jpg?b=1&s=170667a&w=0&k=20&c=DEARMqqAI_YoA5kXtRTyYTYU9CKzDZMqSIiBjOmqDNY=")),
                          title: GooglePoppinsWidgets(
                            fontsize: 22.h,
                            text: 'Chemistry',
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GooglePoppinsWidgets(
                                fontsize: 14.h,
                                text: 'Chapter 3',
                              ),
                              GooglePoppinsWidgets(
                                fontsize: 14.h,
                                text: 'Topic',
                              ),
                              GooglePoppinsWidgets(
                                fontsize: 14.h,
                                text: 'Pdf',
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GooglePoppinsWidgets(
                                      text: "Posted By : Anupama", fontsize: 15.h),
                                ],
                              ),
                            ],
                          ),
                          trailing: InkWell(
                            child: GooglePoppinsWidgets(
                                text: "View",
                                fontsize: 16.h,
                                fontWeight: FontWeight.w300,
                                color: Colors.blue),
                            onTap: () {},
                          ),
                        ),
                      ),
                      kHeight20,
                    ],
                  );
                })));
  }
}
