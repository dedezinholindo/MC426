import 'package:mc426_front/complaint/complaint.dart';

final mockComplaint = Complaint(
  title: "Teste de Título",
  description: "Teste de Descrição",
  address: "Teste de Endereço",
  isAnonymous: false,
);

const mockComplaintResultSuccess = {"mensagem": "Denúncia criada com sucesso"};

const mockComplaintResultFailure = {"mensagem": "Falha ao criar denúncia"};
