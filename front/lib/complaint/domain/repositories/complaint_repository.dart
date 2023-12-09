import 'package:mc426_front/complaint/complaint.dart';

abstract class ComplaintRepository {
  Future<ComplaintResult> createComplaint(Complaint complaint);
}