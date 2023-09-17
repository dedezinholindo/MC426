import 'package:mc426_front/Create_Complaint/complaint.dart';

abstract class ComplaintRepository {
  Future<ComplaintResult> createComplaint(Complaint complaint);
}