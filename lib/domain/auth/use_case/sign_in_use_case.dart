import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/auth/auth_repository.dart';
import '../../../data/auth/entity/auth_token_entity.dart';

final AutoDisposeProvider<SignInUseCase> signInUseCaseProvider =
    Provider.autoDispose<SignInUseCase>(
  (AutoDisposeRef<SignInUseCase> ref) => SignInUseCase(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

class SignInUseCase {
  final AuthRepository _authRepository;

  SignInUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  Future<UseCaseResult<AuthTokenEntity>> call({
    required String nickname,
    required String password,
  }) async {
    final RepositoryResult<AuthTokenEntity> repositoryResult =
        await _authRepository.signIn(
      nickname: nickname,
      password: password,
    );

    return switch (repositoryResult) {
      SuccessRepositoryResult<AuthTokenEntity>() =>
        SuccessUseCaseResult<AuthTokenEntity>(
          data: repositoryResult.data,
        ),
      FailureRepositoryResult<AuthTokenEntity>() =>
        FailureUseCaseResult<AuthTokenEntity>(
          message: repositoryResult.messages?.first ?? '',
        )
    };
  }
}
