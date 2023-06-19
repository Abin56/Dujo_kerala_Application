import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/class_teacher_HOme/my_students/add_achievements/add_achievements.dart';
import 'package:dujo_kerala_application/view/home/class_teacher_HOme/my_students/student_details/view_students_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyStudents extends StatelessWidget {
  const MyStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('My Students'.tr),backgroundColor: adminePrimayColor,
       
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId)
              .collection('classes')
              .doc(UserCredentialsController.classId)
              .collection('Students')
              .snapshots(),
          builder: (context, snapshot) { 
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.hasData){
               return ListView.separated( 
                separatorBuilder: (context, index){
                  return const SizedBox(height: 10,);
                },
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                    child: Card( 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ), color: Colors.grey[300],
                      child: ListTile(
                        //tileColor: Colors.green.withOpacity(0.5),
                        leading:  Text('${index + 1}'),
                        title: Text(snapshot.data!.docs[index]['studentName'].toString().capitalize.toString()), 
                        trailing: PopupMenuButton<String>(
            onSelected: (value) {
              // Handle menu item selection
              if (value == 'Add Achievement') {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddAchievements(studentDetail:snapshot.data!.docs[index] ),));
              } else if (value == 'View Details') {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  ViewStudentsDetails(studentDetail: snapshot.data!.docs[index]),));
              } 
              // else if (value == 'option3') {
              //   // Perform action for option 3
              // }
            },
            itemBuilder: (BuildContext context) {
              return  [
                PopupMenuItem<String>(
                  value: 'Add Achievement',
                  child: Text('Add Achievement'.tr),
                ),
                PopupMenuItem<String>(
                  value: 'View Details',
                  child: Text('View Details'.tr),
                ),
                // PopupMenuItem<String>(
                //   value: 'option3',
                //   child: Text('Option 3'),
                // ),
              ];
            },
          )
                      ),
                    ),
                  );
                });
            } return const Center(child: Text('No Students Added Yet!'),);
          }),
    );
  } 
}