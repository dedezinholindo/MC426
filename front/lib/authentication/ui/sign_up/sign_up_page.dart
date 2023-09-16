import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/authentication/ui/sign_up/bloc/sign_up_bloc.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/sign_up';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _bloc = SignUpBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is SignUpLoadedState && state.result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(milliseconds: 1000),
              content: Text(state.result!.message),
              backgroundColor: state.result!.isSuccess ? Colors.green : Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        Widget? body = switch (state) {
          SignUpLoadedState() => SignUpLoadedView(
              isLoading: state.isLoading,
              signUp: (
                username,
                password,
                age,
                name,
                email,
              ) =>
                  _bloc.signUp(
                username: username,
                password: password,
                age: age,
                name: name,
                email: email,
              ),
            ),
        };

        return Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
          body: body,
        );
      },
    );
  }
}
