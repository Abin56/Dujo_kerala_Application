import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../event_display_class_level.dart';


class ClassLevelPage extends StatelessWidget {
  const ClassLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: Column(
                children: [
                  // Heading_Container_Widget(text: 'Event List',),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('SchoolListCollection').doc(UserCredentialsController.schoolId).collection(UserCredentialsController.batchId!).doc(UserCredentialsController.batchId).collection('classes').doc(UserCredentialsController.classId).collection('TeacherEvents').snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator(),);
                      } 

                      if(snapshot.hasData){
                        return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              QueryDocumentSnapshot<Map<String, dynamic>> eventData = snapshot.data!.docs[index];
                              return Column(
                                children: [
                                  Container(
                                    child: ListTile(
                                        leading: const Icon(Icons.event_sharp),
                                        trailing: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => EventDisplayClassLevel(eventName: eventData['eventName'], eventDate: eventData['eventDate'], description: eventData['description'], chiefGuest:eventData['chiefGuest'] , venue: eventData['venue'],)));
                                          },
                                          child: GooglePoppinsWidgets(
                                            text: "View",
                                            fontsize: 16.h,
                                            color: Colors.green,
                                          ),
                                        ),
                                        title: GooglePoppinsWidgets(text: '${eventData['eventName']}', fontsize: 19.h),
                                        subtitle: GooglePoppinsWidgets(
                                            text: "Date : ", fontsize: 14.h)),
                                  ),
                            const Divider(),kHeight10
                                ],
                              );
                            }),
                      );
                      }
        else{
          return const Center(
          child: Text('No Upcoming School Events', style: TextStyle(color: Colors.black),),
        );
        }
                      
                    }
                  ),
                ],
              ),
    );
  }
}