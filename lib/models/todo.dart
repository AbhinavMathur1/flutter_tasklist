class Todo {
  final id;
  final taskId;
  final title;
  final isDone;
  Todo({this.id, this.title, this.isDone, this.taskId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
      'taskId': taskId,
    };
  }
}
