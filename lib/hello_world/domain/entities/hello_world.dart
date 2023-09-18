class HelloWorld {
  final String text;

  HelloWorld({required this.text});

  factory HelloWorld.fromMap(Map<String, dynamic> map) {
    return HelloWorld(
      text: map["text"],
    );
  }
}
