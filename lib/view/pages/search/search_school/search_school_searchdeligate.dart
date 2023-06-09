// ignore_for_file: body_might_complete_normally_nullable

import 'package:dujo_kerala_application/controllers/schoo_selection_controller/school_class_selection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../helper/shared_pref_helper.dart';
import '../../../../model/schoo_list_model/school_list_model.dart';
import '../../../widgets/fonts/google_poppins.dart';
import '../search_batchYear/search_batch_year.dart';

class SearchSchoolBar extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(
          Icons.clear,
          color: Colors.black,
        ));
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
  Widget buildSuggestions(BuildContext context) {
    final List<SchoolModel> suggestionList;
    if (query.isEmpty) {
      suggestionList =
          Get.find<SchoolClassSelectionController>().schoolModelList;
    } else {
      suggestionList = Get.find<SchoolClassSelectionController>()
          .schoolModelList
          .where((item) =>
              item.schoolName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    if (suggestionList.isEmpty) {
      return ListTile(
        title: GooglePoppinsWidgets(
          text: "Schools not found",
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
                UserCredentialsController.schoolId =
                    suggestionList[index].docid;
                await SharedPreferencesHelper.setString(
                    SharedPreferencesHelper.schoolIdKey,
                    UserCredentialsController.schoolId ?? "");

                await Get.find<SchoolClassSelectionController>()
                    .fetchBatachDetails();
                if (context.mounted) {
                  await showSearch(
                      context: context, delegate: SearchBatchYearBar());
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  shape: const BeveledRectangleBorder(),
                  child: ListTile(
                    leading: const Icon(Icons.school_outlined),
                    title: GooglePoppinsWidgets(
                      text: suggestionList[index].schoolName,
                      fontsize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: suggestionList.length,
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }
}
