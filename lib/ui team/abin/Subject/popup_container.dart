// ignore_for_file: prefer_adjacent_string_concatenation, deprecated_member_use, prefer_const_constructors

import 'package:dujo_kerala_application/ui%20team/abin/Subject/popup_containerwidget.dart';
import 'package:flutter/material.dart';


class PopUpContainer extends StatelessWidget {
  const PopUpContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
       Column(
         children: [
           Column(
            children: [
              PopUpcontainerWidget(
                text1: 'Email :' + ' lepton@gmail.com', 
                text: 'Name :' + ' Lepton',
                text2: ' Chat with your teacher', ),
            
            ],
           ),
         ],
       )),
    );
  }
}

