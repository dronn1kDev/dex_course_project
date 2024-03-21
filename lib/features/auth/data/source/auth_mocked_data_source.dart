import 'package:dex_course_temp/core/data/model/rest_api_error_model.dart';
import 'package:dex_course_temp/core/data/remote_response.dart';
import 'package:dex_course_temp/features/auth/data/model/auth_credentials.dart';
import 'package:dex_course_temp/features/auth/data/source/auth_data.dart';

class AuthMockedDataSource implements AuthDataSource {
  @override
  Future<RemoteResponse<AuthCredentialsModel>> signIn(
      {required String phone, required String password}) async {
    await Future.delayed(const Duration(seconds: 5));
    if (phone == password) {
      return DataRemoteResponse(
        data: AuthCredentialsModel(jvtToken: 'dasdfasdfas'),
      );
    } else {
      return ErrorRemoteResponse(
        title: 'auth failed',
        detail: 'wrong arguments',
        errorList: [
          RestApiValidationErrorModel(
            fieldName: 'phone',
            errorList: [
              (code: 'phone is wrong', params: null),
            ],
          ),
          RestApiValidationErrorModel(
            fieldName: 'password',
            errorList: [
              (code: 'password is wrong', params: null),
            ],
          ),
        ],
      );
    }
  }

  @override
  Future<RemoteResponse<AuthCredentialsModel>> signUp(
      {required String phone, required String password}) async {
    await Future.delayed(const Duration(seconds: 5));
    if (phone == password) {
      return DataRemoteResponse(
        data: AuthCredentialsModel(jvtToken: 'dasdfasdfas'),
      );
    } else {
      return ErrorRemoteResponse(
        title: 'auth failed',
        detail: 'wrong arguments',
        errorList: [
          RestApiValidationErrorModel(
            fieldName: 'phone',
            errorList: [
              (code: 'someCode', params: null),
            ],
          ),
          RestApiValidationErrorModel(
            fieldName: 'password',
            errorList: [
              (code: 'someCode', params: null),
            ],
          ),
        ],
      );
    }
  }
}
