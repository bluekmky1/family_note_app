import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../data/family/family_repository.dart';

final Provider<CreateFamilyQuestionUseCase>
    createFamilyQuestionUseCaseProvider = Provider<CreateFamilyQuestionUseCase>(
  (ProviderRef<CreateFamilyQuestionUseCase> ref) => CreateFamilyQuestionUseCase(
    familyRepository: ref.watch(familyRepositoryProvider),
  ),
);

class CreateFamilyQuestionUseCase {
  const CreateFamilyQuestionUseCase({
    required FamilyRepository familyRepository,
  }) : _familyRepository = familyRepository;

  final FamilyRepository _familyRepository;

  Future<UseCaseResult<void>> call({
    required int familyId,
  }) async {
    final RepositoryResult<void> repositoryResult =
        await _familyRepository.createFamilyQuestion(familyId: familyId);

    return switch (repositoryResult) {
      SuccessRepositoryResult<void>() =>
        const SuccessUseCaseResult<void>(data: null),
      FailureRepositoryResult<void>() => FailureUseCaseResult<void>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
