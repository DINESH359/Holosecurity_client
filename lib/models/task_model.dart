// lib/models/task_model.dart

class Task {
  final String id; // Task ID (useful for identification in APIs)
  final String title; // Title of the task
  final String description; // Description of the task
  bool completed; // Status of task (true = completed, false = not completed)

  // Constructor
  Task({
    required this.id,
    required this.title,
    required this.description,
    this.completed = false,
  });

  // Factory method to create a Task from a JSON object
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      completed: json['completed'] ?? false,
    );
  }

  // Method to convert a Task to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
    };
  }
}
