import 'package:mc426_front/hello_world/hello_world.dart';

class HelloWorldUsecase {
  final HelloWorldRepository repository;

  const HelloWorldUsecase(this.repository);

  Future<HelloWorld> call() async {
    return await repository.getHelloWorld();
  }
}
