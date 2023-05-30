// ignore_for_file: must_be_immutable

import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/utils.dart';

class UserEditListileWidget extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final IconData icon;
  final IconData? editicon;
  final _formKey = GlobalKey<FormState>();
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
                title: const Text("Do you want change mail ?"),
                actions: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          final TextEditingController emailController =
                              TextEditingController();
                          return Form(
                            key: _formKey,
                            child: AlertDialog(
                              title: const Text("Update Mail"),
                              content: TextFormField(
                                validator: checkFieldEmailIsValid,
                                controller: emailController,
                                decoration: const InputDecoration(
                                    hintText: "Enter new email address"),
                                onChanged: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    changeEmail(emailController.text,context);
                                  }
                                },
                              ),
                              actions: [
                                TextButton(
                                  child: const Text("Update"),
                                  onPressed: () {},
                                ),
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
