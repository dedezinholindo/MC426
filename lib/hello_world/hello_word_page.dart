import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc426_front/hello_world/hello_world.dart';
import 'package:mc426_front/hello_world/ui/bloc/hello_world_bloc.dart';

class HelloWorldPage extends StatefulWidget {
  const HelloWorldPage({super.key});

  @override
  State<HelloWorldPage> createState() => _HelloWorldPageState();
}

class _HelloWorldPageState extends State<HelloWorldPage> {
  final _bloc = HelloWorldBloc();

  @override
  void initState() {
    super.initState();
    _bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HelloWorldBloc, HelloWorldState>(
      bloc: _bloc,
      builder: (context, state) {
        final body = switch (state) {
          HelloWorldSuccessState() => HelloWorldSuccessView(helloWorld: state.helloWorld),
          HelloWorldFailedState() => const HelloWorldError(),
          HelloWorldLoadingState() => const HelloWorldLoading(),
        };

        return Scaffold(
          body: body,
        );
      },
    );
  }
}
