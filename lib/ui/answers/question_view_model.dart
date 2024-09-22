import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../core/loading_status.dart';
import '../../domain/family/get_family_answers_use_case.dart';
import '../../domain/family/get_family_info_use_case.dart';
import '../../domain/family/model/family_answer_list_model.dart';
import '../../domain/family/model/family_group_model.dart';
import '../../domain/family/post_answer_use_case.dart';
import 'question_state.dart';

final AutoDisposeStateNotifierProvider<QuestionViewModel, QuestionState>
    questionViewModelProvider =
    StateNotifierProvider.autoDispose<QuestionViewModel, QuestionState>(
  (AutoDisposeStateNotifierProviderRef<QuestionViewModel, QuestionState> ref) =>
      QuestionViewModel(
    getFamilyAnswersUseCase: ref.read(getFamilyAnswersUseCaseProvider),
    getFamilyInfoUseCase: ref.read(getFamilyInfoUseCaseProvider),
    postAnswerUseCase: ref.read(postAnswerUseCaseProvider),
  ),
);

class QuestionViewModel extends StateNotifier<QuestionState> {
  QuestionViewModel({
    required GetFamilyAnswersUseCase getFamilyAnswersUseCase,
    required GetFamilyInfoUseCase getFamilyInfoUseCase,
    required PostAnswerUseCase postAnswerUseCase,
  })  : _getFamilyAnswersUseCase = getFamilyAnswersUseCase,
        _getFamilyInfoUseCase = getFamilyInfoUseCase,
        _postAnswerUseCase = postAnswerUseCase,
        super(QuestionState.init());

  final GetFamilyAnswersUseCase _getFamilyAnswersUseCase;
  final GetFamilyInfoUseCase _getFamilyInfoUseCase;
  final PostAnswerUseCase _postAnswerUseCase;

  Future<void> getFamilyAnswerList({required int familyQuestionId}) async {
    state = state.copyWith(
      getFamilyAnswerLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<FamilyAnswerListModel> result =
        await _getFamilyAnswersUseCase(familyQuestionId: familyQuestionId);

    switch (result) {
      case SuccessUseCaseResult<FamilyAnswerListModel>():
        state = state.copyWith(
          getFamilyAnswerLoadingStatus: LoadingStatus.success,
          familyAnswerList: result.data.answerList,
          isAnswered: result.data.isAnswered,
        );

      case FailureUseCaseResult<FamilyAnswerListModel>():
        state = state.copyWith(
          getFamilyAnswerLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> getFamilyInfo({required int familyId}) async {
    state = state.copyWith(
      getFamilyInfoLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<FamilyGroupModel> result =
        await _getFamilyInfoUseCase(familyId: familyId);

    switch (result) {
      case SuccessUseCaseResult<FamilyGroupModel>():
        final List<String> myNameFirstList = result.data.familyMemberNameList
          ..remove(result.data.myName);

        state = state.copyWith(
          getFamilyInfoLoadingStatus: LoadingStatus.success,
          familyNicknameList: myNameFirstList..insert(0, result.data.myName),
          myName: result.data.myName,
          familyName: result.data.familyName,
        );

      case FailureUseCaseResult<FamilyGroupModel>():
        state = state.copyWith(
          getFamilyInfoLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> postAnswer({required int familyQuestionId}) async {
    state = state.copyWith(
      postAnswerLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<void> result = await _postAnswerUseCase(
      familyQuestionId: familyQuestionId,
      answer: state.answerValue,
    );

    switch (result) {
      case SuccessUseCaseResult<void>():
        state = state.copyWith(
          postAnswerLoadingStatus: LoadingStatus.success,
        );

      case FailureUseCaseResult<void>():
        state = state.copyWith(
          postAnswerLoadingStatus: LoadingStatus.error,
        );
    }
  }

  void onchangeAnswerValue({required String answer}) {
    state = state.copyWith(answerValue: answer);
  }
}
