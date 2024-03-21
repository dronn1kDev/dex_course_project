import 'package:dex_course_temp/core/data/remote_response.dart';
import 'package:dex_course_temp/features/auth/data/model/auth_credentials.dart';

abstract interface class AuthDataSource {
  Future<RemoteResponse<AuthCredentialsModel>> signIn({
    required final String phone,
    required final String password,
  });

  Future<RemoteResponse<AuthCredentialsModel>> signUp({
    required final String phone,
    required final String password,
  });
}
