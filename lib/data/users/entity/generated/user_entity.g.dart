// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      contents: (json['contents'] as List<dynamic>)
          .map((e) => UserInfoEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'contents': instance.contents,
    };

UserInfoEntity _$UserInfoEntityFromJson(Map<String, dynamic> json) =>
    UserInfoEntity(
      id: (json['id'] as num).toInt(),
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$UserInfoEntityToJson(UserInfoEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
    };
