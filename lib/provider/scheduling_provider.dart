import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:yess_nutrion/utils/background_service.dart';
import 'package:yess_nutrion/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledResto(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling Resto Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Resto Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
