// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../family_questions_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyQuestionsEntity _$FamilyQuestionsEntityFromJson(
        Map<String, dynamic> json) =>
    FamilyQuestionsEntity(
      contents: (json['contents'] as List<dynamic>)
          .map((e) => QuestionEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageable:
          PageableEntity.fromJson(json['pageable'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FamilyQuestionsEntityToJson(
        FamilyQuestionsEntity instance) =>
    <String, dynamic>{
      'contents': instance.contents,
      'pageable': instance.pageable,
    };

QuestionEntity _$QuestionEntityFromJson(Map<String, dynamic> json) =>
    QuestionEntity(
      familyQuestionId: (json['familyQuestionId'] as num).toInt(),
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$QuestionEntityToJson(QuestionEntity instance) =>
    <String, dynamic>{
      'familyQuestionId': instance.familyQuestionId,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
    };

PageableEntity _$PageableEntityFromJson(Map<String, dynamic> json) =>
    PageableEntity(
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      totalElements: (json['totalElements'] as num).toInt(),
      isEnd: json['isEnd'] as bool,
    );

Map<String, dynamic> _$PageableEntityToJson(PageableEntity instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'isEnd': instance.isEnd,
    };
