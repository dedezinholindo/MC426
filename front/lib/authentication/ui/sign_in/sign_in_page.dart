import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/authentication/ui/sign_in/bloc/sign_in_bloc.dart';
import 'package:mc426_front/home/home.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/sign_in';

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _bloc = SignInBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is SignInLoadedState && state.result != null) {
          if (state.result!.isSuccess) {
            Navigator.of(context).pushNamed(HomePage.routeName);
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(milliseconds: 1000),
              content: Text(state.result!.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        Widget? body = switch (state) {
          SignInLoadedState() => SignInLoadedView(
              isLoading: state.isLoading,
              signIn: (username, password) => _bloc.signIn(
                username: username,
                password: password,
              ),
            ),
        };

        return Scaffold(
          body: body,
        );
      },
    );
  }
}
