// ignore_for_file: body_might_complete_normally_nullable

import 'package:dujo_kerala_application/model/class_list_model/class_list_model.dart';
import 'package:dujo_kerala_application/view/pages/login/users_login_screen/users_login_screen.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/schoo_selection_controller/school_class_selection_controller.dart';
import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../helper/shared_pref_helper.dart';

class SearchClassBar extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.clear));
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<ClassModel> suggestionList;
    if (query.isEmpty) {
      suggestionList =
          Get.find<SchoolClassSelectionController>().classModelList;
    } else {
      suggestionList = Get.find<SchoolClassSelectionController>()
          .classModelList
          .where((item) =>
              item.className.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    if (suggestionList.isEmpty) {
      return ListTile(
        title: GooglePoppinsWidgets(
          text: "Classes not found",
          fontsize: 18,
          fontWeight: FontWeight.w400,
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                UserCredentialsController.classId = suggestionList[index].docid;
                await SharedPreferencesHelper.setString(
                    SharedPreferencesHelper.classIdKey,
                    UserCredentialsController.classId ?? "");

                Get.off(UsersLoginScreen());
              },
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                child: ListTile(
                  leading: const Icon(Icons.class_),
                  title: GooglePoppinsWidgets(
                      text: suggestionList[index].className,
                      fontsize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemCount: suggestionList.length,
        ),
      ),
    );
  }
}
