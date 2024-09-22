import 'package:json_annotation/json_annotation.dart';

part 'generated/family_group_list_entity.g.dart';

@JsonSerializable()
class FamilyGroupListEntity {
  FamilyGroupListEntity({
    required this.contents,
  });
  final List<FamilyGroupEntity> contents;

  factory FamilyGroupListEntity.fromJson(Map<String, dynamic> json) =>
      _$FamilyGroupListEntityFromJson(json);
}

@JsonSerializable()
class FamilyGroupEntity {
  FamilyGroupEntity({
    required this.familyId,
    required this.familyName,
    required this.myName,
    required this.familyMembers,
  });
  final int familyId;
  final String familyName;
  final String myName;
  final List<FaimlyMembers> familyMembers;

  factory FamilyGroupEntity.fromJson(Map<String, dynamic> json) =>
      _$FamilyGroupEntityFromJson(json);
}

@JsonSerializable()
class FaimlyMembers {
  FaimlyMembers({
    required this.familyMemberId,
    required this.nickName,
  });
  final int familyMemberId;
  final String nickName;

  factory FaimlyMembers.fromJson(Map<String, dynamic> json) =>
      _$FaimlyMembersFromJson(json);
}
