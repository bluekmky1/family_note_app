import 'package:json_annotation/json_annotation.dart';

part 'generated/fmaily_id_entity.g.dart';

@JsonSerializable()
class FamilyIdEntity {
  FamilyIdEntity({
    required this.familyId,
  });
  final int familyId;

  factory FamilyIdEntity.fromJson(Map<String, dynamic> json) =>
      _$FamilyIdEntityFromJson(json);
}
