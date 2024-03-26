import 'package:flutter/material.dart';
import 'package:flutter_hive_bored/activity_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(activityListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bored Activities'),
      ),
      body: activities.when(
        data: (activities) => ListView.builder(
          itemCount: activities.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(activities[index].activity),
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          print(error);
          print(stack);
          return Center(child: Text('Error: $error'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(activityListProvider.notifier).addActivity(),
        child: Icon(Icons.add),
      ),
    );
  }
}
