import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:permission_handler/permission_handler.dart';
import '../models/task_model.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz_data.initializeTimeZones();
    // Correct icon path for notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _notificationsPlugin.initialize(initializationSettings);
  }

  Future<bool> requestPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  Future<void> scheduleTaskNotification(TaskModel task) async {
    if (task.dueDateTime == null || (!task.isReminderEnabled && !task.isAlarmEnabled)) {
      return;
    }

    DateTime scheduledTime = task.dueDateTime!.subtract(const Duration(minutes: 10));
    bool isBigEvent = task.category == 'Work' || task.title.toLowerCase().contains('big');
    if (isBigEvent) {
      scheduledTime = task.dueDateTime!.subtract(const Duration(days: 1));
    }

    if (scheduledTime.isBefore(DateTime.now())) {
      scheduledTime = task.dueDateTime!.subtract(const Duration(minutes: 1));
    }
    
    if (scheduledTime.isBefore(DateTime.now())) return;

    final int id = task.id.hashCode;

    await _notificationsPlugin.zonedSchedule(
      id,
      'Task Reminder: ${task.title}',
      task.description.isNotEmpty ? task.description : 'Your task is starting soon!',
      tz.TZDateTime.from(scheduledTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'task_reminders',
          'Task Reminders',
          channelDescription: 'Notifications for task reminders',
          importance: Importance.max,
          priority: Priority.high,
          fullScreenIntent: task.isAlarmEnabled,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelNotification(String taskId) async {
    await _notificationsPlugin.cancel(taskId.hashCode);
  }
}
