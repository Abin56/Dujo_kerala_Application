import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/hostel/hostel_complaint/hostel_complaint_controller.dart';
import '../../../../utils/utils.dart';
import 'complaint_show_page.dart';

class ComplaintsListPage extends StatelessWidget {
  ComplaintsListPage({super.key});
  final HostelComplaintController _hostelController =
      Get.put(HostelComplaintController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: adminePrimayColor,
        title: const Text('Complaints'),
      ),
      body: FutureBuilder(
          future: _hostelController.fetchAllComplaint(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return circularProgressIndicatotWidget;
            }
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: cgrey1,
                    child: ListTile(
                      leading: const Icon(Icons.notes),
                      title: Text(snapshot.data?[index].title ?? " "),
                      subtitle: Text(timeStampToDateFormat(
                          snapshot.data?[index].date ?? -1)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 17),
                      onTap: () {
                        if (snapshot.data?[index] != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ComplaintsShowPage(
                                hostelModelComplaint: snapshot.data![index],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("No data found"),
              );
            }
          }),
    );
  }
}
