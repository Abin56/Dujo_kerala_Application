import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/sruthi/Event/event_display_school_levl.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/fonts/google_poppins.dart';


class SchoolLevelPage extends StatelessWidget {
  const SchoolLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:  Column(
                children: [
                  // Heading_Container_Widget(text: 'Event List',),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('SchoolListCollection').doc(UserCredentialsController.schoolId!).collection('AdminEvents').snapshots(),
                    builder: (context, snapshot) {
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
                                                    builder: (context) => EventDisplaySchoolLevel(    )));

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
                                kHeight10
                                ],
                              );
                            }),
                      );
                    }
                  ),
                ],
              ),
    );
  }
}