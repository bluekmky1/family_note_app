import 'package:equatable/equatable.dart';

import '../../../data/family/entity/family_questions_entity.dart';

class FamilyQuestionModel extends Equatable {
  const FamilyQuestionModel({
    required this.familyQusetionId,
    required this.question,
    required this.createdAt,
  });
  final int familyQusetionId;
  final String question;
  final DateTime createdAt;

  factory FamilyQuestionModel.fromEntity({
    required QuestionEntity entity,
  }) =>
      FamilyQuestionModel(
          familyQusetionId: entity.familyQuestionId,
          question: entity.content,
          createdAt: entity.createdAt);

  @override
  List<Object?> get props => <Object?>[
        familyQusetionId,
        question,
        createdAt,
      ];
}
