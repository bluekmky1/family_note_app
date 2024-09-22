import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../data/family/entity/family_questions_entity.dart';
import '../../data/family/family_repository.dart';
import 'model/family_question_list_model.dart';

final Provider<GetFamilyQuestionUseCase> getFamilyQuestionUseCaseProvider =
    Provider<GetFamilyQuestionUseCase>(
  (ProviderRef<GetFamilyQuestionUseCase> ref) => GetFamilyQuestionUseCase(
    familyRepository: ref.watch(familyRepositoryProvider),
  ),
);

class GetFamilyQuestionUseCase {
  const GetFamilyQuestionUseCase({
    required FamilyRepository familyRepository,
  }) : _familyRepository = familyRepository;

  final FamilyRepository _familyRepository;

  Future<UseCaseResult<FamilyQuestionListModel>> call({
    required int familyId,
    int? size,
    int? page,
  }) async {
    final RepositoryResult<FamilyQuestionsEntity> repositoryResult =
        await _familyRepository.getFamilyQuestion(
      familyId: familyId,
      page: page,
      size: size,
    );

    return switch (repositoryResult) {
      SuccessRepositoryResult<FamilyQuestionsEntity>() =>
        SuccessUseCaseResult<FamilyQuestionListModel>(
          data:
              FamilyQuestionListModel.fromEntity(entity: repositoryResult.data),
        ),
      FailureRepositoryResult<FamilyQuestionsEntity>() =>
        FailureUseCaseResult<FamilyQuestionListModel>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
