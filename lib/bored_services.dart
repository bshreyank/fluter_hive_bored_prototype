import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/activity.dart';

final boredServiceProvider = Provider<BoredService>((ref) {
  return BoredService(Dio());
});

class BoredService {
  final Dio _dio;
  BoredService(this._dio);

  Future<Activity> fetchActivity() async {
    try {
      final response = await _dio
          .get<Map<String, dynamic>>('http://www.boredapi.com/api/activity/');
      return Activity.fromJson(
          response.data!); // Ensure response.data is not null
    } catch (e) {
      throw Exception('Failed to fetch activity: $e');
    }
  }

  Future<List<Activity>> fetchActivities() async {
    try {
      final response = await _dio
          .get<Map<String, dynamic>>('http://www.boredapi.com/api/activity/');
      final activity =
          Activity.fromJson(response.data!); // Parse a single activity
      return [activity]; // Return a list containing the parsed activity
    } catch (e) {
      throw Exception('Failed to fetch activities: $e');
    }
  }
}
