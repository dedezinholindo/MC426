import 'package:mc426_front/hello_world/hello_world.dart';

class HelloWorldApiRepository extends HelloWorldRepository {
  @override
  Future<HelloWorld> getHelloWorld() async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(HelloWorld(text: "Hello World"));
  }
}
