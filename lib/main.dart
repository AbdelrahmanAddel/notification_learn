import 'package:flutter/material.dart';
import 'package:notification_learn/local_notification.dart';
import 'package:notification_learn/notification_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  @override
  void initState() {
    super.initState();
    _onDidReceiveNotificationResponse();
  }

  _onDidReceiveNotificationResponse() {
    print('Done');
    LocalNotification.notificationStream.stream.listen((onData) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotificationDetailsScreen()),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
                await LocalNotification.sendRepeatedNotification();
              },
              child: Text(
                'Send Repeated',
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
    );
  }
}
