import 'package:hive/hive.dart';
part 'parent_login_database.g.dart';

@HiveType(typeId: 1)
class DBParentLogin {
  @HiveField(0)
  final String schoolID;
  @HiveField(1)
  final String batchID;
  @HiveField(2)
  final String classID;
  @HiveField(3)
  final String studentID;
  @HiveField(4)
  final String? studentName;
  @HiveField(5)
  final String parentID;
  @HiveField(6)
  final String emailID;
  @HiveField(7)
  final String parentDocID;
  @HiveField(8)
  final String parentEmail;
  @HiveField(9)
  final String parentPassword;

  DBParentLogin({
    required this.schoolID,
    required this.batchID,
    required this.classID,
    required this.studentID,
    this.studentName,
    required this.parentID,
    required this.emailID,
    required this.parentDocID,
    required this.parentEmail,
    required this.parentPassword,
  });
}
