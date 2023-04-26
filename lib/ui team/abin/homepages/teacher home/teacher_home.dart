
// ignore_for_file: use_key_in_widget_constructors, must_call_super, annotate_overrides
import 'package:dujo_kerala_application/ui%20team/abin/drawer/Teacher_drawer.dart';
import 'package:dujo_kerala_application/ui%20team/abin/homepages/teacher%20home/teacher_accessories.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';






class TeacherHomeScreen extends StatefulWidget {
  // var schoolId;
  // var teacherEmail;
  // var classID;
  // TeacherHomeScreen(
  //     {required this.schoolId,
  //     required this.teacherEmail,
  //     required this.classID,
  //     super.key});
  static String routeName = 'TeacherHome';

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  String teacherImage = '';
  String teacherName = "";
  String teacherClass = "";
  String teacherClassID = "";
  String teacherSubject = "";
 
  @override
  void initState() {
    
  }

  Widget build(BuildContext context) {
    var screenSize =MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(backgroundColor: adminePrimayColor),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                 cgraident,  cgraident
                ],
              ),
            ),
            width: double.infinity,
            height: screenSize.width*0.7,
            padding:  EdgeInsets.all(15.h),
            child: Column(
              children: [
                  CircleAvatar(
                    
                        backgroundColor: Colors.white,
                        backgroundImage: const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTO3Kbs-sPqhzk0A2i0doztmT0RLa0nGmYWYw&usqp=CAU'),
                
                        radius: 80.h,
                      ),
                kWidth10,
                GoogleMonstserratWidgets(text: 'Name :', fontsize: 18.h,color: cWhite,fontWeight: FontWeight.bold),         
                 kWidth10,
                 GoogleMonstserratWidgets(text: 'ID :', fontsize:16.h ,color: cWhite,fontWeight: FontWeight.bold),           
                 GoogleMonstserratWidgets(text: 'Class : X A', fontsize: 16.h,color: cWhite,fontWeight: FontWeight.bold),
                 kHeight20, 
              ],
            ),
          ),
       

          //other will use all the remaining height of screen
           TeacherAccessories(
            // teacherSubject: teacherSubject,
            // classID:widget.classID ,
            // schoolId: widget.schoolId,
            // teacherEmail: widget.teacherEmail,
          ),
          
        ],
      ),
       drawer:Drawer(
        backgroundColor: cWhite,
        child : SingleChildScrollView(
          child: Column(
            children: [
              // const MyHeaderDrawer(),
              TeacherDrawer(context),
            ],
          ),
        ),
        ),
    );
  }
  
}

