import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/hostel/hostel_complaint/hostel_complaint_create_controller.dart';
import '../../../../model/hostel/hostel_model_complaint.dart';
import '../../../constant/responsive.dart';
import 'complaint_list_page.dart';

class HostelComplaintPage extends StatelessWidget {
  HostelComplaintPage({super.key});

  final HostelComplaintCreateController _hostelController =
      Get.put(HostelComplaintCreateController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: adminePrimayColor,
          ),
          body: Obx(
            () => _hostelController.isLoading.value
                ? circularProgressIndicatotWidget
                : Center(
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(ResponsiveApp.width * .05),
                      children: [
                        const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Register your complaint",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 80,
                          child: TextFormField(
                            controller:
                                _hostelController.complaintTitleController,
                            textAlign: TextAlign.center,
                            expands: true,
                            maxLines: null,
                            decoration: const InputDecoration(
                                hintText: "Title",
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 300,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: _hostelController.complaintController,
                            expands: true,
                            maxLines: null,
                            decoration: const InputDecoration(
                                hintText: "Enter your complaint here",
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: adminePrimayColor,
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () async {
                            if (_hostelController.isValid()) {
                              await _hostelController.createHostelComplaint(
                                hostel: HostelModelComplaint(
                                    docId: "",
                                    title: _hostelController
                                        .complaintTitleController.text,
                                    studentId: UserCredentialsController
                                            .studentModel?.docid ??
                                        "",
                                    date:
                                        Timestamp.now().millisecondsSinceEpoch,
                                    description: _hostelController
                                        .complaintController.text,
                                    isCompleted: false,
                                    classId: UserCredentialsController
                                            .studentModel?.classId ??
                                        ""),
                              );
                            } else {
                              showToast(msg: "All fields are mandatory");
                            }
                          },
                          child: const Text("Submit"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: adminePrimayColor,
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ComplaintsListPage(),
                            ));
                          },
                          child: const Text("Show All Complaints"),
                        ),
                      ],
                    ),
                  ),
          )),
    );
  }
}
