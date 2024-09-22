import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/auth/auth_repository.dart';

final AutoDisposeProvider<SignUpUseCase> signUpUseCaseProvider =
    Provider.autoDispose<SignUpUseCase>(
  (AutoDisposeRef<SignUpUseCase> ref) => SignUpUseCase(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

class SignUpUseCase {
  final AuthRepository _authRepository;

  SignUpUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  Future<UseCaseResult<void>> call({
    required String nickname,
    required String password,
  }) async {
    final RepositoryResult<void> repositoryResult =
        await _authRepository.signUp(
      nickname: nickname,
      password: password,
    );

    return switch (repositoryResult) {
      SuccessRepositoryResult<void>() => const SuccessUseCaseResult<void>(
          data: null,
        ),
      FailureRepositoryResult<void>() => FailureUseCaseResult<void>(
          message: repositoryResult.messages?.first ?? '',
        )
    };
  }
}
