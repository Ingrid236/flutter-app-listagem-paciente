import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/paciente.dart';
import '../bloc/paciente/paciente_cubit.dart';
import '../widgets/shared_text_field.dart';

class PacienteFormPage extends StatefulWidget {
  final Paciente? paciente;

  const PacienteFormPage({super.key, this.paciente});

  @override
  State<PacienteFormPage> createState() => _PacienteFormPageState();
}

class _PacienteFormPageState extends State<PacienteFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomeController;
  late final TextEditingController _procedimentoController;
  late final TextEditingController _observacoesController;
  DateTime? _selectedDate;

  bool get isEditing => widget.paciente != null;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.paciente?.nome ?? '');
    _procedimentoController = TextEditingController(
      text: widget.paciente?.procedimento ?? '',
    );
    _observacoesController = TextEditingController(
      text: widget.paciente?.observacoes ?? '',
    );
    _selectedDate = widget.paciente?.dataAtendimento;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _procedimentoController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  void _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final paciente = Paciente(
        id: isEditing
            ? widget.paciente!.id
            : 'temp-${DateTime.now().millisecondsSinceEpoch}',
        nome: _nomeController.text.trim(),
        procedimento: _procedimentoController.text.trim(),
        dataAtendimento: _selectedDate,
        observacoes: _observacoesController.text.trim(),
      );

      final cubit = context.read<PacienteCubit>();
      if (isEditing) {
        cubit.updatePaciente(paciente);
      } else {
        cubit.addPaciente(paciente);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Paciente' : 'Novo Paciente'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SharedTextField(
                label: 'Nome',
                controller: _nomeController,
                isRequired: true,
              ),
              SharedTextField(
                label: 'Procedimento',
                controller: _procedimentoController,
                isRequired: true,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  _selectedDate == null
                      ? 'Data de Atendimento (Opcional)'
                      : 'Data: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              const SizedBox(height: 16),
              SharedTextField(
                label: 'Observações (Opcional)',
                controller: _observacoesController,
              ),
              const SizedBox(height: 32),
              ElevatedButton(onPressed: _save, child: const Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}
