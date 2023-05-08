import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/sruthi/Event/event_display_school_levl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../view/constant/sizes/sizes.dart';
import '../../../view/widgets/fonts/google_poppins.dart';


class SchoolLevelPage extends StatefulWidget {
   SchoolLevelPage({super.key}); 

  @override
  State<SchoolLevelPage> createState() => _SchoolLevelPageState(); 
} 

class _SchoolLevelPageState extends State<SchoolLevelPage> {

  
String? schoolIDVal;

void getFirebaseData()async {
  SharedPreferences p = await SharedPreferences.getInstance(); 
   schoolIDVal = p.getString('schoolID'); 
   print('HEY ${schoolIDVal}');
}

@override
  void initState() {
    // TODO: implement initState
    super.initState(); 
    
    getFirebaseData(); 

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:  Column(
                children: [
                  // Heading_Container_Widget(text: 'Event List',),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('SchoolListCollection').doc(UserCredentialsController.schoolId).collection(UserCredentialsController.batchId!).doc(UserCredentialsController.batchId).collection('AdminEvents').snapshots(),
                      builder: (context, snapshot) {
                    
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
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
                                                    builder: (context) => EventDisplaySchoolLevel(eventName: eventData['eventName'], eventDate: eventData['eventDate'], eventDescription: eventData['eventDescription'], eventVenue: eventData['venue'], signedBy: eventData['signedBy'],)));
                                          },
                                          child: GooglePoppinsWidgets(
                                            text: "View",
                                            fontsize: 16.h,
                                            color: Colors.green,
                                          ),
                                        ),
                                        title: GooglePoppinsWidgets(text: snapshot.data!.docs[index]['eventName'], fontsize: 19.h),
                                        subtitle: GooglePoppinsWidgets(
                                            text: snapshot.data!.docs[index]['eventDate'], fontsize: 14.h)),
                                  ),
                                kHeight10
                                ],
                              );
                            });
                      }
                    ),
                  ),
                ],
              ),
    );
  }
}