import 'package:dujo_kerala_application/sruthi/notice_view_page.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view/colors/colors.dart';
import '../view/widgets/fonts/google_poppins.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
       
          body: ListView(children: [
        Container(
       
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color:  adminePrimayColor),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kWidth10,
              GooglePoppinsWidgets(
                fontsize: 34.h,
                text: 'Notice',
                fontWeight: FontWeight.w400,
                color: cWhite,
              ),
            ],
          ),
        ),
        kHeight20,
        Container(
          color: Colors.blue[50],
          child: ListTile(
            leading: Image(image:NetworkImage("https://media.istockphoto.com/id/926144358/photo/portrait-of-a-little-bird-tit-flying-wide-spread-wings-and-flushing-feathers-on-white-isolated.jpg?b=1&s=170667a&w=0&k=20&c=DEARMqqAI_YoA5kXtRTyYTYU9CKzDZMqSIiBjOmqDNY=")),
            title: GooglePoppinsWidgets(
              fontsize: 22.h,
              text: 'New',
              
            ),
            subtitle: 
             GooglePoppinsWidgets(
              fontsize: 14.h,
              text: ' Date: 00/00/00',

            ),
            trailing: InkWell(
              child: GooglePoppinsWidgets(text: "View", fontsize: 16.h,fontWeight: FontWeight.w300,color:Colors.green
              ),
               onTap: () {
                    Navigator.push(context,MaterialPageRoute( builder: (context) =>
                NoticeViewPage(), ));
                   
                
                  },
            ),
           
          ),
        )
      ])),
    );
  }
}
