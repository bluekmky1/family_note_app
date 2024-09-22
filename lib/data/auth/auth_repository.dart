import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import 'auth_remote_data_source.dart';
import 'body/sign_in_request_body.dart';
import 'body/sign_up_request_body.dart';
import 'entity/auth_token_entity.dart';

final Provider<AuthRepository> authRepositoryProvider =
    Provider<AuthRepository>(
  (ProviderRef<AuthRepository> ref) => AuthRepository(
    authRemoteDataSource: ref.watch(authRemoteDataSourceProvider),
  ),
);

class AuthRepository extends Repository {
  final AuthRemoteDataSource _authRemoteDataSource;
  const AuthRepository({
    required AuthRemoteDataSource authRemoteDataSource,
  }) : _authRemoteDataSource = authRemoteDataSource;

  Future<RepositoryResult<AuthTokenEntity>> signIn({
    required String nickname,
    required String password,
  }) async {
    try {
      return SuccessRepositoryResult<AuthTokenEntity>(
        data: await _authRemoteDataSource.signIn(
            body: SignInRequestBody(
          nickname: nickname,
          password: password,
        )),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        404 => FailureRepositoryResult<AuthTokenEntity>(
            error: e,
            messages: <String>['닉네임을 확인해 주세요.'],
          ),
        400 => FailureRepositoryResult<AuthTokenEntity>(
            error: e,
            messages: <String>['비밀번호를 확인해 주세요.'],
          ),
        _ => FailureRepositoryResult<AuthTokenEntity>(
            error: e,
            messages: <String>['로그인 요청 실패'],
          ),
      };
    }
  }

  Future<RepositoryResult<void>> signUp({
    required String nickname,
    required String password,
  }) async {
    try {
      await _authRemoteDataSource.signUp(
        body: SignUpRequestBody(
          nickname: nickname,
          password: password,
        ),
      );
      return const SuccessRepositoryResult<void>(
        data: null,
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        409 => FailureRepositoryResult<void>(
            error: e,
            messages: <String>['중복된 닉네임입니다'],
          ),
        _ => FailureRepositoryResult<AuthTokenEntity>(
            error: e,
            messages: <String>['회원가입 요청 실패'],
          ),
      };
    }
  }
}
