import 'package:equatable/equatable.dart';

import '../../../data/family/entity/family_group_list_entity.dart';

class FamilyGroupModel extends Equatable {
  const FamilyGroupModel({
    required this.familyId,
    required this.familyName,
    required this.myName,
    required this.familyMemberNameList,
  });
  final int familyId;
  final String familyName;
  final String myName;
  final List<String> familyMemberNameList;

  factory FamilyGroupModel.fromEntity({
    required FamilyGroupEntity entity,
  }) =>
      FamilyGroupModel(
        familyId: entity.familyId,
        familyName: entity.familyName,
        myName: entity.myName,
        familyMemberNameList: List<String>.generate(entity.familyMembers.length,
            (int index) => entity.familyMembers[index].nickName),
      );

  @override
  List<Object?> get props => <Object?>[
        familyId,
        familyName,
        myName,
        familyMemberNameList,
      ];
}
