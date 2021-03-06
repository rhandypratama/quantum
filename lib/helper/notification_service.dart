// import 'dart:convert';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// import 'package:birthday_calendar/constants.dart';
// import 'package:birthday_calendar/model/user_birthday.dart';

// class NotificationService {
//   static final NotificationService _notificationService = NotificationService._internal();

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   factory NotificationService() {
//     return _notificationService;
//   }

//   NotificationService._internal();

//   static const channel_id = "123";

//   Future<void> init() async {

//     final AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

//     final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid, 
//       iOS: null, 
//       macOS: null
//     );
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onSelectNotification: selectNotification
//     );
//     tz.initializeTimeZones();
//   }

//   Future selectNotification(String payload) async {
//     UserBirthday userBirthday = getUserBirthdayFromPayload(payload);
//     cancelNotificationForBirthday(userBirthday);
//     scheduleNotificationForBirthday(userBirthday, "${userBirthday.name} has an upcoming birthday!");
//   }

//   void showNotification(UserBirthday userBirthday, String notificationMessage) async {
//     await flutterLocalNotificationsPlugin.show(
//         userBirthday.hashCode,
//         applicationName,
//         notificationMessage,
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel_id, 
//             applicationName,
//             'To remind you about upcoming birthdays'
//           )
//         ),
//         payload: jsonEncode(userBirthday)
//     );
//   }

//   void scheduleNotificationForBirthday(UserBirthday userBirthday, String notificationMessage) async {
//     DateTime now = DateTime.now();
//     DateTime birthdayDate = userBirthday.birthdayDate;
//     Duration difference = now.isAfter(birthdayDate)
//         ? now.difference(birthdayDate)
//         : birthdayDate.difference(now);

//     _wasApplicationLaunchedFromNotification()
//         .then((bool didApplicationLaunchFromNotification) => {
//       if (didApplicationLaunchFromNotification && difference.inDays == 0) {
//           scheduleNotificationForNextYear(userBirthday, notificationMessage)}
//       else if (!didApplicationLaunchFromNotification && difference.inDays == 0) {
//           showNotification(userBirthday, notificationMessage)}
//         });

//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         userBirthday.hashCode,
//         applicationName,
//         notificationMessage,
//         tz.TZDateTime.now(tz.local).add(difference),
//         const NotificationDetails(
//             android: AndroidNotificationDetails(channel_id, applicationName,
//                 'To remind you about upcoming birthdays')),
//         payload: jsonEncode(userBirthday),
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime);
//   }

//   void scheduleNotificationForNextYear(UserBirthday userBirthday, String notificationMessage) async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         userBirthday.hashCode,
//         applicationName,
//         notificationMessage,
//         tz.TZDateTime.now(tz.local).add(new Duration(days: 365)),
//         const NotificationDetails(
//             android: AndroidNotificationDetails(channel_id, applicationName,
//                 'To remind you about upcoming birthdays')),
//         payload: jsonEncode(userBirthday),
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime);
//   }

//   void cancelNotificationForBirthday(UserBirthday birthday) async {
//     await flutterLocalNotificationsPlugin.cancel(birthday.hashCode);
//   }

//   void cancelAllNotifications() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }

//   void handleApplicationWasLaunchedFromNotification() async {
//     final NotificationAppLaunchDetails? notificationAppLaunchDetails =
//         await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

//     if (notificationAppLaunchDetails!.didNotificationLaunchApp) {
//       UserBirthday userBirthday = getUserBirthdayFromPayload(notificationAppLaunchDetails.payload);
//       cancelNotificationForBirthday(userBirthday);
//       scheduleNotificationForBirthday(userBirthday, "${userBirthday.name} has an upcoming birthday!");
//     }
//   }

//   UserBirthday getUserBirthdayFromPayload(String payload) {
//     Map<String, dynamic> json = jsonDecode(payload);
//     UserBirthday userBirthday = UserBirthday.fromJson(json);
//     return userBirthday;
//   }

//   Future<bool> _wasApplicationLaunchedFromNotification() async {
//     final NotificationAppLaunchDetails? notificationAppLaunchDetails =
//     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

//     return notificationAppLaunchDetails!.didNotificationLaunchApp;
//   }
// }