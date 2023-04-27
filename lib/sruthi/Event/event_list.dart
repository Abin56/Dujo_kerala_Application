import 'package:dujo_kerala_application/sruthi/Event/event_display_page.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view/colors/colors.dart';
import '../../view/widgets/fonts/google_poppins.dart';

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(title: Row(
         children: [
               IconButtonBackWidget(),
           Text("Event List"),
      
         ],
       ),backgroundColor: adminePrimayColor,),
    //  appBar: AppBar(backgroundColor: adminePrimayColor),
      body: SafeArea(
        child: Column(
          children: [
            // Heading_Container_Widget(text: 'Event List',),
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
      ),
    );
  }
}


