import 'package:flutter_hive_bored/bored_services.dart';
import 'package:flutter_hive_bored/model/activity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

// This creates a provider for managing the state of a list of activities.
final activityListProvider =
    StateNotifierProvider<ActivityListNotifier, AsyncValue<List<Activity>>>(
        (ref) {
  return ActivityListNotifier(ref.read);
});

// This class manages the state of the list of activities.
class ActivityListNotifier extends StateNotifier<AsyncValue<List<Activity>>> {
  final Reader _read; // Reader object to access other providers
  ActivityListNotifier(this._read) : super(AsyncValue.loading()) {
    _fetchActivities(); // When instantiated, fetch activites.
  }

  // Fetches activities from storage or an external service.
  Future<void> _fetchActivities() async {
    try {
      state = AsyncValue.loading(); // Set state to loading initially.
      final box =
          await Hive.openBox('activities'); // Open Hive box for activities.

      final raw = box.get('activities'); // Get raw activity data from Hive box.

      if (raw != null) {
        //If activities exist in storage, load them.
        final list = raw.map((e) => e as Activity).toList();
        state = AsyncValue.data(list); // Set state to loaded activites.
        print('empty val: $state');
      } else {
        // If no activites exitst in storage, fetch from external service.
        state = AsyncValue.loading();
        final activities = await _read(boredServiceProvider).fetchActivities();
        await box.put(
            'activities', activities); // Save fetched activities to storage
        state = AsyncValue.data(activities); // Set state to fetched activities.
        print('activity val: $state');
      }
    } catch (e) {
      //If an error occurs during fetching, set state to error.
      state = AsyncValue.error(e);
    }
  }

  // Adds a new activity to the list.
  void addActivity() async {
    final newActivity =
        await _read(boredServiceProvider).fetchActivity(); // Fetch new activity.
    state.whenData((activities) async {
      // When existing activities are available, add new activity to them.
      final updatedActivities = List<Activity>.from(activities)
        ..add(newActivity);
      state = AsyncValue.data(updatedActivities); // Set state to updated list of activities.
      final box = await Hive.openBox('activities'); // Open Hive box for activities.
      await box.put('activities', updatedActivities); // Save updated activities to storage.
      print(updatedActivities);
    });
  }
}
