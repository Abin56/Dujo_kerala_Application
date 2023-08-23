import 'package:dujo_kerala_application/view/constant/responsive.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../model/hostel/hostel_model_complaint.dart';

class ComplaintsShowPage extends StatelessWidget {
  const ComplaintsShowPage({
    super.key,
    required this.hostelModelComplaint,
  });
  final HostelModelComplaint hostelModelComplaint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Complaint"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const HostelComplaintTextWidget(text: "Title"),
                  ComplaintDataShowWidget(title: hostelModelComplaint.title),
                  kHeight10,
                  const HostelComplaintTextWidget(text: "Detail"),
                  ComplaintDataShowWidget(
                      title: hostelModelComplaint.description),
                  kHeight10,
                  const HostelComplaintTextWidget(text: "Status"),
                  kHeight10,
                  hostelModelComplaint.status == "pending"
                      ? const StatusWidget(
                          text: 'Pending',
                          color: Colors.yellow,
                          icon: Icons.pending,
                        )
                      : hostelModelComplaint.status == "completed"
                          ? const StatusWidget(
                              text: 'Completed',
                              color: Colors.green,
                              icon: Icons.pending,
                            )
                          : hostelModelComplaint.status == "rejected"
                              ? const StatusWidget(
                                  text: 'Rejected',
                                  color: Colors.red,
                                  icon: Icons.pending,
                                )
                              : const SizedBox(),
                  kHeight10,
                  const HostelComplaintTextWidget(text: "Status Detail"),
                  ComplaintDataShowWidget(
                    title: hostelModelComplaint.actionsTaken,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key,
    required this.text,
    required this.color,
    required this.icon,
  });

  final String text;
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: color,
          size: 25,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(text),
      ],
    );
  }
}

class ComplaintDataShowWidget extends StatelessWidget {
  const ComplaintDataShowWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(10),
      child: Container(
        width: ResponsiveApp.width,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(08),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}

class HostelComplaintTextWidget extends StatelessWidget {
  const HostelComplaintTextWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
