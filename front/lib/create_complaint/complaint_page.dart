import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc426_front/create_complaint/complaint.dart';
import 'package:mc426_front/create_complaint/ui/bloc/complaint_bloc.dart';

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
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0xFF4CE5B1),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 148),
                  TextFormField(
                    controller: titleController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Escreva um título para a denúncia',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: TextStyle(color: Color(0xFF5F5F5F)),
                      fillColor: Color(0xFF141414),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF141414))
                      )
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: addressController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Informe o endereço da denúncia',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: TextStyle(color: Color(0xFF5F5F5F)),
                      fillColor: Color(0xFF141414),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF141414))
                      )
                    ),
                  ),
                  const SizedBox(height: 16),
                    TextFormField(
                      maxLines: 8,
                      controller: descriptionController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Descreva a denúncia',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: TextStyle(color: Color(0xFF5F5F5F)),
                        fillColor: Color(0xFF141414),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF141414))
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        const Text(
                        'Denúncia anônima?',
                        style: TextStyle(color: Color(0xFF5F5F5F))
                        ),
                      Switch(
                        value: isAnonymous,
                        onChanged: (value) {
                          setState(() {
                            isAnonymous = value;
                          });
                        },
                        inactiveThumbColor: const Color(0xFF5F5F5F),
                        activeColor: const Color(0xFF4CE5B1),
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
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4CE5B1)),
                    ),
                    child: const Text(
                      'Criar denúncia',
                      style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white
                        )
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}