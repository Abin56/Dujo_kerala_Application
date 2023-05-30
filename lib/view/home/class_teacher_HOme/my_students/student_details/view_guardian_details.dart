import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/class_teacher_HOme/my_students/student_details/view_students_details.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewGuardianDetails extends StatefulWidget {
   ViewGuardianDetails({super.key, required this.studentID, required this.documentSnapshot});

  String studentID;
  DocumentSnapshot? documentSnapshot;

  @override
  State<ViewGuardianDetails> createState() => _ViewGuardianDetailsState();
}

class _ViewGuardianDetailsState extends State<ViewGuardianDetails> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Guardian Details'),
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
          .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId)
                .collection('classes')
                .doc(UserCredentialsController.classId)
                .collection('GuardianCollection')
          .where('studentID', isEqualTo: widget.studentID)
          .get(),
          builder: (context, snapshot) {

            //  if(snapshot.data!.docs[0].exists){
            //   return const Text('data');
            // }

            
            if(snapshot.hasError){
              return const Text('data');
            }
            if(snapshot.hasData){
             
               return ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButtonBackWidget(color: cblack,),
                Stack(
                  children: [
                 
                SizedBox(
                 // color: cblue,
                   height: screenSize.height,
                      width: double.infinity,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 55.h,left: 20.h,
                      right: 20.h,bottom: 30.h),
                    height: screenSize.height,
                    width: double.infinity,
                    decoration:  BoxDecoration(
                      color: Colors.blue.withOpacity(0.9),
                      borderRadius: BorderRadius.all(
                      Radius.circular(22.w)
                      
                        )
                        ),
                    child: 
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                             SizedBox(height: 110.h,),
                            // SizedBox(width: 20.h,),
                            // SizedBox(width: 20.h,),

                        Row(
                          
                          children: [
                            
                             const Icon(Icons.person_4,color: cWhite,),
                             SizedBox(width: 20.h,),

                             TextWidget(text: 'Student Name : ${snapshot.data!.docs[0]['guardianName']}',),
                          ],
                        ),

                        const Divider(color: cWhite,),
                          //SizedBox(width: 20.h,),
                             //SizedBox(width: 20.h,),        
                        Row(
                          children: [
                            const Icon(Icons.phone,color: cWhite,),
                             SizedBox(width: 20.h,),
                            
                             TextWidget(text: 'Guardian Phone Number : ${snapshot.data!.docs[0]['guardianPhoneNumber']}',),
                          ],
                        ),

                             const Divider(color: cWhite,),
                              //SizedBox(width: 20.h,),
                           //  SizedBox(width: 20.h,),

                        //  Row(
                        //    children: [
                        //     const Icon(Icons.phone_android_sharp,color: cWhite,),
                        //      SizedBox(width: 20.h,),

                        //      const TextWidget(text: 'Student Phone Number : ',),
                        //    ],
                        //  ),

                        //        const Divider(color: cWhite,),
                        //         SizedBox(width: 20.h,),
                        //      SizedBox(width: 20.h,),

                        Row(
                          children: [
                            const Icon(Icons.mail,color: cWhite,),
                             SizedBox(width: 20.h,),

                             TextWidget(text: 'Guardian Email : ${snapshot.data!.docs[0]['guardianEmail']}',),
                          ],
                        ),


                         const Divider(color: cWhite,),
                          //SizedBox(width: 20.h,),
                            // SizedBox(width: 20.h,),

                        Row(
                          children: [
                            const Icon(Icons.bloodtype,color: cWhite,),
                             SizedBox(width: 20.h,),

                              TextWidget(text: 'Place: ${snapshot.data!.docs[0]['place']}',),
                          ],
                        ),
                        
                           const Divider(color: cWhite,),
                            //SizedBox(width: 20.h,),
                            // SizedBox(width: 20.h,),

                         //SizedBox(width: 20.h,),
                            // SizedBox(width: 20.h,),
                           ///
                       
                         ],
                        ), 
                  ),
                ),
                
                    Container(
                      margin: EdgeInsets.only(left: 140.h,top: 5.w),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blue,
                                              spreadRadius: 10,
                                              blurRadius: 10,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                      ),
                     height: 150.h,
                     width: 150.h,
                      child: CircleAvatar(
                              radius: 130.h,
                              backgroundColor:
                                cblack,
                              backgroundImage:  NetworkImage('${snapshot.data!.docs[0]['profileImageURL']}'),
                              ),
                    ),
                 ],
                ),
                
              ],
            ),  
          ], 
          
        );
            }
            if(snapshot.data == null){
              return const Center(child: CircularProgressIndicator());
            }
            

            return const Center(child: CircularProgressIndicator());
           
          },)
      //  body:(widget.documentSnapshot == null)? const Text('data'): Text(widget.documentSnapshot?['parentName'])
      ),
    );
  }
}