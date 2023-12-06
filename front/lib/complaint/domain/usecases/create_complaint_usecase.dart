import 'package:mc426_front/common/common.dart';
import 'package:mc426_front/complaint/complaint.dart';
import 'package:mc426_front/storage/storage.dart';

class CreateComplaintUsecase {
  final ComplaintRepository repository;
  final StorageInterface storage;

  const CreateComplaintUsecase(this.repository, this.storage);

  Future<ComplaintResult> call(Complaint complaint) async {
    final userId = storage.getString(userIdKey);
    if (userId == null) return const ComplaintResult(isSuccess: false, message: "Falha ao criar denúncia");
    return await repository.createComplaint(userId: userId, complaint: complaint);
  }
}
