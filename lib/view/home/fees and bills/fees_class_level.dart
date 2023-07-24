import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:flutter/material.dart';

import '../../../controllers/fees_and_bills_controller/fees_class_level_controller.dart';
import 'view_fee_details.dart';

class ClassLevelFees extends StatelessWidget {
  ClassLevelFees({super.key});
  final ClassFeesController _feesController = ClassFeesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _feesController.fetchAllFees(
                selectedClass: UserCredentialsController.classId ?? ""),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          final studentData =
                              await _feesController.fetchStudentData(
                                  studentId: UserCredentialsController
                                          .parentModel?.studentID ??
                                      "");
                          if (studentData != null) {
                            if (context.mounted) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ViewFeeDetails(
                                        feesModel: snapshot.data![index],
                                        addStudentModel: studentData,
                                      )));
                            }
                          }
                        },
                        title: Text(
                          snapshot.data?[index].feesName ?? "",
                        ),
                        subtitle: Text(
                          snapshot.data?[index].dueDate ?? "",
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text("No data found"),
                );
              }
            }));
  }
}
