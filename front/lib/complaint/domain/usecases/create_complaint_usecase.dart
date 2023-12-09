import 'package:mc426_front/complaint/complaint.dart';

class CreateComplaintUsecase {
  final ComplaintRepository repository;

  const CreateComplaintUsecase(this.repository);

  Future<ComplaintResult> call(Complaint complaint) async {
    return await repository.createComplaint(complaint);
  }
}
