import 'package:mc426_front/complaint/complaint.dart';

abstract class ComplaintRepository {
  Future<ComplaintResult> createComplaint({required String userId, required Complaint complaint});
}
