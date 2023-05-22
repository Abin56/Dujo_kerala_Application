import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../controllers/userCredentials/user_credentials.dart';

class ViewPD extends StatefulWidget {
   ViewPD({super.key, required this.studentID});

  String studentID;
  DocumentSnapshot? documentSnapshot;

  @override
  State<ViewPD> createState() => _ViewPDState();
}

class _ViewPDState extends State<ViewPD> { 

  loadDocument()async{
    try{
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId)
                .collection('classes')
                .doc(UserCredentialsController.classId)
                .collection('ParentCollection')
          .where('studentID', isEqualTo: widget.studentID)
          .get();

           if (querySnapshot.size > 0) {
      
     setState(() {
       widget.documentSnapshot =  querySnapshot.docs[0];
     });
      Object? data =  widget.documentSnapshot!.data();
      log(data.toString());  // log the document data
    } else {
      log('No matching document found.');
    }

    } catch(e){
      log('Error:$e');
    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState(); 
    loadDocument();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: (widget.documentSnapshot == null)? const Text('NULL'): Text(widget.documentSnapshot!['parentName']),),
    );
  }
}