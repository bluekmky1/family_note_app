import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../data/family/entity/family_answers_entity.dart';
import '../../data/family/family_repository.dart';
import 'model/family_answer_list_model.dart';

final Provider<GetFamilyAnswersUseCase> getFamilyAnswersUseCaseProvider =
    Provider<GetFamilyAnswersUseCase>(
  (ProviderRef<GetFamilyAnswersUseCase> ref) => GetFamilyAnswersUseCase(
    familyRepository: ref.watch(familyRepositoryProvider),
  ),
);

class GetFamilyAnswersUseCase {
  const GetFamilyAnswersUseCase({
    required FamilyRepository familyRepository,
  }) : _familyRepository = familyRepository;

  final FamilyRepository _familyRepository;

  Future<UseCaseResult<FamilyAnswerListModel>> call({
    required int familyQuestionId,
  }) async {
    final RepositoryResult<FamilyAnswersEntity> repositoryResult =
        await _familyRepository.getFamilyAnswers(
      familyQuestionId: familyQuestionId,
    );

    return switch (repositoryResult) {
      SuccessRepositoryResult<FamilyAnswersEntity>() =>
        SuccessUseCaseResult<FamilyAnswerListModel>(
          data: FamilyAnswerListModel.fromEntity(entity: repositoryResult.data),
        ),
      FailureRepositoryResult<FamilyAnswersEntity>() =>
        FailureUseCaseResult<FamilyAnswerListModel>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
