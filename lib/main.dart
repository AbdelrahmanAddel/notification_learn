import 'package:flutter/material.dart';
import 'package:notification_learn/local_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.init();
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
                onPressed: () async {
                  print('Send Period  Message ✅');
                  await LocalNotification.sendRepeatedNotification();
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
                onPressed: () async {
                  print('Send One Time Message ✅');

                  await LocalNotification.sendSimpleNotification();
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
              SizedBox(height: 30),
              MaterialButton(
                minWidth: 200,
                height: 60,
                color: Colors.redAccent,

                shape: StadiumBorder(),
                onPressed: () {
                  LocalNotification.cancelAllNotifications();
                },
                child: Text('Cancel All Notifications'),
              ),
              SizedBox(height: 50),
              MaterialButton(
                minWidth: 200,
                height: 60,
                color: Colors.yellow,

                shape: StadiumBorder(),
                onPressed: () async {
                  print('On Schedule Time  ✅');

                  await LocalNotification.sendScheduleNotification();
                },
                child: Text(
                  'Send On Chosen Time',
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
