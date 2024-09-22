import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../core/loading_status.dart';
import '../../domain/family/get_family_group_list_use_case.dart';
import '../../domain/family/model/family_group_model.dart';
import 'home_state.dart';

final AutoDisposeStateNotifierProvider<FamilyRoomsViewModel, FamilyRoomsState>
    familyRoomsViewModelProvider =
    StateNotifierProvider.autoDispose<FamilyRoomsViewModel, FamilyRoomsState>(
  (AutoDisposeStateNotifierProviderRef<FamilyRoomsViewModel, FamilyRoomsState>
          ref) =>
      FamilyRoomsViewModel(
    getFamilyGroupListUseCase: ref.read(getFamilyGroupListUseCaseProvider),
  ),
);

class FamilyRoomsViewModel extends StateNotifier<FamilyRoomsState> {
  FamilyRoomsViewModel({
    required GetFamilyGroupListUseCase getFamilyGroupListUseCase,
  })  : _getFamilyGroupListUseCase = getFamilyGroupListUseCase,
        super(FamilyRoomsState.init());

  final GetFamilyGroupListUseCase _getFamilyGroupListUseCase;

  Future<void> getFamilyGroupList() async {
    state = state.copyWith(
      getFamilyGroupLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<List<FamilyGroupModel>> result =
        await _getFamilyGroupListUseCase();

    switch (result) {
      case SuccessUseCaseResult<List<FamilyGroupModel>>():
        state = state.copyWith(
          getFamilyGroupLoadingStatus: LoadingStatus.success,
          familyGroupList: result.data,
        );

      case FailureUseCaseResult<List<FamilyGroupModel>>():
        state = state.copyWith(
          getFamilyGroupLoadingStatus: LoadingStatus.error,
        );
    }
  }
}
