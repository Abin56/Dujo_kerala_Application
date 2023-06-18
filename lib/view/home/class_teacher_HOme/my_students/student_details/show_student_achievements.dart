import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/class_teacher_HOme/my_students/student_details/achievements_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowStudentAchievements extends StatelessWidget {
   ShowStudentAchievements({super.key, required this.studentID});

  String studentID;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: adminePrimayColor,
          title:  Text('Achievements'.tr),
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
          .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId)
                .collection('classes')
                .doc(UserCredentialsController.classId)
                .collection('Achievements')
          .where('studentID', isEqualTo: studentID)
         // .orderBy('timestamp',descending: true)
          .get(),
          builder: (context, snapshot) {

            //  if(snapshot.data!.docs[0].exists){
            //   return const Text('data');
            // }

            
            if(snapshot.hasError){
              return const Text('data');
            }
            if(snapshot.hasData){
             
               return ListView.separated(
                separatorBuilder: (context, index){
                  return const SizedBox(height: 10,);
                },
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                return GestureDetector( 
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AchievementsMain(doc: snapshot.data!.docs[index],)));
                  },
                  child: Card( 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), 
                        ), color: Colors.greenAccent,
                        child: ListTile(
                          //tileColor: Colors.green.withOpacity(0.5),
                          leading:  Text('${index + 1}'),
                          title: Text(snapshot.data!.docs[index]['achievement'].toString().capitalize.toString()),
                          subtitle: Text(snapshot.data!.docs[index]['dateOfAchievement'].toString().capitalize.toString()),), 
                          ),
                ); 
               });
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