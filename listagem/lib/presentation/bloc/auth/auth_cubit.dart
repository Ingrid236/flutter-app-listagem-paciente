import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/login_user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUser loginUser;

  AuthCubit({required this.loginUser}) : super(AuthInitial());

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    final success = await loginUser(
      LoginParams(username: username, password: password),
    );
    if (success) {
      emit(AuthSuccess());
    } else {
      emit(const AuthError('Credenciais inválidas.'));
    }
  }
}
