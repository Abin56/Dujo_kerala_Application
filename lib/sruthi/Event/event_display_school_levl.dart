
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controllers/userCredentials/user_credentials.dart';
import '../../view/widgets/fonts/google_poppins.dart';

class EventDisplaySchoolLevel extends StatelessWidget {
   EventDisplaySchoolLevel({super.key, required this.eventName, required this.eventDate, required this.eventDescription, required this.eventVenue, required this.signedBy}); 

  String eventName; 
  String eventDescription; 
  String eventDate; 
  String eventVenue; 
  String signedBy;

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
        child: GestureDetector( 
          onTap: (){
            
          print('classid: ${UserCredentialsController.classId}, schoolid: ${UserCredentialsController.schoolId}, batchid: ${UserCredentialsController.batchId}');
                                                      
          },
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
                              GooglePoppinsWidgets(text: eventName, fontsize: 22.h),
                              Icon(Icons.event_note)
                            ],),
                       
                        kHeight50,
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [GooglePoppinsWidgets(text: "Description : ", fontsize: 18.h,fontWeight: FontWeight.w200,)],),kHeight20,
                        
                        
                         
                                               GooglePoppinsWidgets(
                                                  text: "${eventDescription}", fontsize: 18.h),
                                            kHeight10,
                                            Row(children: [
                                              GooglePoppinsWidgets(text: "Date : ${eventDate}", fontsize: 18.h,fontWeight: FontWeight.w200),
                                              
                                            ],),kHeight10,
                                            Row(children: [
                                              GooglePoppinsWidgets(text: "Venue : ${eventVenue}", fontsize: 18.h,fontWeight: FontWeight.w200),
                                              
                                            ],),kHeight30,
                                             Row( mainAxisAlignment: MainAxisAlignment.end,
                                             children: [
                                              GooglePoppinsWidgets(text: "Signed By : ${signedBy}", fontsize: 18.h,fontWeight: FontWeight.w200),
                                              
                                            ],),
                                              ],
                       ),
                     ),
                   
                  
                  ),
              ),
            ],
          ),
        ),
      ),
        
    ],
  ),
)

      
    );
  }
}
