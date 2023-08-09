import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';

class ComplaintsShowPage extends StatelessWidget {
  const ComplaintsShowPage({super.key});

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
              children: const <Widget>[
                Text("Student Name  :  "),
                Text("Rahul")
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //date
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text("Complaint Date  :  "),
                Text("10-11-2021")
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
            const Text(
                "djfljsdfljsdlfjldjfjfjljdlfjl;adsjfljdsfldklsfjlsdjfljlsfjlsjflsjflsfsflsjfljsfjsfkjsfjslfjlsjfldsjfdsjfdsjfjerewioudkgj,xnvxkdhfgoaifjuoi"),

            //
          ],
        ),
      ),
    );
  }
}
