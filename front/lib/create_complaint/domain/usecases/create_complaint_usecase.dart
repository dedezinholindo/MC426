import 'package:mc426_front/create_complaint/complaint.dart';

class CreateComplaintUsecase {
  final ComplaintRepository repository;

  const CreateComplaintUsecase(this.repository);

  Future<ComplaintResult> call(Complaint complaint) async {
    return await repository.createComplaint(complaint);
  }
}
