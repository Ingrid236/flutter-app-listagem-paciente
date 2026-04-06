import 'package:flutter_test/flutter_test.dart';
import 'package:listagem/domain/usecases/login_user.dart';

void main() {
  late LoginUser usecase;

  setUp(() {
    usecase = LoginUser();
  });

  test('should return true when credentials are admin/123', () async {
    final result = await usecase(
      const LoginParams(username: 'admin', password: '123'),
    );
    expect(result, true);
  });

  test('should return false when credentials are invalid', () async {
    final result = await usecase(
      const LoginParams(username: 'admin', password: 'wrong'),
    );
    expect(result, false);
  });
}
