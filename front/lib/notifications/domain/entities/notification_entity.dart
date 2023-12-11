class NotificationEntity {
  final int id;
  final String description;
  final String title;
  final bool isActivated;

  NotificationEntity({required this.id, required this.description, required this.title, required this.isActivated});

  factory NotificationEntity.fromMap(Map<String, dynamic> map) {
    return NotificationEntity(
      id: map["id"],
      description: map["description"],
      title: map["title"],
      isActivated: map["isActivated"],
    );
  }

  Map<String, dynamic> get toMap => {
        "id": id,
        "description": description,
        "title": title,
        "isActivated": isActivated,
      };

  NotificationEntity copyWith({
    int? id,
    String? description,
    String? title,
    bool? isActivated,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      title: title ?? this.title,
      isActivated: isActivated ?? this.isActivated,
    );
  }
}
