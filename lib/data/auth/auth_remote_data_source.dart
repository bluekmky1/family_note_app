import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../service/network/dio_service.dart';
import 'body/sign_in_request_body.dart';
import 'body/sign_up_request_body.dart';
import 'entity/auth_token_entity.dart';

part 'generated/auth_remote_data_source.g.dart';

final Provider<AuthRemoteDataSource> authRemoteDataSourceProvider =
    Provider<AuthRemoteDataSource>(
  (ProviderRef<AuthRemoteDataSource> ref) =>
      AuthRemoteDataSource(ref.read(dioServiceProvider)),
);

@RestApi()
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio) = _AuthRemoteDataSource;

  @POST('/login')
  Future<AuthTokenEntity> signIn({
    @Body() required SignInRequestBody body,
  });

  @POST('/users/signup')
  Future<void> signUp({
    @Body() required SignUpRequestBody body,
  });
}
