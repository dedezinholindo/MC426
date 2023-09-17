part of 'complaint_bloc.dart';

class ComplaintState {}

class ComplaintLoadedState extends ComplaintState {
  final bool isLoading;
  final ComplaintResult? result;

  ComplaintLoadedState({this.isLoading = false, this.result});
}