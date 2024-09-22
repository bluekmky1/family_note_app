import 'package:equatable/equatable.dart';

import '../../../data/family/entity/family_answers_entity.dart';

class FamilyAnswerModel extends Equatable {
  const FamilyAnswerModel({
    required this.nickname,
    required this.answer,
  });
  final String nickname;
  final String answer;

  factory FamilyAnswerModel.fromEntity({
    required AnswerEntity entity,
  }) =>
      FamilyAnswerModel(
        nickname: entity.nickname,
        answer: entity.content,
      );

  @override
  List<Object?> get props => <Object?>[
        nickname,
        answer,
      ];
}
