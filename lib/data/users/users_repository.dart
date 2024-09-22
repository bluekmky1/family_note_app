import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import 'entity/user_entity.dart';
import 'users_remote_data_source.dart';

final Provider<UsersRepository> usersRepositoryProvider =
    Provider<UsersRepository>(
  (ProviderRef<UsersRepository> ref) =>
      UsersRepository(ref.watch(usersRemoteDataSourceProvider)),
);

class UsersRepository extends Repository {
  const UsersRepository(this._usersRemoteDataSource);

  final UsersRemoteDataSource _usersRemoteDataSource;

  // 유저 검색
  Future<RepositoryResult<UserEntity>> getExpectedUsersInfo({
    required String nickname,
  }) async {
    try {
      return SuccessRepositoryResult<UserEntity>(
        data: await _usersRemoteDataSource.searchUser(
          nickname: nickname,
        ),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        _ => FailureRepositoryResult<UserEntity>(
            error: e,
            messages: <String>['유저 검색에 실패했습니다.'],
          ),
      };
    }
  }
}
