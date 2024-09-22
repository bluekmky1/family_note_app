import 'package:equatable/equatable.dart';

import '../../../data/family/entity/family_answers_entity.dart';
import 'family_answer_model.dart';

class FamilyAnswerListModel extends Equatable {
  const FamilyAnswerListModel({
    required this.isAnswered,
    required this.answerList,
  });
  final bool isAnswered;
  final List<FamilyAnswerModel> answerList;

  factory FamilyAnswerListModel.fromEntity({
    required FamilyAnswersEntity entity,
  }) =>
      FamilyAnswerListModel(
        isAnswered: entity.isAnswered,
        answerList: List<FamilyAnswerModel>.generate(
          entity.contents.length,
          (int index) => FamilyAnswerModel.fromEntity(
            entity: entity.contents[index],
          ),
        ),
      );

  @override
  List<Object?> get props => <Object?>[
        isAnswered,
        answerList,
      ];
}
