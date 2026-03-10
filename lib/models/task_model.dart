class TaskModel {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final String category;
  final String userId;
  final DateTime createdAt;
  final DateTime? dueDateTime;
  final bool isReminderEnabled;
  final bool isAlarmEnabled;

  TaskModel({
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    this.category = 'General',
    required this.userId,
    required this.createdAt,
    this.dueDateTime,
    this.isReminderEnabled = false,
    this.isAlarmEnabled = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'category': category,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'dueDateTime': dueDateTime?.toIso8601String(),
      'isReminderEnabled': isReminderEnabled,
      'isAlarmEnabled': isAlarmEnabled,
    };
  }

  factory TaskModel.fromJson(String id, Map<String, dynamic> json) {
    return TaskModel(
      id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      category: json['category'] ?? 'General',
      userId: json['userId'] ?? '',
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
      dueDateTime: json['dueDateTime'] != null 
          ? DateTime.parse(json['dueDateTime']) 
          : null,
      isReminderEnabled: json['isReminderEnabled'] ?? false,
      isAlarmEnabled: json['isAlarmEnabled'] ?? false,
    );
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    String? category,
    String? userId,
    DateTime? createdAt,
    DateTime? dueDateTime,
    bool? isReminderEnabled,
    bool? isAlarmEnabled,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category ?? this.category,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      dueDateTime: dueDateTime ?? this.dueDateTime,
      isReminderEnabled: isReminderEnabled ?? this.isReminderEnabled,
      isAlarmEnabled: isAlarmEnabled ?? this.isAlarmEnabled,
    );
  }
}
