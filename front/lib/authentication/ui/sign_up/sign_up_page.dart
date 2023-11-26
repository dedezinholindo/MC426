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
          SignUpLoadedState() => SignUpLoadedView(key: UniqueKey(), onChange: _bloc.changeForms),
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
          body: Scaffold(
            primary: false,
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ValueListenableBuilder<bool>(
                  valueListenable: _bloc.isAvailable,
                  builder: (context, value, child) {
                    return ElevatedButton(
                      onPressed: value ? _bloc.signUp : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _bloc.state.params.isLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Cadastrar',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            body: body,
          ),
        );
      },
    );
  }
}
