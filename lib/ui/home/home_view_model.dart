import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../core/loading_status.dart';
import '../../domain/family/create_family_question_use_case.dart';
import '../../domain/family/get_family_info_use_case.dart';
import '../../domain/family/get_family_question_use_case.dart';
import '../../domain/family/model/family_group_model.dart';
import '../../domain/family/model/family_question_list_model.dart';
import 'home_state.dart';

final AutoDisposeStateNotifierProvider<HomeViewModel, HomeState>
    homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>(
  (AutoDisposeStateNotifierProviderRef<HomeViewModel, HomeState> ref) =>
      HomeViewModel(
    getFamilyInfoUseCase: ref.read(getFamilyInfoUseCaseProvider),
    getFamilyQuestionUseCase: ref.read(getFamilyQuestionUseCaseProvider),
    createFamilyQuestionUseCase: ref.read(createFamilyQuestionUseCaseProvider),
  ),
);

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel({
    required GetFamilyInfoUseCase getFamilyInfoUseCase,
    required GetFamilyQuestionUseCase getFamilyQuestionUseCase,
    required CreateFamilyQuestionUseCase createFamilyQuestionUseCase,
  })  : _getFamilyInfoUseCase = getFamilyInfoUseCase,
        _getFamilyQuestionUseCase = getFamilyQuestionUseCase,
        _createFamilyQuestionUseCase = createFamilyQuestionUseCase,
        super(HomeState.init());

  final GetFamilyInfoUseCase _getFamilyInfoUseCase;
  final GetFamilyQuestionUseCase _getFamilyQuestionUseCase;
  final CreateFamilyQuestionUseCase _createFamilyQuestionUseCase;

  Future<void> getFamilyInfo({required int familyId}) async {
    state = state.copyWith(
      getFamilyInfoLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<FamilyGroupModel> result =
        await _getFamilyInfoUseCase(familyId: familyId);

    switch (result) {
      case SuccessUseCaseResult<FamilyGroupModel>():
        state = state.copyWith(
          getFamilyInfoLoadingStatus: LoadingStatus.success,
          familyNicknameList: result.data.familyMemberNameList,
          familyName: result.data.familyName,
        );

      case FailureUseCaseResult<FamilyGroupModel>():
        state = state.copyWith(
          getFamilyInfoLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> initFamilyQuestions({
    required int familyId,
  }) async {
    state = state.copyWith(
      initFamilyQuestionsLoading: LoadingStatus.loading,
    );

    final UseCaseResult<FamilyQuestionListModel> result =
        await _getFamilyQuestionUseCase(familyId: familyId);

    switch (result) {
      case SuccessUseCaseResult<FamilyQuestionListModel>():
        state = state.copyWith(
          initFamilyQuestionsLoading: LoadingStatus.success,
          questionList: result.data.familyQusetionList,
          totalCount: result.data.pageable.totlaElements,
          loadedPage: result.data.pageable.page,
          isEndPage: result.data.pageable.isEnd,
        );

      case FailureUseCaseResult<FamilyQuestionListModel>():
        state = state.copyWith(
          initFamilyQuestionsLoading: LoadingStatus.error,
        );
    }
  }

  Future<void> getNextFamilyQuestions({
    required int familyId,
    required int loadedPage,
  }) async {
    if (state.isEndPage) {
      return;
    }

    if (state.isLoading) {
      return;
    }
    state = state.copyWith(
      getFamilyQuestionsLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<FamilyQuestionListModel> result =
        await _getFamilyQuestionUseCase(
            familyId: familyId, page: loadedPage + 1);

    switch (result) {
      case SuccessUseCaseResult<FamilyQuestionListModel>():
        state = state.copyWith(
          getFamilyQuestionsLoadingStatus: LoadingStatus.success,
          questionList: state.questionList + result.data.familyQusetionList,
          totalCount: result.data.pageable.totlaElements,
          loadedPage: result.data.pageable.page,
          isEndPage: result.data.pageable.isEnd,
        );

      case FailureUseCaseResult<FamilyQuestionListModel>():
        state = state.copyWith(
          getFamilyQuestionsLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> createQuestion({required int familyId}) async {
    state = state.copyWith(
      createNewQuestionLoadingStatus: LoadingStatus.loading,
    );
    final UseCaseResult<void> result =
        await _createFamilyQuestionUseCase(familyId: familyId);

    switch (result) {
      case SuccessUseCaseResult<void>():
        state = state.copyWith(
          createNewQuestionLoadingStatus: LoadingStatus.success,
          isEndPage: false,
        );

      case FailureUseCaseResult<void>():
        state = state.copyWith(
          createNewQuestionLoadingStatus: LoadingStatus.error,
          createNewQuestionError: result.message,
        );
    }
  }
}
