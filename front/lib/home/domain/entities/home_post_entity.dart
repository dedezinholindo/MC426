class HomePostEntity {
  final int id;
  final String? photo;
  final String? name;
  final String description;
  final String local;
  final int upVotes;
  final int downVotes;
  final bool? userUpVoted;
  final bool isAnonymous;
  final bool canVote;

  const HomePostEntity({
    required this.id,
    required this.description,
    required this.local,
    required this.upVotes,
    required this.downVotes,
    this.userUpVoted,
    this.isAnonymous = false,
    this.canVote = true,
    this.name,
    this.photo,
  });

  factory HomePostEntity.fromMap(Map<String, dynamic> map) {
    return HomePostEntity(
      id: map["post_id"],
      photo: map["author_photo"],
      description: map["post_description"],
      local: map["address"],
      userUpVoted: map["user_like"] != null ? map["user_like"] == 1 : null,
      name: map["author_username"],
      upVotes: map["likes"] ?? 0,
      downVotes: map["unlikes"] ?? 0,
      isAnonymous: map["isAnonymous"] == 1,
      canVote: map["can_vote"] == 1,
    );
  }
}
