import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc426_front/create_complaint/ui/bloc/complaint_bloc.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _bloc = ComplaintBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplaintBloc, ComplaintState>(
      bloc: _bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Perfil',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0xFF4CE5B1),
          ),
          body: const SingleChildScrollView(
            child: Column(),
          ),
        );
      },
    );
  }
}
