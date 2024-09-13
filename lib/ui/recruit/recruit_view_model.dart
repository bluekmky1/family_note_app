import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'recruit_state.dart';

final AutoDisposeStateNotifierProvider<RecruitViewModel, RecruitState>
    recruitViewModelProvider =
    StateNotifierProvider.autoDispose<RecruitViewModel, RecruitState>(
  (AutoDisposeStateNotifierProviderRef<RecruitViewModel, RecruitState> ref) =>
      RecruitViewModel(),
);

class RecruitViewModel extends StateNotifier<RecruitState> {
  RecruitViewModel() : super(RecruitState.init());

  void selectFamily({required String nickName}) {
    final List<String> newRecruitedFamilyList = state.recruitedFamilyList
      ..add(nickName);
    final List<String> newSearchedFamily = state.searchedFamilyList
      ..remove(nickName);

    print(newRecruitedFamilyList);
    print(newSearchedFamily);

    state = state.copyWith(
        searchedFamilyList: newSearchedFamily,
        recruitedFamilyList: newRecruitedFamilyList);
  }

  void unselectFamily({required String nickName}) {
    final List<String> newRecruitedFamilyList = state.recruitedFamilyList
      ..remove(nickName);
    final List<String> newSearchedFamily = state.searchedFamilyList
      ..add(nickName);

    print(newRecruitedFamilyList);
    print(newSearchedFamily);

    state = state.copyWith(
      searchedFamilyList: newSearchedFamily,
      recruitedFamilyList: newRecruitedFamilyList,
    );
  }
}
