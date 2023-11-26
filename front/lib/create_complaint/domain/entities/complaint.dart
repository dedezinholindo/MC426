class Complaint {
  final String title;
  final String description;
  final String address;
  final bool isAnonymous;

  Complaint({
    required this.title,
    required this.description,
    required this.address,
    required this.isAnonymous,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'address': address,
      'isAnonymous': isAnonymous,
    };
  }

  static Complaint fromMap(Map<String, dynamic> map) {
    return Complaint(
      title: map['title'],
      description: map['description'],
      address: map['address'],
      isAnonymous: map['isAnonymous'],
    );
  }
}
