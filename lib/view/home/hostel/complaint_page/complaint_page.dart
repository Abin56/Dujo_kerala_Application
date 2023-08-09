import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';

import '../../../constant/responsive.dart';
import 'complaint_list_page.dart';

class HostelComplaintPage extends StatelessWidget {
  const HostelComplaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
        ),
        body: Center(
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
                height: 300,
                child: TextFormField(
                  textAlign: TextAlign.center,
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
                onPressed: () {},
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
                    builder: (context) => const ComplaintsListPage(),
                  ));
                },
                child: const Text("Show All Complaints"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
