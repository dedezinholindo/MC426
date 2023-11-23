import 'package:mc426_front/create_complaint/complaint.dart';

abstract class ComplaintRepository {
  Future<ComplaintResult> createComplaint(Complaint complaint);
}