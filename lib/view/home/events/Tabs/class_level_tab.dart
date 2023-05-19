import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../model/event_model/class_event_model.dart';
import '../event_display_class_level.dart';

class ClassLevelPage extends StatelessWidget {
  const ClassLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.grey.withOpacity(0.2),
      body: Column(
        children: [
          // Heading_Container_Widget(text: 'Event List',),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('SchoolListCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection(UserCredentialsController.batchId!)
                  .doc(UserCredentialsController.batchId)
                  .collection('classes')
                  .doc(UserCredentialsController.classId)
                  .collection('ClassEvents')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.separated(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          ClassEventModel eventData = ClassEventModel.fromMap(
                              snapshot.data!.docs[index].data());
                          return Column(
                            children: [
                        
                                             Padding( padding: const EdgeInsets.only(top: 10,right: 10,left: 10),

                                child: Card(
                                  child: ListTile(shape: BeveledRectangleBorder(side: BorderSide(color: Colors.grey.withOpacity(0.2))),
                                      leading: const Icon(Icons.event_sharp),
                                      trailing: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EventDisplayClassLevel(
                                                        eventName:
                                                            eventData.eventName,
                                                        eventDate:
                                                            eventData.eventDate,
                                                        description: eventData
                                                            .eventDescription,
                                                        signedBy:
                                                            eventData.signedBy,
                                                        venue: eventData.venue,
                                                      )));
                                        },
                                        child: GooglePoppinsWidgets(
                                          text: "View".tr,
                                          fontsize: 16.h,
                                          color: Colors.green,
                                        ),
                                      ),
                                      title: GooglePoppinsWidgets(
                                          text: eventData.eventName,
                                          fontsize: 19.h),
                                      subtitle: GooglePoppinsWidgets(
                                          text: "Date : ${eventData.eventDate}",
                                          fontsize: 14.h)),
                                ),
                              ),
                             
                            ],
                          );
                        }, separatorBuilder: (BuildContext context, int index) { return kHeight10; },),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'No Upcoming School Events',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
