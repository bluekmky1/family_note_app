import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../core/loading_status.dart';
import '../../../domain/auth/use_case/sign_up_use_case.dart';
import 'sign_up_state.dart';

final AutoDisposeStateNotifierProvider<SignUpViewModel, SignUpState>
    signUpViewModelProvider =
    StateNotifierProvider.autoDispose<SignUpViewModel, SignUpState>(
  (AutoDisposeStateNotifierProviderRef<SignUpViewModel, SignUpState> ref) =>
      SignUpViewModel(
    signUpUsecase: ref.read(signUpUseCaseProvider),
  ),
);

class SignUpViewModel extends StateNotifier<SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpViewModel({
    required SignUpUseCase signUpUsecase,
  })  : _signUpUseCase = signUpUsecase,
        super(const SignUpState.init());

  void onChangeNickname({required String nickName}) {
    state = state.copyWith(nickNameValue: nickName);
  }

  void onChangePassword({required String password}) {
    state = state.copyWith(passwordValue: password);
  }

  void onChangeRepeatPassword({required String repeatPassword}) {
    state = state.copyWith(repeatPasswordValue: repeatPassword);
  }

  Future<void> signUp() async {
    state = state.copyWith(
      signUpLoadingStatus: LoadingStatus.loading,
    );

    if (state.isFormInvalid) {
      state = state.copyWith(
        nickNameValueError: state.nickNameValue.isEmpty ? '닉네임을 입력해주세요' : '',
        passwordValueError: state.passwordValue.isEmpty ? '비밀번호를 입력해주세요' : '',
        repeatPasswordValueError:
            state.repeatPasswordValue.isEmpty ? '비밀번호를 한 번 더 입력해주세요' : '',
      );
      return;
    }
    state = state.copyWith(
      nickNameValueError: '',
      passwordValueError: '',
      repeatPasswordValueError: '',
    );

    if (state.isPasswordUnmatched) {
      state = state.copyWith(
        repeatPasswordValueError: '비밀번호를 확인해주세요',
      );
      return;
    }

    final UseCaseResult<void> result = await _signUpUseCase(
      nickname: state.nickNameValue,
      password: state.passwordValue,
    );

    switch (result) {
      case SuccessUseCaseResult<void>():
        state = state.copyWith(
          signUpLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<void>():
        if (result.message == '중복된 닉네임입니다') {
          state = state.copyWith(
            signUpLoadingStatus: LoadingStatus.error,
            nickNameValueError: result.message,
          );
        }
        state = state.copyWith(
          signUpLoadingStatus: LoadingStatus.error,
          signUpErrorMsg: result.message,
        );
    }
  }
}
