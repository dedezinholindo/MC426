import 'package:mc426_front/hello_world/hello_world.dart';

class HelloWorldApiRepository extends HelloWorldRepository {
  @override
  Future<HelloWorld> getHelloWorld() async {
    // final result = await http.get(Uri.parse("localhost:8080/hello_world")); -> para fazer uma request http
    // return HelloWorld.fromMap(result.data);
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(HelloWorld(text: "Hello World"));
  }
}
