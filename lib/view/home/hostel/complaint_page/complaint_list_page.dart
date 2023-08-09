import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';

import 'complaint_show_page.dart';

class ComplaintsListPage extends StatelessWidget {
  const ComplaintsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: const Text('Complaints'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Pending",
                icon: Icon(
                  Icons.pending,
                ),
              ),
              Tab(
                text: "Completed",
                icon: Icon(
                  Icons.done,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: 20,
              itemBuilder: (context, index) {
                return Card(
                  color: cgrey1,
                  child: ListTile(
                    leading: const Icon(Icons.notes),
                    title: const Text("title"),
                    subtitle: const Text("Subtitle"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 17),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ComplaintsShowPage()));
                    },
                  ),
                );
              },
            ),
            ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: 20,
              itemBuilder: (context, index) {
                return Card(
                  color: cgrey1,
                  child: ListTile(
                    leading: const Icon(Icons.notes),
                    title: const Text("title"),
                    subtitle: const Text("Subtitle"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 17),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ComplaintsShowPage()));
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
