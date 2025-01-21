import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Initialization
  static Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInitializationSettings =
    DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Create Notification Channel (Android)
  static Future<void> createAndroidNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel_id', // Unique channel ID
      'Channel Name', // Channel name
      description: 'Description of the channel',
      importance: Importance.high,
      sound: RawResourceAndroidNotificationSound('alarm'), // Custom sound
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Show Notification
  static Future<void> showNotification({
    required String timerName,
  }) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'channel_id', // Channel ID (must match the one defined in createAndroidNotificationChannel)
      'Channel Name',
      sound: RawResourceAndroidNotificationSound('alarm'),
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      sound: 'alarm.mp3', // iOS custom sound
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      50,
      "Time's up",
      "$timerName timer was finished",
      notificationDetails,
    );
  }




}
