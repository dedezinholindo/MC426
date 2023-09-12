part of 'hello_world_bloc.dart';

sealed class HelloWorldState {
  const HelloWorldState();
}

class HelloWorldSuccessState extends HelloWorldState {
  final HelloWorld helloWorld;
  const HelloWorldSuccessState({required this.helloWorld});
}

class HelloWorldFailedState extends HelloWorldState {
  const HelloWorldFailedState();
}

class HelloWorldLoadingState extends HelloWorldState {
  const HelloWorldLoadingState();
}
