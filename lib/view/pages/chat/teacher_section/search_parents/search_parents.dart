import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../controllers/chat_controller/teacher_controller/parent_teacher_controller.dart';
import '../../../../../model/parent_model/parent_model.dart';
import '../../../../widgets/fonts/google_poppins.dart';
import '../parents_message/chats/parent_chats.dart';

class SearchParentsForChat extends SearchDelegate {
  TeacherParentChatController teacherParentChatController =
      Get.put(TeacherParentChatController());

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.clear));
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("SchoolListCollection")
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId!)
            .collection("classes")
            .doc(UserCredentialsController.classId!)
            .collection('ParentCollection')
            .snapshots(),
        builder: (context, snapshots) {
          var screenSize = MediaQuery.of(context).size;
          if (snapshots.hasData) {
            return Scaffold(
              // backgroundColor: Colors.transparent,
              body: ListView.separated(
                  itemBuilder: (context, index) {
                    ParentModel data =
                        ParentModel.fromMap(snapshots.data!.docs[index].data());
                    return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: screenSize.width / 8,
                        width: double.infinity,
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  // log(data.profileImageUrl ?? "");
                                  // _showlert(context, data);
                                },
                                child: const CircleAvatar(
                                  radius: 60,
                                )),
                            kHeight40,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.parentName!,
                                    style: GoogleFonts.poppins(fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: snapshots.data!.docs.length),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<ParentModel> buildSuggestionList;
    if (query.isEmpty) {
      buildSuggestionList = teacherParentChatController.searchParents;
    } else {
      buildSuggestionList = teacherParentChatController.searchParents
          .where((item) =>
              item.parentName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    if (buildSuggestionList.isEmpty) {
      return ListTile(
        title: GooglePoppinsWidgets(text: "Result not Found", fontsize: 18),
      );
    } else {
      return Scaffold(
        body: ListView.separated(
            itemBuilder: (context, index) {
              final screenSize = MediaQuery.of(context).size;

              return GestureDetector(
                onTap: () {
                  final data = buildSuggestionList[index];
                  Get.to(ParentsChatsScreen(
                      parentDocID: data.docid!, parentName: data.parentName!));
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: screenSize.width / 8,
                    width: double.infinity,
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              final data = buildSuggestionList[index];

                              // _showlert(context, data);
                            },
                            child: const Icon(
                              Icons.person_sharp,
                              size: 30,
                            )),
                        kwidth40,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(snapshots.data!.docs[index]['id']),
                              Text(
                                buildSuggestionList[index].parentName!,
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                              // sizedBoxH10,
                              // Text(
                              //   'Admission No. :${buildSuggestionList[index].admissionNumber}',
                              //   style: GoogleFonts.poppins(fontSize: 12),
                              // ),
                              // sizedBoxH10,

                              // Text(
                              //   'Class & Division : ${buildSuggestionList[index].classID}',
                              //   style: GoogleFonts.poppins(fontSize: 12),
                              // ),
                              // sizedBoxH10,
                              // Text(
                              //   'Phone No :${buildSuggestionList[index].guardianID}',
                              //   style: GoogleFonts.poppins(fontSize: 12),
                              // ),
                            ],
                          ),
                        )
                      ],
                    )),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: buildSuggestionList.length),
      );
    }
  }
}

// void _showlert(BuildContext context, ParentModel data) {
//   showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) => Student_Details_AlertBox_Widget(
//             studentID: data.docid ?? "",
//             studentImage: data.profileImageUrl ?? "",
//             parentName: data.parentName ?? "",
//             studentClass: data.classID ?? "",
//             admissionNumber: data.admissionNumber ?? "",
//             studentGender: data.gender ?? "",
//             bloodGroup: data.bloodgroup ?? "",
//             studentEmail: data.studentemail ?? "",
//             houseName: data.houseName ?? "",
//             place: data.place ?? "",
//             district: data.district ?? "",
//           ));
// }
