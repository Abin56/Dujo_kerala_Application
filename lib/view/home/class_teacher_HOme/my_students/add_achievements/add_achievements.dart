

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/home/class_teacher_HOme/my_students/student_details/show_student_achievements.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                //'timestamp': DateTime.now(),
                'studentID': widget.studentDetail['docid'], 
                'photoUrl': widget.studentDetail['profileImageUrl'], 
                'description': descriptionController.text, 
                'dateOfAchievement': dateOfAchievementController.text, 
                'admissionNumber': widget.studentDetail['admissionNumber'], 
                'achievement': achievementController.text,
                'docid':uid
              }).then((value) => showDialog(context: context, builder: (context){
                return AlertDialog(
                  title: Text('Students Achievements'.tr),
                  content:  Text('New Achievement added!'.tr),
                  actions: [
                    MaterialButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, color: Colors.blue, child:  Padding(
                      padding:  const EdgeInsets.all(8.0),
                      child:  Text('Ok'.tr),
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
     // resizeToAvoidBottomInset: true,
      appBar: AppBar(title:GooglePoppinsWidgets(text: 'Add Achievement'.tr,fontsize: 18.w),backgroundColor:adminePrimayColor ,),
      body: SafeArea(
        child: Center(
          child: Form(key: _formKey,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
               // IconButtonBackWidget(color: cblack,),
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
                             decoration:  InputDecoration(
                               border: InputBorder.none, // Remove the default underline
                               contentPadding: const EdgeInsets.symmetric(horizontal: 10.0), // Adjust the padding as needed
                               hintText: 'Achievement'.tr, // Placeholder text
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
                             decoration:  InputDecoration(
                               border: InputBorder.none, // Remove the default underline
                               contentPadding: const EdgeInsets.symmetric(horizontal: 10.0), // Adjust the padding as needed
                               hintText: 'Date of Achievement'.tr, // Placeholder text
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
                             decoration:  InputDecoration(
                               border: InputBorder.none, // Remove the default underline
                               contentPadding: const EdgeInsets.symmetric(horizontal: 10.0), // Adjust the padding as needed
                               hintText: 'Descriptions'.tr, // Placeholder text
                             ),),
                         ),
                       ),kHeight20, 
                      (loadingStatus==true)? const Center(
                        child: CircularProgressIndicator(),): MaterialButton(
                          onPressed: (){
                             if (_formKey.currentState!.validate()) {
                        addClassTeacherAchievementsToFirebase();
                         checkfield();
                             }
                       }, color: Colors.blue,
                        child:  Text('Add Achievement'.tr, 
                        style: const TextStyle(color: Colors.white),),), 
                        kHeight20, 
                        MaterialButton(
                          onPressed: (){
                           
                          Navigator.push(context, MaterialPageRoute
                          (builder: (context)=>  ShowStudentAchievements(
                            studentID: widget.studentDetail['docid'],)));
                        },
                         color: Colors.blue,
                         child: Text('Show Achievements of ${widget.studentDetail['studentName'].toString().capitalize}', 
                         style:  const TextStyle(color: Colors.white),),)
                      
                      
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
  void checkfield(){
    dateOfAchievementController.clear();
    achievementController.clear();
    descriptionController.clear();

  }
}