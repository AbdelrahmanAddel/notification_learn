import 'package:flutter/material.dart';
import 'package:notification_learn/local_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                minWidth: 200,
                height: 60,
                color: Colors.red,
                shape: StadiumBorder(),
                onPressed: () {
                  print('Send Schedule Message ✅');
                  LocalNotificationService.showScheduleMessage();
                },
                child: Text(
                  'Send Schedule',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),
              MaterialButton(
                minWidth: 200,
                height: 60,
                color: Colors.blueAccent,

                shape: StadiumBorder(),
                onPressed: () {
                  print('Send One Time Message ✅');

                  LocalNotificationService.showOneTimeMessage();
                },
                child: Text(
                  'Send One Time',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
