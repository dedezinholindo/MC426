import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc426_front/create_complaint/complaint.dart';
import 'package:get_it/get_it.dart';

part 'complaint_state.dart';

class ComplaintBloc extends Cubit<ComplaintState> {
 
  final usecase = GetIt.instance.get<CreateComplaintUsecase>();
  ComplaintBloc() : super(ComplaintLoadedState(isLoading: false));

  void createComplaint(Complaint complaint) async {
    emit(ComplaintLoadedState(isLoading: true));
    final result = await usecase.call(complaint);
    emit(ComplaintLoadedState(result: result, isLoading: false));
    }
  }