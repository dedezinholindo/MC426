import 'package:flutter/material.dart';
import 'package:mc426_front/Create_Complaint/complaint.dart'; 

class ComplaintLoadedView extends StatefulWidget {
  final bool isLoading;
  final ComplaintResult? result;
  final void Function(Complaint complaint) createComplaint;

  const ComplaintLoadedView({
    required this.isLoading,
    required this.createComplaint,
    this.result,
    Key? key,
  }) : super(key: key);

  @override
  State<ComplaintLoadedView> createState() => _ComplaintLoadedViewState();
}

class _ComplaintLoadedViewState extends State<ComplaintLoadedView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isAnonymous = false;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'Informe o título da denúncia',
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Descrição',
              hintText: 'Descreva a denúncia',
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              widget.createComplaint(
                Complaint(
                  title: titleController.text,
                  description: descriptionController.text,
                  address: addressController.text,
                  isAnonymous: isAnonymous,
                ),
              );
            },
            child: widget.isLoading
                ? const CircularProgressIndicator()
                : const Text('Criar denúncia'),
          ),
          if (widget.result != null)
            Text(widget.result!.isSuccess
                ? widget.result!.message
                : 'Falha ao criar denúncia'),
        ],
      ),
    ); 
  }
}
