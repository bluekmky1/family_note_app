import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import '../../service/network/dio_service.dart';
import 'entity/user_entity.dart';

part 'generated/users_remote_data_source.g.dart';

final Provider<UsersRemoteDataSource> usersRemoteDataSourceProvider =
    Provider<UsersRemoteDataSource>(
  (ProviderRef<UsersRemoteDataSource> ref) =>
      UsersRemoteDataSource(ref.read(dioServiceProvider)),
);

@RestApi()
abstract class UsersRemoteDataSource {
  factory UsersRemoteDataSource(Dio dio) = _UsersRemoteDataSource;

  // 유저 검색
  @GET('/users')
  Future<UserEntity> searchUser({
    @Query('nickname') required String nickname,
  });
}
