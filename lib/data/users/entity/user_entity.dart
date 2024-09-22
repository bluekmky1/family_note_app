import 'package:json_annotation/json_annotation.dart';

part 'generated/user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  UserEntity({
    required this.contents,
  });

  final List<UserInfoEntity> contents;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}

@JsonSerializable()
class UserInfoEntity {
  UserInfoEntity({
    required this.id,
    required this.nickname,
  });
  final int id;
  final String nickname;

  factory UserInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$UserInfoEntityFromJson(json);
}
