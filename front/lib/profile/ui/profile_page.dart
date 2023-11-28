import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc426_front/profile/profile.dart';
import 'package:mc426_front/profile/ui/bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _bloc = ProfileBloc();

  @override
  void initState() async {
    super.initState();
    await _bloc.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: _bloc,
      builder: (context, state) {
        Widget? body = switch (state) {
          ProfileLoadingState() => const Center(child: CircularProgressIndicator()),
          ProfileLoadedState() || ProfileEditState() => ProfileLoadedView(
              profile: state is ProfileEditState ? state.profile : (state as ProfileLoadedState).profile,
              onChange: _bloc.changeProfile,
              isEditing: state is ProfileEditState,
            ),
          ProfileErrorState() => const ProfileErrorView(),
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
            bottomNavigationBar: state is ProfileLoadedState || state is ProfileEditState
                ? SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (state is ProfileEditState) ...[
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _bloc.changeMode,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return const Color(0xFFC53D46);
                                    },
                                  ),
                                ),
                                child: const Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),
                          ],
                          Expanded(
                            child: ElevatedButton(
                              onPressed: state is ProfileEditState ? () async => await _bloc.editProfile() : _bloc.changeMode,
                              child: Text(
                                state is ProfileEditState ? 'Salvar' : 'Editar',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
            body: body,
          ),
        );
      },
    );
  }
}
