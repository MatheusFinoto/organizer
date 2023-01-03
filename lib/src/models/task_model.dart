class TaskModel {
  String? id;
  String? title;
  String? description;
  String? createdAt;
  String? doneAt;
  bool? done;

  TaskModel(
      {this.id,
      this.title,
      this.description,
      this.createdAt,
      this.doneAt,
      this.done});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    doneAt = json['done_at'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['done_at'] = doneAt;
    data['done'] = done;
    return data;
  }

  
}
