import 'package:flutter/material.dart';

class AlarmInfo {
  int id;
  String title;
  DateTime alarmDateTime;
  bool isPending;
  int gradientColorIndex;

  AlarmInfo({
    required this.id,
    required this.title,
    required this.alarmDateTime,
    required this.isPending,
    required this.gradientColorIndex,
  });

  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
        id: json["alr_id"],
        title: json["alr_title"],
        alarmDateTime: DateTime.parse(json["alr_dateTime"]),
        isPending: json["alr_isPending"],
        gradientColorIndex: json["alr_gradientColorIndex"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "alarmDateTime": alarmDateTime,
        "isPending": isPending,
        "gradientColorIndex": gradientColorIndex,
      };
}
