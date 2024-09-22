import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../data/family/entity/family_group_list_entity.dart';
import '../../data/family/family_repository.dart';
import 'model/family_group_model.dart';

final Provider<GetFamilyInfoUseCase> getFamilyInfoUseCaseProvider =
    Provider<GetFamilyInfoUseCase>(
  (ProviderRef<GetFamilyInfoUseCase> ref) => GetFamilyInfoUseCase(
    familyRepository: ref.watch(familyRepositoryProvider),
  ),
);

class GetFamilyInfoUseCase {
  const GetFamilyInfoUseCase({
    required FamilyRepository familyRepository,
  }) : _familyRepository = familyRepository;

  final FamilyRepository _familyRepository;

  Future<UseCaseResult<FamilyGroupModel>> call({
    required int familyId,
  }) async {
    final RepositoryResult<FamilyGroupEntity> repositoryResult =
        await _familyRepository.getFamilyInfo(familyId: familyId);

    return switch (repositoryResult) {
      SuccessRepositoryResult<FamilyGroupEntity>() =>
        SuccessUseCaseResult<FamilyGroupModel>(
          data: FamilyGroupModel.fromEntity(entity: repositoryResult.data),
        ),
      FailureRepositoryResult<FamilyGroupEntity>() =>
        FailureUseCaseResult<FamilyGroupModel>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
