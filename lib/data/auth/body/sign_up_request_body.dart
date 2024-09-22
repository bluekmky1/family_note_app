import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/sign_up_request_body.g.dart';

@JsonSerializable()
class SignUpRequestBody extends Equatable {
  final String nickname;
  final String password;

  const SignUpRequestBody({
    required this.nickname,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$SignUpRequestBodyToJson(this);

  @override
  List<Object?> get props => <Object?>[
        nickname,
        password,
      ];
}
