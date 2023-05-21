import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AchievementsMain extends StatelessWidget {
   AchievementsMain({super.key, required this.doc});

  DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(doc['achievement'].toString().capitalize.toString(), style: GoogleFonts.poppins(fontSize: 18),), 
        
              kHeight10, 
              Text(doc['dateOfAchievement'].toString(), style: GoogleFonts.poppins(fontSize: 15),),
              kHeight40,
              CircleAvatar(
                radius: 70, 
                backgroundImage: NetworkImage(doc['photoUrl']),
              ),
              kHeight20,
              Text(doc['studentName'].toString().capitalize.toString(), style: GoogleFonts.poppins(fontSize: 14),),
              kHeight20,  
              Text(doc['description'], style: GoogleFonts.poppins(),)
            ],
          ),
        ),
      ),
    );
  }
}