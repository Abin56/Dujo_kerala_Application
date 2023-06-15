import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../utils/utils.dart';
import '../userCredentials/user_credentials.dart';

class RecordedClassController {
  TextEditingController chapterNumberController = TextEditingController();
  TextEditingController chapterNameController = TextEditingController();

  //upload page controllers

  TextEditingController subjectNameUploadPageController =
      TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  RxBool isLoading = RxBool(false);
  RxBool chapterIsLoading = RxBool(false);
  Uuid uuid = const Uuid();
  String downloadUrl = '';
  final progressData = RxDouble(0.0);

  Rxn<File?> file = Rxn();

  Future<void> createChapter(String subjectId, String subjectName) async {
    try {
      chapterIsLoading.value = true;
      String generatedDocID = subjectName + uuid.v1();
      FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('subjects')
          .doc(subjectId)
          .collection('recorded_classes_chapters')
          .doc(generatedDocID)
          .set({
        'chapterNumber': chapterNumberController.text,
        'chapterName': chapterNameController.text,
        'subjectName': subjectName,
        'docid': generatedDocID,
        'uploadedBy':
            UserCredentialsController.teacherModel!.teacherName.toString()
      }).then((value) {
        chapterNumberController.clear();
        chapterNameController.clear();
      });
      chapterIsLoading.value = false;
    } catch (e) {
      chapterIsLoading.value = false;
      showToast(msg: "Something Went Wrong");
    }
  }

  Future<void> uploadToFirebase({
    required BuildContext context,
    required String subjectID,
    required String chapterID,
    required String subjectName,
    required String chapterName,
  }) async {
    try {
      isLoading.value = true;
      String uid2 = const Uuid().v1();
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(
            "${UserCredentialsController.schoolId}/${UserCredentialsController.batchId}/${UserCredentialsController.classId}/files/recorded_clasees/$subjectName/$chapterName/$chapterName$uid2",
          )
          .putFile(file.value!);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        progressData.value = progress;
      });

      final taskProgress = await uploadTask;

      downloadUrl = await taskProgress.ref.getDownloadURL();
      String uid = const Uuid().v1();
      FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('subjects')
          .doc(subjectID)
          .collection('recorded_classes_chapters')
          .doc(chapterID)
          .collection('RecordedClass')
          .doc(uid)
          .set({
        'subjectName': subjectName,
        'chapterName': chapterName,
        'chapterID': chapterID,
        'subjectID': subjectID,
        'topicName': topicController.text,
        'title': titleController.text,
        'downloadUrl': downloadUrl,
        'fileId': "$chapterName$uid2",
        'docid': uid,
        'uploadedBy': UserCredentialsController.teacherModel?.teacherName
      }).then((value) {
        file.value = null;
        topicController.clear();
        titleController.clear();
        showToast(msg: "Uploaded Successfully");
        Get.back();
      });

      isLoading.value = false;
    } catch (e) {
      log(e.toString(), name: "RecordedClassController");
      showToast(msg: "Something Went Wrong");
    }
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowedExtensions: ['mkv', 'mp4', 'mov', 'avi'],
          type: FileType.custom,
          allowCompression: true);

      if (result != null) {
        file.value = File(result.files.single.path!);
      } else {
        log('No file selected', name: "RecordedClassController");
      }
    } catch (e) {
      log(e.toString(), name: "RecordedClassController");
    }
  }
}
