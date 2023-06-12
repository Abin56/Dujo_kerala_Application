// ignore_for_file: body_might_complete_normally_nullable

import 'package:dujo_kerala_application/view/pages/search/search_class/search_class.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/schoo_selection_controller/school_class_selection_controller.dart';
import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../helper/shared_pref_helper.dart';

class SearchBatchYearBar extends SearchDelegate {
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
    final List<String> suggestionList;
    if (query.isEmpty) {
      suggestionList = Get.find<SchoolClassSelectionController>().batchList;
    } else {
      suggestionList = Get.find<SchoolClassSelectionController>()
          .batchList
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    if (suggestionList.isEmpty) {
      return ListTile(
        title: GooglePoppinsWidgets(
          text: "Batchs not found",
          fontsize: 18,
          fontWeight: FontWeight.w400,
        ),
      );
    }

    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              UserCredentialsController.batchId = suggestionList[index];
              await SharedPreferencesHelper.setString(
                  SharedPreferencesHelper.batchIdKey,
                  UserCredentialsController.batchId ?? "");

              await Get.find<SchoolClassSelectionController>()
                  .fetchAllClassData();
              if (context.mounted) {
                await showSearch(context: context, delegate: SearchClassBar());
              }
            },
            child: Card(
              elevation: 10,
              shadowColor: Colors.black,
              child: ListTile(
                leading: const Icon(Icons.batch_prediction),
                title: GooglePoppinsWidgets(
                  text: suggestionList[index],
                  fontsize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        },
        itemCount: suggestionList.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 10);
        },
      ),
    );
  }
}
