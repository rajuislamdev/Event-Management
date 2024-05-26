import 'dart:convert';

class EventModel {
  final String? id;
  final String category;
  final String eventName;
  final String organizer;
  final String date;
  final String time;
  final String location;
  final String details;
  final String deadline;
  final int fee;
  EventModel({
    this.id,
    required this.category,
    required this.eventName,
    required this.organizer,
    required this.date,
    required this.time,
    required this.location,
    required this.details,
    required this.deadline,
    required this.fee,
  });

  EventModel copyWith({
    String? id,
    String? category,
    String? eventName,
    String? organizer,
    String? date,
    String? time,
    String? locationn,
    String? details,
    String? deadline,
    int? fee,
  }) {
    return EventModel(
      id: id ?? this.id,
      category: category ?? this.category,
      eventName: eventName ?? this.eventName,
      organizer: organizer ?? this.organizer,
      date: date ?? this.date,
      time: time ?? this.time,
      location: locationn ?? location,
      details: details ?? this.details,
      deadline: deadline ?? this.deadline,
      fee: fee ?? this.fee,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'eventName': eventName.toLowerCase(),
      'organizer': organizer,
      'date': date,
      'time': time,
      'locationn': location,
      'details': details,
      'deadline': deadline,
      'fee': fee,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] as String? ?? '',
      category: map['category'] as String,
      eventName: map['eventName'] as String,
      organizer: map['organizer'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
      location: map['locationn'] as String,
      details: map['details'] as String,
      deadline: map['deadline'] as String,
      fee: map['fee'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
