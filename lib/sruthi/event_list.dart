import 'package:dujo_kerala_application/sruthi/event_display_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view/colors/colors.dart';
import '../view/widgets/fonts/google_poppins.dart';

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: adminePrimayColor
                ),
                child:GooglePoppinsWidgets(text: "Event List", fontsize: 34.h,color: Colors.white,),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: const Icon(Icons.event_sharp),
                      trailing: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EventDisplay()));
                        },
                        child: GooglePoppinsWidgets(
                          text: "View",
                          fontsize: 16.h,
                          color: Colors.green,
                        ),
                      ),
                      title: GooglePoppinsWidgets(text: "Events", fontsize: 19.h),
                      subtitle: GooglePoppinsWidgets(
                          text: "Date : 00/00/00", fontsize: 14.h));
                }),
          ),
        ],
      ),
    );
  }
}
