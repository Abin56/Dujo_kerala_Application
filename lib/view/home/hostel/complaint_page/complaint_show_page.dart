import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/hostel/hostel_complaint/hostel_complaint_controller.dart';
import '../../../../model/hostel/hostel_model_complaint.dart';

class ComplaintsShowPage extends StatelessWidget {
  const ComplaintsShowPage({super.key, required this.hostelModelComplaint});
  final HostelModelComplaint hostelModelComplaint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: adminePrimayColor,
        title: const Text('Complaint'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          children: <Widget>[
            //complainted student name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Flexible(child: Text("Student Name  : ")),
                Flexible(
                    child: FutureBuilder(
                        future: Get.find<HostelComplaintController>()
                            .getStudentData(
                                studentId: hostelModelComplaint.studentId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data?.studentName ?? "");
                          } else {
                            return const SizedBox();
                          }
                        }))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //date
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Complaint Date  :  "),
                Text(timeStampToDateFormat(hostelModelComplaint.date))
              ],
            ),
            //complaint details
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Complaint Detail",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(hostelModelComplaint.description),

            //
          ],
        ),
      ),
    );
  }
}
