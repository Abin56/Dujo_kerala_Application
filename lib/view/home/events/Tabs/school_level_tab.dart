import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/fonts/google_poppins.dart';
import '../event_display_school_level.dart';


class SchoolLevelPage extends StatelessWidget {
  const SchoolLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
    body:  Column(
                children: [
                  // Heading_Container_Widget(text: 'Event List',),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('SchoolListCollection').doc(UserCredentialsController.schoolId!).collection('AdminEvents').snapshots(),
                    builder: (context, snapshot) {
                      return Expanded(
                        child: ListView.separated(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              QueryDocumentSnapshot<Map<String, dynamic>> eventData = snapshot.data!.docs[index];
                              return Column(
                                children: [
                                  Padding(
                                  padding: const EdgeInsets.only(top: 10,right: 10,left: 10),
                                    child: Card(
                                      child: ListTile(shape: BeveledRectangleBorder(side: BorderSide(color: Colors.grey.withOpacity(0.2))),
                                          leading: const Icon(Icons.event_sharp),
                                          trailing: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => const EventDisplaySchoolLevel(    )));
                                                                      
                                            },
                                            child: GooglePoppinsWidgets(
                                              text: "View",
                                              fontsize: 16.h,
                                              color: Colors.green,
                                            ),
                                          ),
                                          title: GooglePoppinsWidgets(text: "Events", fontsize: 19.h),
                                          subtitle: GooglePoppinsWidgets(
                                              text: "Date : 00/00/00", fontsize: 14.h)),
                                    ),
                                  ),
                                kHeight10
                                ],
                              );
                            }, separatorBuilder: (BuildContext context, int index) { return kHeight10; },),
                      );
                    }
                  ),
                ],
              ),
    );
  }
}