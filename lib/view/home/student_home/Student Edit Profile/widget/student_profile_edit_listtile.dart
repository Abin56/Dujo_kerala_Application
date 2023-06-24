// ignore_for_file: must_be_immutable

import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/student_controller/profile_edit_controllers/student_profile_edit_controller.dart';

class StudentEditListileWidget extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final IconData icon;
  final IconData? editicon;
  final _formKey = GlobalKey<FormState>();
  String newEmail = "";
  StudentProfileEditController studentProfileEditContrller =
      Get.put(StudentProfileEditController());

  StudentEditListileWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.editicon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: title,
      subtitle: subtitle,
      trailing: InkWell(
        child: Icon(editicon),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Do you want to change Email ID ?".tr),
                actions: [
                  TextButton(
                    child: Text("Cancel".tr),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text("Ok".tr),
                    onPressed: () {
                      Navigator.pop(context);

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          final TextEditingController emailController =
                              TextEditingController();
                          final TextEditingController passwordController =
                              TextEditingController();
                          return Form(
                            key: _formKey,
                            child: AlertDialog(
                              title: Text("Update Mail".tr),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    validator: checkFieldEmailIsValid,
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        hintText: "Enter new email address".tr),
                                  ),
                                  TextFormField(
                                    validator: checkFieldEmpty,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                        hintText: "Password".tr),
                                  ),
                                ],
                              ),
                              actions: [
                                Obx(() => studentProfileEditContrller
                                        .isLoading.value
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : TextButton(
                                        child: Text("Update".tr),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            studentProfileEditContrller
                                                .changeStudentEmail(
                                                    emailController.text.trim(),
                                                    context,
                                                    passwordController.text
                                                        .trim());
                                          }
                                        },
                                      )),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
