import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/paciente.dart';
import '../bloc/paciente/paciente_cubit.dart';
import '../bloc/paciente_form/paciente_form_cubit.dart';
import '../bloc/paciente_form/paciente_form_state.dart';
import '../widgets/app_form_field.dart';
import '../widgets/app_button.dart';
import '../widgets/app_spacing.dart';
import '../../../core/validators/form_validators.dart';
import '../../../core/formatters/mask_formatters.dart';

class PacienteFormPage extends StatefulWidget {
  final Paciente? paciente;

  const PacienteFormPage({super.key, this.paciente});

  @override
  State<PacienteFormPage> createState() => _PacienteFormPageState();
}

class _PacienteFormPageState extends State<PacienteFormPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  final TextEditingController _dataController = TextEditingController();

  bool get isEditing => widget.paciente != null;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.paciente?.dataAtendimento;
    if (_selectedDate != null) {
      _dataController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
    }
  }

  @override
  void dispose() {
    _dataController.dispose();
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
        _dataController.text = DateFormat('dd/MM/yyyy').format(date);
      });
    }
  }

  void _save(PacienteFormCubit formCubit) {
    if (_formKey.currentState!.validate()) {
      final paciente = Paciente(
        id: isEditing
            ? widget.paciente!.id
            : 'temp-${DateTime.now().millisecondsSinceEpoch}',
        nome: formCubit.nomeController.text.trim(),
        procedimento: formCubit.procedimentoController.text.trim(),
        telefone: formCubit.telefoneController.text.trim(),
        cpf: formCubit.cpfController.text.trim(),
        email: formCubit.emailController.text.trim(),
        tipo: formCubit.state.selectedTipo,
        dataAtendimento: _selectedDate,
        observacoes: formCubit.observacoesController.text.trim(),
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
    return BlocProvider(
      create: (context) {
        final cubit = PacienteFormCubit();
        if (isEditing) {
          cubit.nomeController.text = widget.paciente?.nome ?? '';
          cubit.procedimentoController.text =
              widget.paciente?.procedimento ?? '';
          cubit.telefoneController.text = widget.paciente?.telefone ?? '';
          cubit.cpfController.text = widget.paciente?.cpf ?? '';
          cubit.emailController.text = widget.paciente?.email ?? '';
          cubit.observacoesController.text = widget.paciente?.observacoes ?? '';
          cubit.updateTipo(widget.paciente?.tipo);
        }
        return cubit;
      },
      child: BlocBuilder<PacienteFormCubit, PacienteFormState>(
        builder: (context, state) {
          final formCubit = context.read<PacienteFormCubit>();

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
                    AppFormField(
                      label: 'Nome *',
                      hintText: 'Nome completo do paciente',
                      controller: formCubit.nomeController,
                      validator: (value) =>
                          FormValidators.validateRequired(value, 'Nome'),
                    ),
                    AppSpacing.verticalMd,
                    AppFormField(
                      label: 'CPF *',
                      hintText: '000.000.000-00',
                      controller: formCubit.cpfController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [AppMasks.cpfMask],
                      validator: FormValidators.validateCPF,
                    ),
                    AppSpacing.verticalMd,
                    AppFormField(
                      label: 'Telefone *',
                      hintText: '(00) 00000-0000',
                      controller: formCubit.telefoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [AppMasks.phoneMask],
                      validator: FormValidators.validatePhone,
                    ),
                    AppSpacing.verticalMd,
                    AppFormField(
                      label: 'E-mail *',
                      hintText: 'paciente@email.com',
                      controller: formCubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: FormValidators.validateEmail,
                    ),
                    AppSpacing.verticalMd,
                    DropdownButtonFormField<String>(
                      value: state.selectedTipo,
                      decoration: InputDecoration(
                        labelText: 'Tipo de Paciente *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Endodontia',
                          child: Text('Endodontia'),
                        ),
                        DropdownMenuItem(
                          value: 'Ortodontia',
                          child: Text('Ortodontia'),
                        ),
                        DropdownMenuItem(
                          value: 'Periodontia',
                          child: Text('Periodontia'),
                        ),
                      ],
                      onChanged: formCubit.updateTipo,
                      validator: (val) =>
                          (val == null) ? 'Selecione um tipo' : null,
                    ),
                    AppSpacing.verticalMd,
                    AppFormField(
                      label: 'Procedimento *',
                      hintText: 'Descreva o procedimento',
                      controller: formCubit.procedimentoController,
                      validator: (value) => FormValidators.validateRequired(
                        value,
                        'Procedimento',
                      ),
                    ),
                    AppSpacing.verticalMd,
                    AppFormField(
                      label: 'Data de Atendimento *',
                      hintText: 'Clique para selecionar a data',
                      controller: _dataController,
                      readOnly: true,
                      onTap: _pickDate,
                      validator: (value) => FormValidators.validateRequired(
                        value,
                        'Data de Atendimento',
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: _pickDate,
                      ),
                    ),
                    AppSpacing.verticalMd,
                    AppFormField(
                      label: 'Observações (Opcional)',
                      hintText: 'Informações adicionais',
                      controller: formCubit.observacoesController,
                      maxLines: 3,
                    ),
                    AppSpacing.verticalXl,
                    AppButton(
                      onPressed: () => _save(formCubit),
                      text: 'Salvar',
                      icon: isEditing ? Icons.edit : Icons.add,
                      fullWidth: true,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
