// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClassEventModel {
  String eventName;
  String eventDescription;
  String eventDate;
  String signedBy;
  String venue;
  String docid;
  ClassEventModel({
    required this.eventName,
    required this.eventDescription,
    required this.eventDate,
    required this.signedBy,
    required this.venue,
    required this.docid,
  });

  ClassEventModel copyWith({
    String? eventName,
    String? eventDescription,
    String? eventDate,
    String? signedBy,
    String? venue,
    String? docid,
  }) {
    return ClassEventModel(
      eventName: eventName ?? this.eventName,
      eventDescription: eventDescription ?? this.eventDescription,
      eventDate: eventDate ?? this.eventDate,
      signedBy: signedBy ?? this.signedBy,
      venue: venue ?? this.venue,
      docid: docid ?? this.docid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventName': eventName,
      'eventDescription': eventDescription,
      'eventDate': eventDate,
      'signedBy': signedBy,
      'venue': venue,
      'docid': docid,
    };
  }

  factory ClassEventModel.fromMap(Map<String, dynamic> map) {
    return ClassEventModel(
      eventName: map['eventName'] as String,
      eventDescription: map['eventDescription'] as String,
      eventDate: map['eventDate'] as String,
      signedBy: map['signedBy'] as String,
      venue: map['venue'] as String,
      docid: map['docid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassEventModel.fromJson(String source) =>
      ClassEventModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClassEventModel(eventName: $eventName, eventDescription: $eventDescription, eventDate: $eventDate, signedBy: $signedBy, venue: $venue, docid: $docid)';
  }

  @override
  bool operator ==(covariant ClassEventModel other) {
    if (identical(this, other)) return true;

    return other.eventName == eventName &&
        other.eventDescription == eventDescription &&
        other.eventDate == eventDate &&
        other.signedBy == signedBy &&
        other.venue == venue &&
        other.docid == docid;
  }

  @override
  int get hashCode {
    return eventName.hashCode ^
        eventDescription.hashCode ^
        eventDate.hashCode ^
        signedBy.hashCode ^
        venue.hashCode ^
        docid.hashCode;
  }
}
