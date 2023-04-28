
import 'package:dujo_kerala_application/sruthi/Notice/notice_class_display_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view/constant/sizes/sizes.dart';
import '../../../view/widgets/fonts/google_poppins.dart';

class ClassLevelNoticePage extends StatelessWidget {
  const ClassLevelNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[50],
                          border: Border(bottom: BorderSide(width: 0.09))),
                      child: ListTile(
                        leading: Image(
                            image: NetworkImage(
                                "https://media.istockphoto.com/id/926144358/photo/portrait-of-a-little-bird-tit-flying-wide-spread-wings-and-flushing-feathers-on-white-isolated.jpg?b=1&s=170667a&w=0&k=20&c=DEARMqqAI_YoA5kXtRTyYTYU9CKzDZMqSIiBjOmqDNY=")),
                        title: GooglePoppinsWidgets(
                          fontsize: 22.h,
                          text: 'New',
                        ),
                        subtitle: GooglePoppinsWidgets(
                          fontsize: 14.h,
                          text: ' Date: 00/00/00',
                        ),
                        trailing: InkWell(
                          child: GooglePoppinsWidgets(
                              text: "View",
                              fontsize: 16.h,
                              fontWeight: FontWeight.w300,
                              color: Colors.blue),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NoticeClassDisplayPage(),
                                ));
                          },
                        ),
                      ),
                    ),
                    kHeight10,
                  ],
                );
              })
    );
  }
}