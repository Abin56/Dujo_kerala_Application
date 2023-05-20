import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class AddAchievements extends StatefulWidget {
   AddAchievements({super.key, required this.studentDetail});


  QueryDocumentSnapshot<Map<String, dynamic>> studentDetail; 

  @override
  State<AddAchievements> createState() => _AddAchievementsState();
}

class _AddAchievementsState extends State<AddAchievements> {
  TextEditingController achievementController = TextEditingController(); 

  TextEditingController dateOfAchievementController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  bool loadingStatus = false;
  final _formKey = GlobalKey<FormState>();

  void addClassTeacherAchievementsToFirebase(){ 

    setState(() {
      loadingStatus= true;
    });

    String uid =  const Uuid().v1(); 

     FirebaseFirestore.instance
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId)
              .collection('classes')
              .doc(UserCredentialsController.classId)
              .collection('Achievements')
              .doc(uid)
              .set({
                'studentName': widget.studentDetail['studentName'], 
                'studentID': widget.studentDetail['docid'], 
                'photoUrl': widget.studentDetail['profileImageUrl'], 
                'description': descriptionController.text, 
                'dateOfAchievement': dateOfAchievementController.text, 
                'admissionNumber': widget.studentDetail['admissionNumber'], 
                'achievement': achievementController.text,
                'docid':uid
              }).then((value) => showDialog(context: context, builder: (context){
                return AlertDialog(
                  title:const Text('Students Achievements'),
                  content: const Text('New Achievement added!'),
                  actions: [
                    MaterialButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, color: Colors.blue, child: const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:  Text('OK'),
                    ),)
                  ],
                );
              })); 

       setState(() {
      loadingStatus= false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButtonBackWidget(color: cblack,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                          CircleAvatar(
                                     radius: 80,
                                     backgroundImage: NetworkImage(widget.studentDetail['profileImageUrl']),
                                   ), kHeight20,
                      Text(widget.studentDetail['studentName'].toString().capitalize!, style: GoogleFonts.poppins(fontSize: 18), ),
                      kHeight20,
                       Padding(
                         padding: const EdgeInsets.only(right: 10.0, left: 10),
                         child: Container(
                           decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10.0), // Adjust the value for the desired curve
                           border: Border.all(
                             color: Colors.grey, // Border color
                             width: 1.0, // Border width
                           )),
                           child: TextFormField(
                        
                            validator: checkFieldEmpty,
                            controller: achievementController,
                             decoration: const InputDecoration(
                               border: InputBorder.none, // Remove the default underline
                               contentPadding: EdgeInsets.symmetric(horizontal: 10.0), // Adjust the padding as needed
                               hintText: 'Achievement', // Placeholder text
                             ),),
                         ),
                       ),
                       kHeight20,
                        Padding(
                         padding: const EdgeInsets.only(right: 10.0, left: 10),
                         child: Container(
                           decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10.0), // Adjust the value for the desired curve
                           border: Border.all(
                             color: Colors.grey, // Border color
                             width: 1.0, // Border width
                           )),
                           child: TextFormField(
                            validator: checkFieldEmpty,
                            controller: dateOfAchievementController,
                             decoration: const InputDecoration(
                               border: InputBorder.none, // Remove the default underline
                               contentPadding: EdgeInsets.symmetric(horizontal: 10.0), // Adjust the padding as needed
                               hintText: 'Date of Achievement', // Placeholder text
                             ),),
                         ),
                       ), kHeight20,
                        Padding(
                         padding: const EdgeInsets.only(right: 10.0, left: 10),
                         child: Container(
                           decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10.0), // Adjust the value for the desired curve
                           border: Border.all(
                             color: Colors.grey, // Border color
                             width: 1.0, // Border width
                           )),
                           child: TextFormField(
                            validator: checkFieldEmpty,
                            controller: descriptionController,
                             decoration: const InputDecoration(
                               border: InputBorder.none, // Remove the default underline
                               contentPadding: EdgeInsets.symmetric(horizontal: 10.0), // Adjust the padding as needed
                               hintText: 'Description', // Placeholder text
                             ),),
                         ),
                       ),kHeight20, 
                      (loadingStatus==true)? const Center(
                        child: CircularProgressIndicator(),): MaterialButton(
                          onPressed: (){
                             if (_formKey.currentState!.validate()) {
                        addClassTeacherAchievementsToFirebase();
                             }
                       }, color: Colors.blue,
                        child: const Text('Add Achievement', 
                        style: TextStyle(color: Colors.white),),)
                      
                      
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}