import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/hello_world/hello_world.dart';

part 'hello_world_state.dart';

class HelloWorldBloc extends Cubit<HelloWorldState> {
  HelloWorldBloc() : super(const HelloWorldLoadingState());

  final usecase = GetIt.instance.get<HelloWorldUsecase>();

  void init() async {
    try {
      emit(const HelloWorldLoadingState());
      final result = await usecase.call();
      emit(HelloWorldSuccessState(helloWorld: result));
    } catch (e) {
      emit(const HelloWorldFailedState());
    }
  }
}
