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
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0xFF4CE5B1),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 150.0, right: 16.0, left: 16.0),
            child: SingleChildScrollView(  // Adicionado SingleChildScrollView
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: titleController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Título',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(color: Color(0xFF5F5F5F)),
                      hintText: 'Escreva um título para a denúncia',
                      hintStyle: TextStyle(color: Color(0xFF5F5F5F)),
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
                      labelText: 'Endereço',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(color: Color(0xFF5F5F5F)),
                      hintText: 'Informe o endereço da denúncia',
                      hintStyle: TextStyle(color: Color(0xFF5F5F5F)),
                      fillColor: Color(0xFF141414),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF141414))
                      )
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200.0,
                    child: TextFormField(
                      controller: descriptionController,
                      style: const TextStyle(color: Colors.white),
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                        contentPadding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 10.0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(color: Color(0xFF5F5F5F)),
                        hintText: 'Descreva a denúncia',
                        hintStyle: TextStyle(color: Color(0xFF5F5F5F)),
                        fillColor: Color(0xFF141414),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF141414))
                        ),
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