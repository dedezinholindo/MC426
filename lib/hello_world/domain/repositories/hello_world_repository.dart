import 'package:mc426_front/hello_world/hello_world.dart';

abstract class HelloWorldRepository {
  Future<HelloWorld> getHelloWorld();
}
