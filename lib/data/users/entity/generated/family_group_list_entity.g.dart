// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../family_group_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyGroupListEntity _$FamilyGroupListEntityFromJson(
        Map<String, dynamic> json) =>
    FamilyGroupListEntity(
      contents: (json['contents'] as List<dynamic>)
          .map((e) => FamilyGroupsEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FamilyGroupListEntityToJson(
        FamilyGroupListEntity instance) =>
    <String, dynamic>{
      'contents': instance.contents,
    };

FamilyGroupsEntity _$FamilyGroupsEntityFromJson(Map<String, dynamic> json) =>
    FamilyGroupsEntity(
      familyId: (json['familyId'] as num).toInt(),
      familyName: json['familyName'] as String,
      myName: json['myName'] as String,
      familyMembers: (json['familyMembers'] as List<dynamic>)
          .map((e) => FaimlyMembers.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FamilyGroupsEntityToJson(FamilyGroupsEntity instance) =>
    <String, dynamic>{
      'familyId': instance.familyId,
      'familyName': instance.familyName,
      'myName': instance.myName,
      'familyMembers': instance.familyMembers,
    };

FaimlyMembers _$FaimlyMembersFromJson(Map<String, dynamic> json) =>
    FaimlyMembers(
      familyMemberId: (json['familyMemberId'] as num).toInt(),
      nickName: json['nickName'] as String,
    );

Map<String, dynamic> _$FaimlyMembersToJson(FaimlyMembers instance) =>
    <String, dynamic>{
      'familyMemberId': instance.familyMemberId,
      'nickName': instance.nickName,
    };
