// ignore_for_file: body_might_complete_normally_nullable

import 'package:dujo_kerala_application/view/pages/search/search_class/search_class.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      body: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                await showSearch(context: context, delegate: SearchClassBar());
              },
              child: GooglePoppinsWidgets(
                text: '2023 June - 2024 Feb',
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
