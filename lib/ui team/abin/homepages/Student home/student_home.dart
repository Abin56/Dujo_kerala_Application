
// ignore_for_file: use_key_in_widget_constructors, must_call_super, annotate_overrides, non_constant_identifier_names


import 'package:dujo_kerala_application/ui%20team/abin/homepages/Student%20home/student_accessories.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../drawer/student_drawer.dart';





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
          appBar: AppBar(elevation:0,backgroundColor: adminePrimayColor,),
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
          const StudentAccessories(
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
              StudentDrawer(context),
            ],
          ),
        ),
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
Widget MenuItem(int id, String image, String title, bool selected, onTap) {
  return Material(
    color: Colors.white,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(image))),
              ),
            ),
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ))
          ],
        ),
      ),
    ),
  );

}


