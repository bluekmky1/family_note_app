import 'package:json_annotation/json_annotation.dart';

part 'generated/family_answers_entity.g.dart';

@JsonSerializable()
class FamilyAnswersEntity {
  FamilyAnswersEntity({
    required this.isAnswered,
    required this.contents,
  });
  final bool isAnswered;
  final List<AnswerEntity> contents;

  factory FamilyAnswersEntity.fromJson(Map<String, dynamic> json) =>
      _$FamilyAnswersEntityFromJson(json);
}

@JsonSerializable()
class AnswerEntity {
  AnswerEntity({
    required this.nickname,
    required this.content,
  });
  final String nickname;
  final String content;

  factory AnswerEntity.fromJson(Map<String, dynamic> json) =>
      _$AnswerEntityFromJson(json);
}
