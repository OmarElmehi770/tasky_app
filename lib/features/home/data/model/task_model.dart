class TaskModel {
  String? id;
  final String? title;
  final String? desc;
  final DateTime? date;
  final int? priority;
  bool isDone;

  TaskModel({
    this.id,
    this.title,
    this.desc,
    this.date,
    this.isDone = false,
    this.priority,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'],
        title: json['title'],
        desc: json['desc'],
        date: DateTime.fromMillisecondsSinceEpoch(json['date']),
        isDone: json['isDone'],
        priority: json['priority'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'desc': desc,
    'date': date!.millisecondsSinceEpoch,
    'isDone': isDone,
    'priority': priority,
  };



}
