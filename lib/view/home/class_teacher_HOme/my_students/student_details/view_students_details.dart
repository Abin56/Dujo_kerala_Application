import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/home/class_teacher_HOme/my_students/student_details/view_guardian_details.dart';
import 'package:dujo_kerala_application/view/home/class_teacher_HOme/my_students/student_details/view_parent_details.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewStudentsDetails extends StatefulWidget {
   ViewStudentsDetails({super.key, required this.studentDetail}); 

  QueryDocumentSnapshot<Map<String, dynamic>> studentDetail;
  DocumentSnapshot? documentSnapshot;
  bool stat = false;

  @override
  State<ViewStudentsDetails> createState() => _ViewStudentsDetailsState();
}

class _ViewStudentsDetailsState extends State<ViewStudentsDetails> {
  Future<void> fetchDocument() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    QuerySnapshot querySnapshot = await firestore
        .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId)
              .collection('classes')
              .doc(UserCredentialsController.classId)
              .collection('ParentCollection')
        .where('studentID', isEqualTo: widget.studentDetail['docid'])
        .get();

       // querySnapshot.docs[0].exists;

    // Access the first document that matches the condition
    if (querySnapshot.size > 0) {
      setState(() {
        widget.stat = true;
      });
     widget.documentSnapshot =  querySnapshot.docs[0];
      Object? data =  widget.documentSnapshot!.data();
      log(data.toString());  // log the document data
    } else {
      log('No matching document found.');
    }
  } catch (e) {
    log('Error: $e');
  }
}

@override
  void initState() {
    // TODO: implement initState
    super.initState(); 
    fetchDocument();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: cWhite,
        resizeToAvoidBottomInset: false,
        body: ListView(
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

                            TextWidget(text: 'Student Name : ${widget.studentDetail['studentName'].toString().capitalize}',),
                          ],
                        ),

                        const Divider(color: cWhite,),
                          //SizedBox(width: 20.h,),
                             //SizedBox(width: 20.h,),        
                        Row(
                          children: [
                            const Icon(Icons.phone,color: cWhite,),
                             SizedBox(width: 20.h,),
                            
                            TextWidget(text: 'Parent Phone Number : ${widget.studentDetail['parentPhoneNumber']}',),
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

                            TextWidget(text: 'Student Email : ${widget.studentDetail['studentemail']}',),
                          ],
                        ),


                         const Divider(color: cWhite,),
                          //SizedBox(width: 20.h,),
                            // SizedBox(width: 20.h,),

                        Row(
                          children: [
                            const Icon(Icons.bloodtype,color: cWhite,),
                             SizedBox(width: 20.h,),

                             TextWidget(text: 'Blood Group: ${widget.studentDetail['bloodgroup']}',),
                          ],
                        ),
                        
                           const Divider(color: cWhite,),
                            //SizedBox(width: 20.h,),
                            // SizedBox(width: 20.h,),

                        Row(
                          children: [
                               const Icon(Icons.numbers,color: cWhite,),
                             SizedBox(width: 20.h,),

                            TextWidget(text: 'Admission Number : ${widget.studentDetail['admissionNumber']}',),
                          ],
                        ),
                        
                           const Divider(color: cWhite,),

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
                              backgroundImage: NetworkImage(widget.studentDetail['profileImageUrl']),
                              ),
                    ),
                 ],
                ),
                MaterialButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> 
                  // vpd(studentID:  widget.studentDetail['docid'],)));
              // VPD(studentID: widget.studentDetail['docid'],documentSnapshot: widget.documentSnapshot! , )));
                  ViewParentDetails(studentID: widget.studentDetail['docid'],documentSnapshot: widget.documentSnapshot! ,)));
                }, color: Colors.blue, child: const Text('View Parent Details', style: TextStyle(color: Colors.white),),), 
                kHeight20, 
                MaterialButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  ViewGuardianDetails(studentID: widget.studentDetail['docid'],documentSnapshot: widget.documentSnapshot!)));
                }, color: Colors.blue, child: const Text('View Guardian Details', style: TextStyle(color: Colors.white),),), 
                kHeight20
              ],
            ),  
          ], 
          
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    required this.text,
    super.key,
  });
final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
     // set a fixed height for the container
      child: GooglePoppinsWidgets(
        text:text,
        fontsize: 14.h,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }
  }
