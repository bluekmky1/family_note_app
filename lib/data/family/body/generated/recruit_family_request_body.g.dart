// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../recruit_family_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecruitFamilyRequestBody _$RecruitFamilyRequestBodyFromJson(
        Map<String, dynamic> json) =>
    RecruitFamilyRequestBody(
      userIds: (json['userIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      familyName: json['familyName'] as String,
    );

Map<String, dynamic> _$RecruitFamilyRequestBodyToJson(
        RecruitFamilyRequestBody instance) =>
    <String, dynamic>{
      'userIds': instance.userIds,
      'familyName': instance.familyName,
    };
