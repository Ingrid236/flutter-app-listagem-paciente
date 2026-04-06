import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/paciente/paciente_cubit.dart';
import 'paciente_form_page.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';
import '../widgets/shared_confirmation_dialog.dart';

class PacientesListPage extends StatefulWidget {
  const PacientesListPage({super.key});

  @override
  State<PacientesListPage> createState() => _PacientesListPageState();
}

class _PacientesListPageState extends State<PacientesListPage> {
  @override
  void initState() {
    super.initState();
    context.read<PacienteCubit>().fetchPacientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacientes'),
      ),
      floatingActionButton: AppButton(
        text: 'Novo Paciente',
        icon: Icons.add,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const PacienteFormPage()),
          );
        },
      ),
      body: BlocBuilder<PacienteCubit, PacienteState>(
        builder: (context, state) {
          if (state is PacienteLoading || state is PacienteInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PacienteError) {
            return Center(child: Text(state.message));
          } else if (state is PacienteLoaded) {
            if (state.pacientes.isEmpty) {
              return const Center(child: Text('Nenhum paciente cadastrado.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.only(top: 16.0, bottom: 80.0),
              itemCount: state.pacientes.length,
              itemBuilder: (context, index) {
                final paciente = state.pacientes[index];
                return Dismissible(
                  key: Key(paciente.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
                    padding: const EdgeInsets.only(right: 16.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (_) async {
                    return await SharedConfirmationDialog.show(
                      context,
                      title: 'Excluir Paciente',
                      content:
                          'Tem certeza que deseja excluir ${paciente.nome}?',
                    );
                  },
                  onDismissed: (_) {
                    context.read<PacienteCubit>().deletePaciente(paciente.id);
                  },
                  child: AppCard(
                    margin: const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      title: Text(
                        paciente.nome,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
                      ),
                      subtitle: Text(paciente.procedimento),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PacienteFormPage(paciente: paciente),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
