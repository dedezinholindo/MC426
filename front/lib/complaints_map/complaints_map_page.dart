import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc426_front/complaints_map/complaints_map.dart';
import 'package:mc426_front/complaints_map/ui/bloc/complaint_map_bloc.dart';

class ComplaintMapPage extends StatefulWidget {
  static const String routeName = '/complaint/map';
  const ComplaintMapPage({super.key});

  @override
  State<ComplaintMapPage> createState() => _ComplaintMapPageState();
}

class _ComplaintMapPageState extends State<ComplaintMapPage> {
  final _bloc = ComplaintsMapBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _bloc.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplaintsMapBloc, ComplaintMapState>(
      bloc: _bloc,
      builder: (context, state) {
        Widget? body = switch (state) {
          ComplaintMapLoadingState() => const Center(child: CircularProgressIndicator()),
          ComplaintMapLoadedState() => ComplaintMapLoadedView(coordinates: state.coordinates),
          ComplaintMapErrorState() => const ComplaintMapErrorView(),
        };

        return Scaffold(
          drawerEnableOpenDragGesture: false,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text(
              "Mapa de Denúnicas",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
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
