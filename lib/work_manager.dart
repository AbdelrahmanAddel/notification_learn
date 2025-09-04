import 'package:notification_learn/local_notification.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    LocalNotification.sendScheduleNotification();

    return Future.value(true);
  });
}

class WorkManagerService {
  Future<void> registerMyTask() async {
    await Workmanager().registerPeriodicTask("1", "Work Manager Task");
  }

  Future init() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    await registerMyTask();
  }
}
