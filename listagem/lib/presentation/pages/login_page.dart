import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_cubit.dart';
import 'pacientes_list_page.dart';
import '../widgets/app_form_field.dart';
import '../widgets/app_button.dart';
import '../widgets/app_spacing.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        _usernameController.text,
        _passwordController.text,
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AuthSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const PacientesListPage()),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.medical_services_outlined,
                        size: 80,
                        color: Colors.blue,
                      ),
                      AppSpacing.verticalMd,
                      Text(
                        'Bem-vindo de volta',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                      ),
                      Text(
                        'Entre para gerenciar seus pacientes',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      AppSpacing.verticalXl,
                      AppFormField(
                        controller: _usernameController,
                        label: 'Usuário',
                        hintText: 'Digite seu usuário',
                        validator: (value) => 
                            (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
                      ),
                      AppSpacing.verticalMd,
                      AppFormField(
                        controller: _passwordController,
                        label: 'Senha',
                        hintText: 'Digite sua senha',
                        obscureText: true,
                        validator: (value) => 
                            (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
                      ),
                      AppSpacing.verticalXl,
                      if (state is AuthLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        AppButton(
                          onPressed: _onLogin,
                          text: 'Entrar',
                          icon: Icons.login,
                          fullWidth: true,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
