// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GeneralInstructionModel {
  String instruction;
  String instructionId;
  String time;
  GeneralInstructionModel({
    required this.instruction,
    required this.instructionId,
    required this.time,
  });

  GeneralInstructionModel copyWith({
    String? instruction,
    String? instructionId,
    String? time,
  }) {
    return GeneralInstructionModel(
      instruction: instruction ?? this.instruction,
      instructionId: instructionId ?? this.instructionId,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'instruction': instruction,
      'instructionId': instructionId,
      'time': time,
    };
  }

  factory GeneralInstructionModel.fromMap(Map<String, dynamic> map) {
    return GeneralInstructionModel(
      instruction: map['instruction'] as String,
      instructionId: map['instructionId'] as String,
      time: map['time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GeneralInstructionModel.fromJson(String source) =>
      GeneralInstructionModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GeneralInstructionModel(instruction: $instruction, instructionId: $instructionId, time: $time)';

  @override
  bool operator ==(covariant GeneralInstructionModel other) {
    if (identical(this, other)) return true;

    return other.instruction == instruction &&
        other.instructionId == instructionId &&
        other.time == time;
  }

  @override
  int get hashCode =>
      instruction.hashCode ^ instructionId.hashCode ^ time.hashCode;
}
