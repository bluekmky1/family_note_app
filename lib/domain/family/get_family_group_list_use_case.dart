import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../data/family/entity/family_group_list_entity.dart';
import '../../data/family/family_repository.dart';
import 'model/family_group_model.dart';

final Provider<GetFamilyGroupListUseCase> getFamilyGroupListUseCaseProvider =
    Provider<GetFamilyGroupListUseCase>(
  (ProviderRef<GetFamilyGroupListUseCase> ref) => GetFamilyGroupListUseCase(
    familyRepository: ref.watch(familyRepositoryProvider),
  ),
);

class GetFamilyGroupListUseCase {
  const GetFamilyGroupListUseCase({
    required FamilyRepository familyRepository,
  }) : _familyRepository = familyRepository;

  final FamilyRepository _familyRepository;

  Future<UseCaseResult<List<FamilyGroupModel>>> call() async {
    final RepositoryResult<FamilyGroupListEntity> repositoryResult =
        await _familyRepository.getFamilyGroupListInfo();

    return switch (repositoryResult) {
      SuccessRepositoryResult<FamilyGroupListEntity>() =>
        SuccessUseCaseResult<List<FamilyGroupModel>>(
          data: List<FamilyGroupModel>.generate(
            repositoryResult.data.contents.length,
            (int index) => FamilyGroupModel.fromEntity(
              entity: repositoryResult.data.contents[index],
            ),
          ),
        ),
      FailureRepositoryResult<FamilyGroupListEntity>() =>
        FailureUseCaseResult<List<FamilyGroupModel>>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
