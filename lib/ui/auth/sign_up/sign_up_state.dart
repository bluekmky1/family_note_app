import 'package:equatable/equatable.dart';

import '../../../core/loading_status.dart';

class SignUpState extends Equatable {
  final LoadingStatus signUpLoadingStatus;
  final String signUpErrorMsg;
  final String nickNameValue;
  final String nickNameValueError;
  final String passwordValue;
  final String passwordValueError;
  final String repeatPasswordValue;
  final String repeatPasswordValueError;

  const SignUpState({
    required this.signUpLoadingStatus,
    required this.signUpErrorMsg,
    required this.nickNameValue,
    required this.nickNameValueError,
    required this.passwordValue,
    required this.passwordValueError,
    required this.repeatPasswordValue,
    required this.repeatPasswordValueError,
  });

  const SignUpState.init()
      : signUpLoadingStatus = LoadingStatus.none,
        signUpErrorMsg = '',
        nickNameValue = '',
        nickNameValueError = '',
        passwordValue = '',
        passwordValueError = '',
        repeatPasswordValue = '',
        repeatPasswordValueError = '';

  SignUpState copyWith({
    LoadingStatus? signUpLoadingStatus,
    String? signUpErrorMsg,
    String? nickNameValue,
    String? nickNameValueError,
    String? passwordValue,
    String? passwordValueError,
    String? repeatPasswordValue,
    String? repeatPasswordValueError,
  }) =>
      SignUpState(
        signUpLoadingStatus: signUpLoadingStatus ?? this.signUpLoadingStatus,
        signUpErrorMsg: signUpErrorMsg ?? this.signUpErrorMsg,
        nickNameValue: nickNameValue ?? this.nickNameValue,
        nickNameValueError: nickNameValueError ?? this.nickNameValueError,
        passwordValue: passwordValue ?? this.passwordValue,
        passwordValueError: passwordValueError ?? this.passwordValueError,
        repeatPasswordValue: repeatPasswordValue ?? this.repeatPasswordValue,
        repeatPasswordValueError:
            repeatPasswordValueError ?? this.repeatPasswordValueError,
      );

  @override
  List<Object?> get props => <Object?>[
        signUpLoadingStatus,
        signUpErrorMsg,
        nickNameValue,
        nickNameValueError,
        passwordValue,
        passwordValueError,
        repeatPasswordValue,
        repeatPasswordValueError,
      ];

  bool get isFormInvalid =>
      nickNameValue.isEmpty ||
      passwordValue.isEmpty ||
      repeatPasswordValue.isEmpty;

  bool get isPasswordUnmatched => passwordValue != repeatPasswordValue;
}
