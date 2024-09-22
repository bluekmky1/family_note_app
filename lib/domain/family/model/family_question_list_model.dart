import 'package:equatable/equatable.dart';

import '../../../data/family/entity/family_questions_entity.dart';
import 'family_question_model.dart';
import 'pageable_model.dart';

class FamilyQuestionListModel extends Equatable {
  const FamilyQuestionListModel({
    required this.familyQusetionList,
    required this.pageable,
  });
  final List<FamilyQuestionModel> familyQusetionList;
  final PageableModel pageable;

  factory FamilyQuestionListModel.fromEntity({
    required FamilyQuestionsEntity entity,
  }) =>
      FamilyQuestionListModel(
        familyQusetionList: List<FamilyQuestionModel>.generate(
          entity.contents.length,
          (int index) => FamilyQuestionModel.fromEntity(
            entity: entity.contents[index],
          ),
        ),
        pageable: PageableModel.fromEntity(entity: entity.pageable),
      );

  @override
  List<Object?> get props => <Object?>[
        familyQusetionList,
        pageable,
      ];
}
