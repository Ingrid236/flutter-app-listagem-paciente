import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/paciente.dart';
import '../bloc/paciente/paciente_cubit.dart';
import '../widgets/app_input.dart';
import '../widgets/app_button.dart';

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
              AppInput(
                label: 'Nome *',
                controller: _nomeController,
                validator: (value) => 
                    (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
              ),
              AppInput(
                label: 'Procedimento *',
                controller: _procedimentoController,
                validator: (value) => 
                    (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
              ),
              AppInput(
                label: _selectedDate == null
                    ? 'Data de Atendimento (Opcional)'
                    : 'Data: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
                readOnly: true,
                onTap: _pickDate,
              ),
              AppInput(
                label: 'Observações (Opcional)',
                controller: _observacoesController,
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              AppButton(
                onPressed: _save,
                text: 'Salvar',
                icon: isEditing ? Icons.edit : Icons.add,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
