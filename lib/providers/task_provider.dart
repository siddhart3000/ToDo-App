import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';
import '../services/notification_service.dart';
import 'auth_provider.dart';

final taskServiceProvider = Provider<TaskService>((ref) => TaskService());

final tasksProvider = StateNotifierProvider<TaskNotifier, AsyncValue<List<TaskModel>>>((ref) {
  final user = ref.watch(userProvider);
  return TaskNotifier(ref.read(taskServiceProvider), user?.uid);
});

class TaskNotifier extends StateNotifier<AsyncValue<List<TaskModel>>> {
  final TaskService _service;
  final String? _userId;
  final NotificationService _notifications = NotificationService();

  TaskNotifier(this._service, this._userId) : super(const AsyncValue.loading()) {
    if (_userId != null) {
      fetchTasks();
    } else {
      state = const AsyncValue.data([]);
    }
  }

  Future<void> fetchTasks() async {
    if (_userId == null) return;
    state = const AsyncValue.loading();
    try {
      final tasks = await _service.fetchTasks(_userId!);
      state = AsyncValue.data(tasks);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addTask(String title, String description, String category, {DateTime? dueDateTime}) async {
    if (_userId == null) return;
    try {
      final newTask = TaskModel(
        id: '',
        title: title,
        description: description,
        userId: _userId!,
        category: category,
        createdAt: DateTime.now(),
        dueDateTime: dueDateTime,
        isReminderEnabled: true, // Auto-enable reminder if time is set
      );
      final addedTask = await _service.addTask(newTask);
      
      // Schedule notification
      if (dueDateTime != null) {
        await _notifications.scheduleTaskNotification(addedTask);
      }

      state.whenData((tasks) {
        state = AsyncValue.data([...tasks, addedTask]);
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await _service.updateTask(task);
      
      // Reschedule or cancel notification
      if (task.dueDateTime != null && task.isReminderEnabled) {
        await _notifications.scheduleTaskNotification(task);
      } else {
        await _notifications.cancelNotification(task.id);
      }

      state.whenData((tasks) {
        state = AsyncValue.data([
          for (final t in tasks)
            if (t.id == task.id) task else t
        ]);
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> toggleTask(TaskModel task) async {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    await updateTask(updatedTask);
  }

  Future<void> deleteTask(String id) async {
    try {
      await _service.deleteTask(id);
      await _notifications.cancelNotification(id);

      state.whenData((tasks) {
        state = AsyncValue.data(tasks.where((t) => t.id != id).toList());
      });
    } catch (e) {
      // Handle error
    }
  }
}
