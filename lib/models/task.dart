class Task {
  final id;
  final title;
  final description;
  Task({this.id, this.title, this.description}) {
    // TODO: implement
    throw UnimplementedError();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
