import 'package:equatable/equatable.dart';

import '../../../core/loading_status.dart';
import '../../domain/family/model/family_group_model.dart';

class FamilyRoomsState extends Equatable {
  final LoadingStatus getFamilyGroupLoadingStatus;
  final List<FamilyGroupModel> familyGroupList;

  const FamilyRoomsState({
    required this.getFamilyGroupLoadingStatus,
    required this.familyGroupList,
  });

  FamilyRoomsState.init()
      : getFamilyGroupLoadingStatus = LoadingStatus.none,
        familyGroupList = <FamilyGroupModel>[];

  FamilyRoomsState copyWith({
    LoadingStatus? getFamilyGroupLoadingStatus,
    List<FamilyGroupModel>? familyGroupList,
  }) =>
      FamilyRoomsState(
        getFamilyGroupLoadingStatus:
            getFamilyGroupLoadingStatus ?? this.getFamilyGroupLoadingStatus,
        familyGroupList: familyGroupList ?? this.familyGroupList,
      );

  @override
  List<Object?> get props => <Object?>[
        getFamilyGroupLoadingStatus,
        familyGroupList,
      ];
}
