import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc426_front/Create_Complaint/complaint.dart';
import 'package:mc426_front/Create_Complaint/ui/bloc/complaint_bloc.dart';

class ComplaintPage extends StatefulWidget {
  static const String routeName = '/complaint';

  const ComplaintPage({super.key});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {

TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isAnonymous = false;
  
  final _bloc = ComplaintBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComplaintBloc, ComplaintState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is ComplaintLoadedState && state.result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(milliseconds: 1500),
              content: Text(state.result!.message),
              backgroundColor: state.result!.isSuccess ? Colors.green : Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Criar Denúncia',
              style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    hintText: 'Escreva um título para a denúncia',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    hintText: 'Descreva a denúncia',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Endereço',
                    hintText: 'Informe o endereço da denúncia',
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Denúncia anônima?'),
                    Switch(
                      value: isAnonymous,
                      onChanged: (value) {
                        setState(() {
                          isAnonymous = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Complaint newComplaint = Complaint(
                      title: titleController.text,
                      description: descriptionController.text,
                      address: addressController.text,
                      isAnonymous: isAnonymous,
                      );
                    _bloc.createComplaint(newComplaint);
                  },
                  child: const Text(
                    'Criar denúncia',
                    style: TextStyle(
                    fontSize: 16.0,
                      )
                    ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}