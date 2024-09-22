import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../data/family/family_repository.dart';

final Provider<PostAnswerUseCase> postAnswerUseCaseProvider =
    Provider<PostAnswerUseCase>(
  (ProviderRef<PostAnswerUseCase> ref) => PostAnswerUseCase(
    familyRepository: ref.watch(familyRepositoryProvider),
  ),
);

class PostAnswerUseCase {
  const PostAnswerUseCase({
    required FamilyRepository familyRepository,
  }) : _familyRepository = familyRepository;

  final FamilyRepository _familyRepository;

  Future<UseCaseResult<void>> call({
    required int familyQuestionId,
    required String answer,
  }) async {
    final RepositoryResult<void> repositoryResult =
        await _familyRepository.postAnswer(
      familyQuestionId: familyQuestionId,
      answer: answer,
    );

    return switch (repositoryResult) {
      SuccessRepositoryResult<void>() =>
        const SuccessUseCaseResult<void>(data: null),
      FailureRepositoryResult<void>() => FailureUseCaseResult<void>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
