
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDisplayClassLevel extends StatelessWidget {
  const EventDisplayClassLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: adminePrimayColor,title: Text("Events"),),
      body:Container(
        
  height: double.infinity, // set the height to fill available space
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
  
    children: [
      
      kHeight30,
      Expanded(
        child: ListView(
          children: [
            Padding(
              padding:  EdgeInsets.all(8.h),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.h),color:Colors.blue[50] ,),
                height: 650.h,
                width: 360.w,
               child: 
                   Padding(
                     padding:  EdgeInsets.all(10.h),
                     child: Column(
                       children: [
                         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            GooglePoppinsWidgets(text: "School Day", fontsize: 22.h),
                            Icon(Icons.event_note)
                          ],),
                     
                      kHeight50,
                      Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [GooglePoppinsWidgets(text: "Description : ", fontsize: 18.h,fontWeight: FontWeight.w200,)],),kHeight20,
                      
                      
                       
                                             GooglePoppinsWidgets(
                                                text: "This is to inform all the students that " + " __________________  will be  conductod" +" __________________  at __________________ with various cultural programmes.______________ will be grace the occasion. Student who would like to occasion in various programme should contact their\nrespective classteacher latest by __________________ .", fontsize: 18.h),
                                          kHeight10,
                                          Row(children: [
                                            GooglePoppinsWidgets(text: "Date : 00/00/00", fontsize: 18.h,fontWeight: FontWeight.w200),
                                            
                                          ],),kHeight10,
                                          Row(children: [
                                            GooglePoppinsWidgets(text: "Venue :School Auditorium", fontsize: 18.h,fontWeight: FontWeight.w200),
                                            
                                          ],),kHeight30,
                                           Row( mainAxisAlignment: MainAxisAlignment.end,
                                           children: [
                                            GooglePoppinsWidgets(text: "Signed By : Head Master", fontsize: 18.h,fontWeight: FontWeight.w200),
                                            
                                          ],),
                                            ],
                     ),
                   ),
                 
                
                ),
            ),
          ],
        ),
      ),
        
    ],
  ),
)

      
    );
  }
}
