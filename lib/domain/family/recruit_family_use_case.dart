import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../data/family/entity/fmaily_id_entity.dart';
import '../../data/family/family_repository.dart';

final Provider<RecruitFamilyUseCase> recruitFamilyUseCaseProvider =
    Provider<RecruitFamilyUseCase>(
  (ProviderRef<RecruitFamilyUseCase> ref) => RecruitFamilyUseCase(
    familyRepository: ref.watch(familyRepositoryProvider),
  ),
);

class RecruitFamilyUseCase {
  const RecruitFamilyUseCase({
    required FamilyRepository familyRepository,
  }) : _familyRepository = familyRepository;

  final FamilyRepository _familyRepository;

  Future<UseCaseResult<int>> call({
    required List<int> userIds,
    required String familyName,
  }) async {
    final RepositoryResult<FamilyIdEntity> repositoryResult =
        await _familyRepository.recruitFamily(
            userIds: userIds, familyName: familyName);

    return switch (repositoryResult) {
      SuccessRepositoryResult<FamilyIdEntity>() =>
        SuccessUseCaseResult<int>(data: repositoryResult.data.familyId),
      FailureRepositoryResult<FamilyIdEntity>() => FailureUseCaseResult<int>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
