class HomePostEntity {
  final int id;
  final String? photo;
  final String? name;
  final String description;
  final String local;
  final String time;
  final int upVotes;
  final int downVotes;
  final bool userUpVoted;
  final bool userDownVoted;
  final bool isAnonymous;

  const HomePostEntity({
    required this.id,
    required this.description,
    required this.time,
    required this.local,
    required this.upVotes,
    required this.downVotes,
    this.userUpVoted = false,
    this.userDownVoted = false,
    this.isAnonymous = false,
    this.name,
    this.photo,
  });

  factory HomePostEntity.fromMap(Map<String, dynamic> map) {
    return HomePostEntity(
      id: map["id"],
      photo: map["photo"],
      description: map["description"],
      local: map["local"],
      userUpVoted: map["userUpVoted"] ?? false,
      userDownVoted: map["userDownVoted"] ?? false,
      name: map["name"],
      upVotes: map["upVotes"] ?? 0,
      downVotes: map["downVotes"] ?? 0,
      time: map["time"],
      isAnonymous: map["isAnonymous"] ?? false,
    );
  }
}
