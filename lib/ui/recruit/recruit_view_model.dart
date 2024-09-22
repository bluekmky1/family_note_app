import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../data/family/entity/fmaily_id_entity.dart';
import '../../domain/family/recruit_family_use_case.dart';
import '../../domain/users/model/user_info_model.dart';
import '../../domain/users/search_user_use_case.dart';
import 'recruit_state.dart';

final AutoDisposeStateNotifierProvider<RecruitViewModel, RecruitState>
    recruitViewModelProvider =
    StateNotifierProvider.autoDispose<RecruitViewModel, RecruitState>(
  (AutoDisposeStateNotifierProviderRef<RecruitViewModel, RecruitState> ref) =>
      RecruitViewModel(
    searchUserUseCase: ref.read(searchUserUseCaseProvider),
    recruitFamilyUseCase: ref.read(recruitFamilyUseCaseProvider),
  ),
);

class RecruitViewModel extends StateNotifier<RecruitState> {
  RecruitViewModel({
    required SearchUserUseCase searchUserUseCase,
    required RecruitFamilyUseCase recruitFamilyUseCase,
  })  : _searchUserUseCase = searchUserUseCase,
        _recruitFamilyUseCase = recruitFamilyUseCase,
        super(RecruitState.init());

  final SearchUserUseCase _searchUserUseCase;
  final RecruitFamilyUseCase _recruitFamilyUseCase;

  Future<void> searchUser({required String searchKeyword}) async {
    state = state.copyWith(
      saerchUserLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<List<UserInfoModel>> result = await _searchUserUseCase(
      nickname: searchKeyword,
    );

    switch (result) {
      case SuccessUseCaseResult<List<UserInfoModel>>():
        final List<UserInfoModel> searchResult = result.data
            .where(
              (UserInfoModel element) =>
                  !state.recruitedFamilyList.contains(element),
            )
            .toList();

        state = state.copyWith(
          saerchUserLoadingStatus: LoadingStatus.success,
          searchedFamilyList: searchResult,
        );

      case FailureUseCaseResult<List<UserInfoModel>>():
        state = state.copyWith(
          saerchUserLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> recruitFamily() async {
    state = state.copyWith(
      recruitFmailyLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<int> result = await _recruitFamilyUseCase(
      familyName: state.familyName,
      userIds: List<int>.generate(state.recruitedFamilyList.length,
          (int index) => state.recruitedFamilyList[index].id),
    );

    switch (result) {
      case SuccessUseCaseResult<int>():
        state = state.copyWith(
          recruitFmailyLoadingStatus: LoadingStatus.success,
          createdIFamilyId: result.data,
        );

      case FailureUseCaseResult<int>():
        state = state.copyWith(
          recruitFmailyLoadingStatus: LoadingStatus.error,
        );
    }
  }

  void clearSearchResult() {
    state = state.copyWith(searchedFamilyList: <UserInfoModel>[]);
  }

  void onchangeFamilyName({required String familyName}) {
    state = state.copyWith(familyName: familyName);
  }

  void selectFamily({required UserInfoModel nickName}) {
    final List<UserInfoModel> newRecruitedFamilyList = state.recruitedFamilyList
      ..add(nickName);
    final List<UserInfoModel> newSearchedFamily = state.searchedFamilyList
      ..remove(nickName);

    state = state.copyWith(
        searchedFamilyList: newSearchedFamily,
        recruitedFamilyList: newRecruitedFamilyList);
  }

  void unselectFamily({required UserInfoModel nickName}) {
    final List<UserInfoModel> newRecruitedFamilyList = state.recruitedFamilyList
      ..remove(nickName);
    final List<UserInfoModel> newSearchedFamily = state.searchedFamilyList
      ..add(nickName);

    state = state.copyWith(
      searchedFamilyList: newSearchedFamily,
      recruitedFamilyList: newRecruitedFamilyList,
    );
  }
}
