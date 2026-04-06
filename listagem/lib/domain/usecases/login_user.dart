import 'package:equatable/equatable.dart';
import '../../core/usecases/usecase.dart';

class LoginUser implements UseCase<bool, LoginParams> {
  @override
  Future<bool> call(LoginParams params) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulate mock delay
    if (params.username == 'admin' && params.password == '123') {
      return true;
    }
    return false;
  }
}

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}
