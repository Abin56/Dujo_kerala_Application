import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewStudentsDetails extends StatelessWidget {
   ViewStudentsDetails({super.key, required this.studentDetail}); 

  QueryDocumentSnapshot<Map<String, dynamic>> studentDetail;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 40,left:20,right:10),
          child: SingleChildScrollView(
            child: Column(
              children:  [
                CircleAvatar(
                              radius: 70,
                              backgroundColor:
                                  const Color.fromARGB(255, 52, 50, 50),
                              backgroundImage: NetworkImage(studentDetail['profileImageUrl']),
                             
                            ),
                kHeight40,
                
                TextWidget(text: 'Student Name : ${studentDetail['studentName'].toString().capitalize}',),
              
                TextWidget(text: 'Parent Phone Number : ${studentDetail['parentPhoneNumber']}',),
              
                const TextWidget(text: 'Student Phone Number : ',),
             
                TextWidget(text: 'Student Email : ${studentDetail['studentemail']}',),
               
                 const TextWidget(text: 'Blood Group: B',),
                
               const TextWidget(text: 'Admission Number : 3 B',),
                
                const TextWidget(text: 'Student Name :Anu',),
              
                const TextWidget(text: 'Class : 5 B',),
              ],
            ),
          ),
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
    return Expanded(
            child: SizedBox(
             // set a fixed height for the container
              child: GooglePoppinsWidgets(
                text:text,
                fontsize: 19
                .h,
                color: Colors.black,
              ),
            ),);
  }
  }
