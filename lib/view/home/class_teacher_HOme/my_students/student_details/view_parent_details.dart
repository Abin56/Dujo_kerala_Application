import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/class_teacher_HOme/my_students/student_details/view_students_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../widgets/Iconbackbutton.dart';

class ViewParentDetails extends StatefulWidget {
   ViewParentDetails({super.key,required this.documentSnapshot, required this.studentID});

  DocumentSnapshot documentSnapshot;
  DocumentSnapshot? documentSnapshott;
  String studentID;
  QuerySnapshot? querySnapshot;
  


  @override
  State<ViewParentDetails> createState() => _ViewParentDetailsState();
} 

class _ViewParentDetailsState extends State<ViewParentDetails> {
  

@override
  void initState() {
    // TODO: implement initState
    super.initState();
   // fetchDocument();
  } 

//    Future<void> fetchDocument() async {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   try {
//      widget.querySnapshot = await firestore
//         .collection('SchoolListCollection')
//               .doc(UserCredentialsController.schoolId)
//               .collection(UserCredentialsController.batchId!)
//               .doc(UserCredentialsController.batchId)
//               .collection('classes')
//               .doc(UserCredentialsController.classId)
//               .collection('ParentCollection')
//         .where('studentID', isEqualTo: widget.studentID)
//         .get();

//     // Access the first document that matches the condition
//     if (widget.querySnapshot!.size > 0) {
//      widget.documentSnapshott =  widget.querySnapshot!.docs[0];
//       Object? data =  widget.documentSnapshott!.data();
//       log(data.toString());  // log the document data
//     } else {
//       log('No matching document found.');
//     }
//   } catch (e) {
//     log('Error: $e');
//   }
// }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Parent Details'),
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
          .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId)
                .collection('classes')
                .doc(UserCredentialsController.classId)
                .collection('ParentCollection')
          .where('studentID', isEqualTo: widget.studentID)
          .get(),
          builder: (context, snapshot) { 

            if(!snapshot.data!.docs[0].exists){
              return const Text('data');
            } 

            if(snapshot.hasData 
           // || snapshot.data!.docs[0].exists
            ){
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

                             TextWidget(text: 'Student Name : ${snapshot.data!.docs[0]['parentName']}',),
                          ],
                        ),

                        const Divider(color: cWhite,),
                          //SizedBox(width: 20.h,),
                             //SizedBox(width: 20.h,),        
                        Row(
                          children: [
                            const Icon(Icons.phone,color: cWhite,),
                             SizedBox(width: 20.h,),
                            
                             TextWidget(text: 'Parent Phone Number : ${snapshot.data!.docs[0]['parentPhoneNumber']}',),
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

                             TextWidget(text: 'Parent Email : ${snapshot.data!.docs[0]['parentEmail']}',),
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
            return const Center(child: CircularProgressIndicator());
           
          },)
      //  body:(widget.documentSnapshot == null)? const Text('data'): Text(widget.documentSnapshot['parentName'])
      ),
    );
  }
}