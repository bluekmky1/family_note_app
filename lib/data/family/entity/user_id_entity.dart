import 'package:json_annotation/json_annotation.dart';

part 'generated/user_id_entity.g.dart';

@JsonSerializable()
class UserIdEntity {
  UserIdEntity({
    required this.id,
  });
  final int id;

  factory UserIdEntity.fromJson(Map<String, dynamic> json) =>
      _$UserIdEntityFromJson(json);
}
