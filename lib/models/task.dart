class Task {
  final String id;
  final String title;
  final bool isCompleted;
  final String userId;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'userId': userId,
    };
  }

  factory Task.fromJson(String id, Map<String, dynamic> json) {
    return Task(
      id: id,
      title: json['title'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      userId: json['userId'] ?? '',
    );
  }

  Task copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    String? userId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      userId: userId ?? this.userId,
    );
  }
}
