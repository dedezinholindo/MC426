import 'package:mc426_front/Create_Complaint/complaint.dart';
class ComplaintResult {
  final bool isSuccess;
  final String message;
  final Complaint? complaint;

  const ComplaintResult({required this.isSuccess, required this.message, this.complaint});
}