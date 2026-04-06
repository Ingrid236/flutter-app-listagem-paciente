import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listagem/data/repositories/paciente_repository_memory_impl.dart';
import 'package:listagem/domain/usecases/get_pacientes.dart';
import 'package:listagem/domain/usecases/login_user.dart';
import 'package:listagem/presentation/bloc/auth/auth_cubit.dart';
import 'package:listagem/presentation/bloc/paciente/paciente_cubit.dart';
import 'package:listagem/presentation/pages/login_page.dart';

import 'package:listagem/domain/usecases/add_paciente.dart';
import 'package:listagem/domain/usecases/update_paciente.dart';
import 'package:listagem/domain/usecases/delete_paciente.dart';

import 'package:listagem/core/theme/app_theme.dart';

// Basic Service Locator / DI
class ServiceLocator {
  static late final AuthCubit authCubit;
  static late final PacienteCubit pacienteCubit;

  static void init() {
    // Repositories
    final pacienteRepo = PacienteRepositoryMemoryImpl();

    // UseCases
    final loginUser = LoginUser();
    final getPacientes = GetPacientes(pacienteRepo);
    final addPaciente = AddPaciente(pacienteRepo);
    final updatePaciente = UpdatePaciente(pacienteRepo);
    final deletePaciente = DeletePaciente(pacienteRepo);

    // Blocs
    authCubit = AuthCubit(loginUser: loginUser);
    pacienteCubit = PacienteCubit(
      getPacientes: getPacientes,
      addPacienteUseCase: addPaciente,
      updatePacienteUseCase: updatePaciente,
      deletePacienteUseCase: deletePaciente,
    );
  }
}

void main() {
  ServiceLocator.init();
  runApp(const PacientesApp());
}

class PacientesApp extends StatelessWidget {
  const PacientesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: ServiceLocator.authCubit),
        BlocProvider.value(value: ServiceLocator.pacienteCubit),
      ],
      child: MaterialApp(
        title: 'Pacientes CRUD',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const LoginPage(),
      ),
    );
  }
}
