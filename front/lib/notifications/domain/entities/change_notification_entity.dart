class ChangeNotificationEntity {
  final int id;
  final String userId;
  final bool isActivated;

  ChangeNotificationEntity({
    required this.id,
    required this.userId,
    required this.isActivated,
  });

  Map<String, dynamic> get toMap => {
        "id": id,
        "user_id": userId,
        "is_active": isActivated,
      };
}
