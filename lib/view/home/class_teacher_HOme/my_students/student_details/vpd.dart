import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:flutter/material.dart';

class vpd extends StatefulWidget {
   vpd({super.key, required this.studentID});

  String studentID;

  @override
  State<vpd> createState() => _vpdState();
}

class _vpdState extends State<vpd> {
   DocumentSnapshot? document;
  bool isLoading = true;
  

  @override
  void initState() {
    super.initState();
    fetchDocument();
  }

  Future<void> fetchDocument() async {
    final snapshot = await FirebaseFirestore.instance
          .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId)
                .collection('classes')
                .doc(UserCredentialsController.classId)
                .collection('ParentCollection')
          .where('studentID', isEqualTo: widget.studentID)
          .get();

    if (snapshot.docs[0].exists) {
      setState(() {
        document = snapshot.docs[0];
        isLoading = false;
      });
    } else {
      setState(() {
        document = null;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Page'),
      ),
      body: Center(
        child: isLoading
            ? const Text('Document not found') // Show a loading indicator while fetching the document
            : document != null
                ? Text(document!['parentName'].toString()) // Display the document data
                : const Text('Document not found'), // Display a message when the document doesn't exist
      ),
    );
  }
}