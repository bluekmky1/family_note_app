import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../core/loading_status.dart';
import '../../../data/auth/entity/auth_token_entity.dart';
import '../../../domain/auth/use_case/sign_in_use_case.dart';
import '../../../service/app/app_service.dart';
import 'sign_in_state.dart';

final AutoDisposeStateNotifierProvider<SignInViewModel, SignInState>
    signInViewModelProvider =
    StateNotifierProvider.autoDispose<SignInViewModel, SignInState>(
  (AutoDisposeStateNotifierProviderRef<SignInViewModel, SignInState> ref) =>
      SignInViewModel(
    signInUseCase: ref.read(signInUseCaseProvider),
    appSercive: ref.read(appServiceProvider.notifier),
  ),
);

class SignInViewModel extends StateNotifier<SignInState> {
  SignInViewModel({
    required SignInUseCase signInUseCase,
    required AppService appSercive,
  })  : _signInUseCase = signInUseCase,
        _appService = appSercive,
        super(const SignInState.init());

  final SignInUseCase _signInUseCase;
  final AppService _appService;

  void onChangeNickname({required String nickName}) {
    state = state.copyWith(nickNameValue: nickName);
  }

  void onChangePassword({required String password}) {
    state = state.copyWith(passwordValue: password);
  }

  Future<void> signIn() async {
    state = state.copyWith(
      signInLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<AuthTokenEntity> result = await _signInUseCase(
      nickname: state.nickNameValue,
      password: state.passwordValue,
    );

    switch (result) {
      case SuccessUseCaseResult<AuthTokenEntity>():
        if (mounted) {
          state = state.copyWith(
            signInLoadingStatus: LoadingStatus.success,
          );
        }
        await _appService.signIn(authTokens: result.data);
      case FailureUseCaseResult<AuthTokenEntity>():
        state = state.copyWith(
          signInLoadingStatus: LoadingStatus.error,
          signInErrorMsg: result.message,
        );
    }
  }
}
