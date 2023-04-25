
// ignore_for_file: use_key_in_widget_constructors, must_call_super, annotate_overrides
import 'package:dujo_kerala_application/ui%20team/abin/homepages/Student%20home/student_accessories.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';





class StudentHomeScreen extends StatefulWidget {
  // var schoolId;
  // 
  // var classID;
  // TeacherHomeScreen(
  //     {required this.schoolId,
  //     
  //     required this.classID,
  //     super.key});
  static String routeName = '';

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  


  Widget build(BuildContext context) {
    var screenSize =MediaQuery.of(context).size;
        return Scaffold(
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
            height: screenSize.width*0.8,
            padding:  EdgeInsets.all(15.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "",
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: screenSize.width/25,
                                fontWeight: FontWeight.bold),
                          ),
                           kHeight20,
                          Text(
                            'ID : \n'
                            'Class : X A',
                            style: GoogleFonts.poppins(
                                color: Colors.white.withOpacity(0.6),
                                 fontSize: screenSize.width/35,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                        SizedBox
                        (
                        width: 230.w,
                      ),
                       CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: const NetworkImage(''),
                
                        radius: screenSize.width/10,
                      ),
                    ],
                  ),
                ),
                 kHeight20,
                const Divider(color: Colors.white, height: 10,),
                 kHeight20,
               kHeight20,
                SizedBox(
                  height: screenSize.width*0.3,

                //   child: Column(
                //     children: [
                //       Text(
                //         timeText,
                //         style: GoogleFonts.montserrat(
                //             color: Colors.white,
                //             fontSize: screenSize .width/20,
                //             fontWeight: FontWeight.bold),
                //       ),
                  
                // kHeight20,
                // Text(
                //   dateText,
                //   style: GoogleFonts.montserrat(
                //       color: const Color.fromARGB(255, 255, 255, 255),
                //       fontSize: screenSize.width/35,
                //       fontWeight: FontWeight.w700),
                // ),
                //   ],
                 // ),
                ),
              ],
            ),
          ),

          //other will use all the remaining height of screen
          const StudentAccessories(
            // teacherSubject: teacherSubject,
            // classID:widget.classID ,
            // schoolId: widget.schoolId,
            // teacherEmail: widget.teacherEmail,
          ),
        ],
      ),
    );
  }
  // Future<void> getTeacherDetails() async {
  //   var vari = await FirebaseFirestore.instance
  //       .collection("SchoolListCollection")
  //       .doc(widget.schoolId)
  //       .collection("Teachers")
  //       .doc(widget.teacherEmail)
  //       .get();
  //   setState(() {
  //     teacherName = vari.data()!['teacherName'];
  //     teacherImage = vari.data()!['teacherImage'];
  //     teacherClassID = vari.data()!['classIncharge'];
  //   });
  //   log(teacherImage.toString());
  // }

  // Future<void> getTeacherClass() async {
  //   var vari = await FirebaseFirestore.instance
  //       .collection("SchoolListCollection")
  //       .doc(widget.schoolId)
  //       .collection("Classes")
  //       .doc(teacherClassID)
  //       .get();
  //   setState(() {
  //     teacherClass = vari.data()!['className'];
  //   });
  //   log(vari.toString());
  // }
}

