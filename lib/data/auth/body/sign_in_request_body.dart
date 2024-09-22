import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/sign_in_request_body.g.dart';

@JsonSerializable()
class SignInRequestBody extends Equatable {
  final String nickname;
  final String password;

  const SignInRequestBody({
    required this.nickname,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$SignInRequestBodyToJson(this);

  @override
  List<Object?> get props => <Object?>[
        nickname,
        password,
      ];
}
