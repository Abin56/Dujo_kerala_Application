import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class EditAchievementsScreen extends StatefulWidget {
   EditAchievementsScreen({super.key, required this.snap});

  DocumentSnapshot snap;

  @override
  State<EditAchievementsScreen> createState() => _EditAchievementsScreenState();
}



class _EditAchievementsScreenState extends State<EditAchievementsScreen> {

  TextEditingController achievementController = TextEditingController(); 
  TextEditingController dateOfAchievementController = TextEditingController(); 
  TextEditingController descriptionController= TextEditingController(); 

  String achievementHintText = 'Achievement' ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      achievementController.text = widget.snap['achievement'];
      dateOfAchievementController.text = widget.snap['dateOfAchievement'];
      descriptionController.text = widget.snap['description'];
    });
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Edit achievements of ${widget.snap['studentName']}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10.0), // Adjust the value for the desired curve
                             border: Border.all(
                               color: Colors.grey, // Border color
                               width: 1.0, ),),
                child: TextFormField(
                                 // validator: checkFieldEmpty,
                                  controller: achievementController,
                                   decoration:   const InputDecoration(
                                     border: InputBorder.none, // Remove the default underline
                                     contentPadding: EdgeInsets.symmetric(horizontal: 10.0), // Adjust the padding as needed
                                     labelText: 'Achievement'// Placeholder text
                                   ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10.0), // Adjust the value for the desired curve
                             border: Border.all(
                               color: Colors.grey, // Border color
                               width: 1.0, ),),
                child: TextFormField(
                                 // validator: checkFieldEmpty,
                                  controller: dateOfAchievementController,
                                   decoration:  const InputDecoration(
                                     border: InputBorder.none, // Remove the default underline
                                     contentPadding: EdgeInsets.symmetric(horizontal: 10.0), // Adjust the padding as needed
                                     labelText: 'Date of Achievement', // Placeholder text
                                   ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10.0), // Adjust the value for the desired curve
                             border: Border.all(
                               color: Colors.grey, // Border color
                               width: 1.0, ),),
                child: TextFormField(
                                 // validator: checkFieldEmpty,
                                  controller: descriptionController,
                                   decoration:  const InputDecoration(
                                     border: InputBorder.none, // Remove the default underline
                                     contentPadding: EdgeInsets.symmetric(horizontal: 10.0), // Adjust the padding as needed
                                     labelText: 'Description', // Placeholder text
                                   ),),
              ),
            ), 

            const SizedBox(height: 10,), 
            MaterialButton(onPressed: (){
              FirebaseFirestore.instance
          .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId)
                .collection('classes')
                .doc(UserCredentialsController.classId)
                .collection('Achievements').doc(widget.snap['docid']).update({
                  'achievement' : achievementController.text, 
                  'dateOfAchievement' : dateOfAchievementController.text, 
                  'description' : descriptionController.text
                }).then((value) => Navigator.pop(context));
            },color: Colors.blue, child: const Text('Edit', style: TextStyle(color: Colors.white),),)
          ],
        ),
      )
    );
  }
}