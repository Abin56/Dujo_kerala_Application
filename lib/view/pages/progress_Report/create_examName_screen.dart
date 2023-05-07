import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'all_student_list.dart';

class CreateExamNameScreen extends StatelessWidget {
  String schooilID;
  String classID;
  String teacherId;
  String batchId;
  TextEditingController _examNameController = TextEditingController();
  CreateExamNameScreen(
      {required this.schooilID,
      required this.classID,
      required this.teacherId,
      required this.batchId,
      super.key});

  @override
  Widget build(BuildContext context) {
    int columnCount = 3;
    double _w = MediaQuery.of(context).size.width;
    double _h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Exam Name"),
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("SchoolListCollection")
                  .doc(schooilID)
                  .collection(batchId)
                  .doc(batchId)
                  .collection("classes")
                  .doc(classID)
                  .collection("ProgressReport")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return AnimationLimiter(
                    child: GridView.count(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      padding: EdgeInsets.all(_w / 60),
                      crossAxisCount: columnCount,
                      children: List.generate(
                        snapshot.data!.docs.length,
                        (int index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 200),
                            columnCount: columnCount,
                            child: ScaleAnimation(
                              duration: const Duration(milliseconds: 900),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: FadeInAnimation(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(AllStudentsListScreen(
                                        batchId: batchId,
                                        teacherId: teacherId,
                                        examName: snapshot.data!.docs[index]
                                            .data()['docid'],
                                        schooilID: schooilID,
                                        classID: classID));
                                  },
                                  child: Container(
                                    height: _h / 100,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        bottom: _w / 10,
                                        left: _w / 50,
                                        right: _w / 50),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(212, 67, 30, 203)
                                              .withOpacity(0.1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 40,
                                          spreadRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        snapshot.data!.docs[index]
                                            .data()['docid'],
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Enter Exam Name'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      TextField(
                          controller: _examNameController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              hintText: 'Enter Exam Name',

                              // prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(19),
                                borderSide: BorderSide.none,
                              )),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 18,
                          )),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Create'),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("SchoolListCollection")
                          .doc(schooilID)
                          .collection(batchId)
                          .doc(batchId)
                          .collection("classes")
                          .doc(classID)
                          .collection("ProgressReport")
                          .doc(_examNameController.text.trim())
                          .set({
                        'docid': _examNameController.text.trim(),
                        'date': DateTime.now().toString()
                      }).then((value) => Get.back());
                    },
                  ),
                  TextButton(
                    child: const Text('cancel'),
                    onPressed: () async {
                      Get.back();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
