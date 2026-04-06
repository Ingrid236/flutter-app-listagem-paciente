import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:listagem/domain/usecases/login_user.dart';
import 'package:listagem/presentation/bloc/auth/auth_cubit.dart';

class MockLoginUser extends Mock implements LoginUser {}

void main() {
  late AuthCubit authCubit;
  late MockLoginUser mockLoginUser;

  setUp(() {
    mockLoginUser = MockLoginUser();
    authCubit = AuthCubit(loginUser: mockLoginUser);
    registerFallbackValue(
      const LoginParams(username: 'dummy', password: '123'),
    );
  });

  tearDown(() {
    authCubit.close();
  });

  test('initial state should be AuthInitial', () {
    expect(authCubit.state, AuthInitial());
  });

  blocTest<AuthCubit, AuthState>(
    'should emit [AuthLoading, AuthSuccess] when login is successful',
    build: () {
      when(() => mockLoginUser(any())).thenAnswer((_) async => true);
      return authCubit;
    },
    act: (cubit) => cubit.login('admin', '123'),
    expect: () => [AuthLoading(), AuthSuccess()],
  );

  blocTest<AuthCubit, AuthState>(
    'should emit [AuthLoading, AuthError] when login fails',
    build: () {
      when(() => mockLoginUser(any())).thenAnswer((_) async => false);
      return authCubit;
    },
    act: (cubit) => cubit.login('wrong', 'wrong'),
    expect: () => [AuthLoading(), const AuthError('Credenciais inválidas.')],
  );
}
