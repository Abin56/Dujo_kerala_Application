import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view/colors/colors.dart';
import '../../view/constant/sizes/sizes.dart';
import '../../view/widgets/fonts/google_poppins.dart';
import '../../widgets/Iconbackbutton.dart';

class HomeWorkDisplay extends StatelessWidget {
  const HomeWorkDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [GooglePoppinsWidgets(text: "HomeWork", fontsize: 25.h)],
          ),
          backgroundColor: adminePrimayColor,
        ),
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
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.h) ,),
                height: 650.h,
                width: 360.w,
               child: 
                   Padding(
                     padding:  EdgeInsets.all(10.h),
                     child: Column(
                       children: [
                         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            GooglePoppinsWidgets(text: "HomeWork", fontsize: 22.h),
                           
                          ],),
                     
                      kHeight50,
                      Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [GooglePoppinsWidgets(text: "Description : ", fontsize: 18.h,fontWeight: FontWeight.w200,)],),kHeight20,
                      
                      
                       
                                             GooglePoppinsWidgets(
                                                text: "Homework.” Merriam-Webster.com Dictionary, Merriam-Webster, . Accessed 27 Apr. 2023.", fontsize: 19.h,),
                                          kHeight10,
                                         
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
