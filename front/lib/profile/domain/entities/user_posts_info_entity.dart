class UserPostInfoEntity {
  final int id;
  final String description;
  final String local;
  final String time;
  final int upVotes;
  final int downVotes;

  const UserPostInfoEntity({
    required this.id,
    required this.description,
    required this.time,
    required this.local,
    required this.upVotes,
    required this.downVotes,
  });

  factory UserPostInfoEntity.fromMap(Map<String, dynamic> map) {
    return UserPostInfoEntity(
      id: map["id"],
      description: map["description"],
      local: map["local"],
      upVotes: map["upVotes"] ?? 0,
      downVotes: map["downVotes"] ?? 0,
      time: map["time"],
    );
  }
}
