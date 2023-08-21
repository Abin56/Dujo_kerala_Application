import '../../model/guardian_model/guardian_model.dart';
import '../../model/parent_model/parent_model.dart';
import 'package:dujo_kerala_application/model/teacher_model/teacher_model.dart';

import '../../model/student_model/student_model.dart';

class UserCredentialsController {
  static String? schoolId;
  static String? batchId;
  static String? classId;
  static String? userRole;
  static StudentModel? studentModel;
  static ParentModel? parentModel;
  static GuardianModel? guardianModel;
  static TeacherModel? teacherModel;

  static void  clearUserCredentials() {
    schoolId = null;
    batchId = null;
    classId = null;
    userRole = null;
    studentModel = null;
    parentModel = null;
    guardianModel = null;
    teacherModel = null;
  }
}
