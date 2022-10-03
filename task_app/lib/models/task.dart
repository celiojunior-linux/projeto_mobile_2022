class Task {
  final int? id;

  final String description;
  final String createdAt;
  bool done;
  final int author;

  Task({
    required this.id,
    required this.description,
    required this.createdAt,
    required this.done,
    required this.author,
  });

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'description': description.toString(),
        'created_at': createdAt.toString(),
        'done': done.toString(),
        'author': author.toString(),
      };

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      description: json['description'],
      createdAt: json['created_at'],
      done: json['done'],
      author: json['author'],
    );
  }

  @override
  String toString() {
    return '[$id] $description ($author)';
  }
}
