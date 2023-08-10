import 'package:flutter/material.dart';
import '../../colors/colors.dart';
import 'complaint_page/complaint_page.dart';
import 'widgets/mobile_view_widget.dart';

class HostelHomePage extends StatelessWidget {
  HostelHomePage({super.key});

  final List<String> raiseNames = [
    'Complaints',
    'Leave Request',
    'Emergency Request',
    'Visitors Pass',
    'Suggestions',
  ];

  final List<String> iconListRaise = [
    'assets/images/complaint.png',
    'assets/images/leave.png',
    'assets/images/emergency-sign.png',
    'assets/images/tickets.png',
    'assets/images/suggestion.png',
  ];

  final List<Widget> raiseNavigation = [
    HostelComplaintPage(),
    HostelComplaintPage(),
    HostelComplaintPage(),
    HostelComplaintPage(),
    HostelComplaintPage(),
  ];
  final List<String> iconListSee = [
    'assets/images/menu.png',
    'assets/images/notice.png',
    'assets/images/contact-books.png',
    'assets/images/book.png',
  ];
  final List<String> iconListPay = [
    'assets/images/payment.png',
    'assets/images/bill.png',
  ];

  final List<String> seeNames = [
    'Food Menu',
    'Notice',
    'Contacts',
    'Rules',
  ];

  final List<String> payNames = [
    'Advance',
    'Bills',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        title: const Text("Hostel"),
        backgroundColor: adminePrimayColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          MobileScreenHostelWidget(
            title: 'RAISE',
            names: raiseNames,
            iconList: iconListRaise,
            navigations: raiseNavigation,
          ),
          const SizedBox(height: 20),
          MobileScreenHostelWidget(
            title: 'SEE',
            names: seeNames,
            iconList: iconListSee,
            navigations: raiseNavigation,
          ),
          const SizedBox(height: 20),
          MobileScreenHostelWidget(
            title: 'PAY',
            names: payNames,
            iconList: iconListPay,
            navigations: raiseNavigation,
          ),
        ],
      ),
    );
  }
}
