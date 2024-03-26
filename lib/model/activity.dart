import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'activity.freezed.dart';
part 'activity.g.dart'; // Ensure this part directive is included

@freezed
class Activity extends HiveObject with _$Activity {
  Activity._(); // Add a private constructor
  
  @HiveType(typeId: 0)
  factory Activity({
    @HiveField(0) required String activity,
  }) = _Activity;

  // Ensure this factory method is included for JSON serialization
  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}
