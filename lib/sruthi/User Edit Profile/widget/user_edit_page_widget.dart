// ignore_for_file: must_be_immutable

import 'package:dujo_kerala_application/view/home/sample/under_maintance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserEditListileWidget extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final IconData icon;
  final IconData? editicon;
  String newEmail = "";
  UserEditListileWidget({
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
                title:  Text("Do you want change mail ?".tr),
                actions: [
                  TextButton(
                    child:  Text("Cancel".tr),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child:  Text("Ok".tr),
                    onPressed: () {
                      Navigator.pop(context);

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:  Text("Update Mail".tr),
                            content: TextField(
                              decoration:  InputDecoration(
                                  hintText: "Enter new email address".tr),
                              onChanged: (value) {
                                newEmail = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                child:  Text("Update".tr),
                                onPressed: () {
                                  Get.to(UnderMaintanceScreen(
                                    text: "",
                                  ));
                                },
                              ),
                            ],
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
