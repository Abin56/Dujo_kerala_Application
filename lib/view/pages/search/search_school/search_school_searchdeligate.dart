// ignore_for_file: body_might_complete_normally_nullable

import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';

import '../search_batchYear/search_batch_year.dart';

class SearchSchoolBar extends SearchDelegate {
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
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
                 await showSearch(context: context, delegate: SearchBatchYearBar());
            },
            child: GooglePoppinsWidgets(
              text: 'Marthoma Higher Secondary School, venmoney',
              fontsize: 18,
              fontWeight: FontWeight.w400,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: 10),
    );
  }
}
