class NotificationEntity {
  final int id;
  final String description;
  final String title;
  final String topicName;
  final bool isActivated;

  NotificationEntity({
    required this.id,
    required this.description,
    required this.title,
    required this.isActivated,
    required this.topicName,
  });

  factory NotificationEntity.fromMap(Map<String, dynamic> map) {
    return NotificationEntity(
      id: map["id"],
      description: map["description"],
      title: map["title"],
      isActivated: map["isActivated"],
      topicName: map["topicName"],
    );
  }

  NotificationEntity copyWith({
    int? id,
    String? description,
    String? title,
    bool? isActivated,
    String? topicName,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      title: title ?? this.title,
      isActivated: isActivated ?? this.isActivated,
      topicName: topicName ?? this.topicName,
    );
  }
}
