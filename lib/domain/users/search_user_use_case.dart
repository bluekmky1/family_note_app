import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../data/users/entity/user_entity.dart';
import '../../data/users/users_repository.dart';
import 'model/user_info_model.dart';

final Provider<SearchUserUseCase> searchUserUseCaseProvider =
    Provider<SearchUserUseCase>(
  (ProviderRef<SearchUserUseCase> ref) => SearchUserUseCase(
    usersRepository: ref.watch(usersRepositoryProvider),
  ),
);

class SearchUserUseCase {
  const SearchUserUseCase({
    required UsersRepository usersRepository,
  }) : _usersRepository = usersRepository;

  final UsersRepository _usersRepository;

  Future<UseCaseResult<List<UserInfoModel>>> call(
      {required String nickname}) async {
    final RepositoryResult<UserEntity> repositoryResult =
        await _usersRepository.getExpectedUsersInfo(
      nickname: nickname,
    );

    return switch (repositoryResult) {
      SuccessRepositoryResult<UserEntity>() =>
        SuccessUseCaseResult<List<UserInfoModel>>(
          data: List<UserInfoModel>.generate(
            repositoryResult.data.contents.length,
            (int index) => UserInfoModel.fromEntity(
              entity: repositoryResult.data.contents[index],
            ),
          ),
        ),
      FailureRepositoryResult<UserEntity>() =>
        FailureUseCaseResult<List<UserInfoModel>>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
