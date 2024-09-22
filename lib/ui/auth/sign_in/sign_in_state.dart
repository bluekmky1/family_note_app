import 'package:equatable/equatable.dart';

import '../../../core/loading_status.dart';

class SignInState extends Equatable {
  final LoadingStatus signInLoadingStatus;
  final String signInErrorMsg;
  final String nickNameValue;
  final String nickNameValueError;
  final String passwordValue;
  final String passwordValueError;

  const SignInState({
    required this.signInLoadingStatus,
    required this.signInErrorMsg,
    required this.nickNameValue,
    required this.nickNameValueError,
    required this.passwordValue,
    required this.passwordValueError,
  });

  const SignInState.init()
      : signInLoadingStatus = LoadingStatus.none,
        signInErrorMsg = '',
        nickNameValue = '',
        nickNameValueError = '',
        passwordValue = '',
        passwordValueError = '';

  SignInState copyWith({
    LoadingStatus? signInLoadingStatus,
    String? signInErrorMsg,
    String? nickNameValue,
    String? nickNameValueError,
    String? passwordValue,
    String? passwordValueError,
  }) =>
      SignInState(
        signInLoadingStatus: signInLoadingStatus ?? this.signInLoadingStatus,
        signInErrorMsg: signInErrorMsg ?? this.signInErrorMsg,
        nickNameValue: nickNameValue ?? this.nickNameValue,
        nickNameValueError: nickNameValueError ?? this.nickNameValueError,
        passwordValue: passwordValue ?? this.passwordValue,
        passwordValueError: passwordValueError ?? this.passwordValueError,
      );

  @override
  List<Object?> get props => <Object?>[
        signInLoadingStatus,
        signInErrorMsg,
        nickNameValue,
        nickNameValueError,
        passwordValue,
        passwordValueError,
      ];
}
