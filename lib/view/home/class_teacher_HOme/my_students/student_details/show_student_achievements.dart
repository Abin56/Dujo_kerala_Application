import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/class_teacher_HOme/my_students/student_details/achievements_main.dart';
import 'package:dujo_kerala_application/view/home/class_teacher_HOme/my_students/student_details/edit_achievements_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowStudentAchievements extends StatefulWidget {
  ShowStudentAchievements({super.key, required this.studentID});

  String studentID;

  @override
  State<ShowStudentAchievements> createState() => _ShowStudentAchievementsState();
}

class _ShowStudentAchievementsState extends State<ShowStudentAchievements> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: adminePrimayColor,
            title: Text('Achievements'.tr),
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId)
                .collection('classes')
                .doc(UserCredentialsController.classId)
                .collection('Achievements')
                .where('studentID', isEqualTo: widget.studentID).snapshots(),
                // .orderBy('timestamp',descending: true)
              //  .get(),
            builder: (context, snapshot) {
              //  if(snapshot.data!.docs[0].exists){
              //   return const Text('data');
              // }

              if (snapshot.hasError) {
                return const Text('data');
              }
              if (snapshot.hasData) {
                return ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AchievementsMain(
                                        doc: snapshot.data!.docs[index],
                                      )));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.greenAccent,
                          child: ListTile(
                            //tileColor: Colors.green.withOpacity(0.5),
                            leading: Text('${index + 1}'),
                            title: Text(snapshot
                                .data!.docs[index]['achievement']
                                .toString()
                                .capitalize
                                .toString()),
                            subtitle: Text(snapshot
                                .data!.docs[index]['dateOfAchievement']
                                .toString()
                                .capitalize
                                .toString()),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditAchievementsScreen(
                                                        snap: snapshot.data!
                                                            .docs[index])));
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Delete Achievement'),
                                                content: const Text(
                                                    'Are you sure you want to delete the achievement?'),
                                                actions: [
                                                  MaterialButton(
                                                    onPressed: () async{
                                                      await FirebaseFirestore.instance
                                                          .collection(
                                                              'SchoolListCollection')
                                                          .doc(
                                                              UserCredentialsController
                                                                  .schoolId)
                                                          .collection(
                                                              UserCredentialsController
                                                                  .batchId!)
                                                          .doc(
                                                              UserCredentialsController
                                                                  .batchId)
                                                          .collection('classes')
                                                          .doc(
                                                              UserCredentialsController
                                                                  .classId)
                                                          .collection(
                                                              'Achievements').doc(snapshot.data!.docs[index]['docid']).delete().then((value) => Navigator.pop(context));
                                                    },
                                                    color: Colors.blue,
                                                    child: const Text(
                                                      'Yes',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    color: Colors.blue,
                                                    child: const Text(
                                                      'No',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      icon: const Icon(Icons.delete))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              }

              return const Center(child: CircularProgressIndicator());
            },
          )
          //  body:(widget.documentSnapshot == null)? const Text('data'): Text(widget.documentSnapshot?['parentName'])
          ),
    );
  }
}
