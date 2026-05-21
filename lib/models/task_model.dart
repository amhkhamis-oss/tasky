class TaskModel {
  final int id;
  final String taskName;
  final String taskDescription;
  final bool isHighPriority;
  bool isCheck;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    this.isCheck = false,
  });
  factory TaskModel.fromJson(Map<String, dynamic> e) {
    return TaskModel(
      id: e["id"],
      taskName: e["taskName"],
      taskDescription: e["taskDescription"],
      isHighPriority: e["isHighPriority"],
      isCheck: e["isCheck"] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "taskName": taskName,
      "taskDescription": taskDescription,
      "isHighPriority": isHighPriority,
      "isCheck": isCheck,
    };
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, taskName: $taskName, taskDescription: $taskDescription, isHighPriority: $isHighPriority, isCheck: $isCheck)';
  }
}
