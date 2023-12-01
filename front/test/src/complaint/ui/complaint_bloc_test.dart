import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mc426_front/complaint/complaint.dart';
import 'package:mc426_front/complaint/ui/bloc/complaint_bloc.dart';
import 'package:mocktail/mocktail.dart';
import '../mocks/mocks.dart';

class ComplaintUsecaseMock extends Mock implements CreateComplaintUsecase {}

void main() {
  late final CreateComplaintUsecase complaintUsecase;

  setUpAll(() {
    final injection = GetIt.instance;
    complaintUsecase = ComplaintUsecaseMock();

    injection.registerFactory<CreateComplaintUsecase>(() => complaintUsecase);
    registerFallbackValue(mockComplaint);
  });

  group("submitComplaint", () {
    blocTest<ComplaintBloc, ComplaintState>(
      'should return ComplaintResult success when the request is completed',
      build: () {
        when(() => complaintUsecase.call(any())).thenAnswer((_) async => ComplaintResult(
              isSuccess: true,
              message: mockComplaintResultSuccess["mensagem"] ?? "",
            ));
        return ComplaintBloc();
      },
      act: (bloc) => bloc.createComplaint(
        Complaint(
        title: "Test Title", 
        description: "Test Description", 
        address: "Test Address",
        isAnonymous: false,
        ),
      ),
      expect: () => [
        isA<ComplaintLoadedState>().having((s) => s.isLoading, "is loading", true),
        isA<ComplaintLoadedState>().having((s) => s.isLoading, "is loading", false),
      ],
    );

    blocTest<ComplaintBloc, ComplaintState>(
      'should return ComplaintResult fails when the request is failed',
      build: () {
        when(() => complaintUsecase.call(any())).thenAnswer((_) async => ComplaintResult(
              isSuccess: false,
              message: mockComplaintResultFailure["mensagem"] ?? "",
            ));
        return ComplaintBloc();
      },
      act: (bloc) => bloc.createComplaint(
        Complaint(
        title: "Test Title",
        description: "Test Description",
        address: "Test Address",
        isAnonymous: false,
        ),
      ),
      expect: () => [
        isA<ComplaintLoadedState>().having((s) => s.isLoading, "is loading", true),
        isA<ComplaintLoadedState>().having((s) => s.isLoading, "is loading", false),
      ],
    );
  });
}
