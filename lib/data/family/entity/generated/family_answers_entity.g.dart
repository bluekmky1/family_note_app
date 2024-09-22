// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../family_answers_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyAnswersEntity _$FamilyAnswersEntityFromJson(Map<String, dynamic> json) =>
    FamilyAnswersEntity(
      isAnswered: json['isAnswered'] as bool,
      contents: (json['contents'] as List<dynamic>)
          .map((e) => AnswerEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FamilyAnswersEntityToJson(
        FamilyAnswersEntity instance) =>
    <String, dynamic>{
      'isAnswered': instance.isAnswered,
      'contents': instance.contents,
    };

AnswerEntity _$AnswerEntityFromJson(Map<String, dynamic> json) => AnswerEntity(
      nickname: json['nickname'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$AnswerEntityToJson(AnswerEntity instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'content': instance.content,
    };
