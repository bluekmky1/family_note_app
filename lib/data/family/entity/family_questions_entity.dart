import 'package:json_annotation/json_annotation.dart';

part 'generated/family_questions_entity.g.dart';

@JsonSerializable()
class FamilyQuestionsEntity {
  FamilyQuestionsEntity({
    required this.contents,
    required this.pageable,
  });
  final List<QuestionEntity> contents;
  final PageableEntity pageable;

  factory FamilyQuestionsEntity.fromJson(Map<String, dynamic> json) =>
      _$FamilyQuestionsEntityFromJson(json);
}

@JsonSerializable()
class QuestionEntity {
  QuestionEntity({
    required this.familyQuestionId,
    required this.content,
    required this.createdAt,
  });
  final int familyQuestionId;
  final String content;
  final DateTime createdAt;

  factory QuestionEntity.fromJson(Map<String, dynamic> json) =>
      _$QuestionEntityFromJson(json);
}

@JsonSerializable()
class PageableEntity {
  PageableEntity({
    required this.page,
    required this.size,
    required this.totalPages,
    required this.totalElements,
    required this.isEnd,
  });
  final int page;
  final int size;
  final int totalPages;
  final int totalElements;
  final bool isEnd;

  factory PageableEntity.fromJson(Map<String, dynamic> json) =>
      _$PageableEntityFromJson(json);
}
