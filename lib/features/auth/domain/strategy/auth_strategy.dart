import 'package:dex_course_temp/core/domain/use_case_result/use_case_result.dart';
import 'package:dex_course_temp/features/auth/domain/entity/auth_credentials.dart';
import 'package:dex_course_temp/features/auth/domain/repository/auth_repository.dart';

abstract class AuthStrategy {
  Future<UseCaseResult<AuthCredentials>> call();
}

abstract class SignUpStrategy implements AuthStrategy {}

abstract class SignInStrategy implements AuthStrategy {}

class DefaultSignInStrategy implements SignInStrategy {
  final AuthRepository _authRepository;

  final String phone;
  final String password;

  DefaultSignInStrategy({
    required final AuthRepository authRepository,
    required this.phone,
    required this.password,
  }) : _authRepository = authRepository;

  @override
  Future<UseCaseResult<AuthCredentials>> call() async {
    return await _authRepository.signIn(phone: phone, password: password);
  }
}

class GoogleServiceSignInStrategy implements SignInStrategy {
  // final GoogleService googleService;

  @override
  Future<UseCaseResult<AuthCredentials>> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}
