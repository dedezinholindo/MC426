import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:humanitarian_icons/humanitarian_icons.dart';
import 'package:mc426_front/authentication/authentication.dart';
import 'package:mc426_front/home/home.dart';
import 'package:mc426_front/home/ui/bloc/home_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = HomeBloc();

  void _logout() {
    _bloc.logout();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(SignInPage.routeName, (route) => true);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _bloc.init();
    });
  }

  Future<void> _makePhoneCallFromSharedPreferences() async {
    final emergencyNumber = _bloc.safetyNumber;
    _makePhoneCall(emergencyNumber);
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      _bloc.emitPanicState(error: PanicStateErrors.callError);
    }
  }

  Future<void> _sendPanicAlert(BuildContext context) async {
    bool confirm = await _showPanicConfirmationDialog(context);
    final status = await Permission.location.request();
    if (confirm && status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _bloc.sendPanicAlert(position);
    }
  }

  Future<bool> _showPanicConfirmationDialog(BuildContext context) async {
    bool? dialogResult;
    bool isDialogShowing = true;

    dialogResult = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 10), () {
          if (isDialogShowing) {
            Navigator.of(context).pop(true);
          }
        });
        return AlertDialog(
          backgroundColor: Colors.red[700],
          title: const Text(
            'Confirmação de Pânico',
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Confirma que deseja acionar o botão de pânico?\nSua localização será enviada para todos os usuários próximos.',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    'Acionar',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
    isDialogShowing = false;
    return dialogResult ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is HomePanicState && state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  state.error == PanicStateErrors.callError
                      ? 'Não foi possível fazer a chamada'
                      : 'Não foi possível enviar a push',
                  style: const TextStyle(fontSize: 16)),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is HomePanicState && state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Push enviada com sucesso!',
                  style: TextStyle(fontSize: 16)),
              backgroundColor: Colors.green,
            ),
          );
          _bloc.init();
        }
      },
      builder: (context, state) {
        Widget? body = switch (state) {
          HomeLoadingState() => const CircularProgressIndicator(),
          HomeLoadedState() => HomeLoadedView(
              home: state.home,
              vote: _bloc.vote,
              panicButton: _bloc.emitPanicState,
            ),
          HomePanicState() => EmergencyView(
              contactEmergency: _makePhoneCallFromSharedPreferences,
              police: () => _makePhoneCall("190"),
              panicButton: () => _sendPanicAlert(context),
            ),
          HomeErrorState() => const HomeErrorView(),
        };

        return Scaffold(
          drawerEnableOpenDragGesture: false,
          drawer: HomeDrawer(logout: _logout),
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: Builder(
              builder: (context) {
                return state is HomePanicState
                    ? IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                        onPressed: () async => await _bloc.init(),
                      )
                    : IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _bloc.emitPanicState,
            child: const Icon(
              HumanitarianIcons.police_station,
            ),
          ),
          body: body,
        );
      },
    );
  }
}
