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
                name,
                username,
                email,
                age,
                phone,
                password,
                verifyPassword,
                address,
                photo,
                safetyNumber,
              ) =>
                  _bloc.signUp(
                name: name,
                username: username,
                email: email,
                age: age,
                phone: phone,
                password: password,
                verifyPassword: verifyPassword,
                address: address,
                photo: photo,
                safetyNumber: safetyNumber,
              ),
            ),
        };

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
          body: body,
        );
      },
    );
  }
}
