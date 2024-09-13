import 'package:equatable/equatable.dart';
import '../../core/loading_status.dart';

class RecruitState extends Equatable {
  final LoadingStatus loadingStatus;
  final List<String> searchedFamilyList;
  final List<String> recruitedFamilyList;

  const RecruitState({
    required this.loadingStatus,
    required this.recruitedFamilyList,
    required this.searchedFamilyList,
  });

  RecruitState.init()
      : loadingStatus = LoadingStatus.none,
        recruitedFamilyList = <String>[],
        searchedFamilyList = <String>['sally', 'kim', 'sheeran', 'peter'];

  RecruitState copyWith({
    LoadingStatus? loadingStatus,
    List<String>? recruitedFamilyList,
    List<String>? searchedFamilyList,
  }) =>
      RecruitState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        recruitedFamilyList: recruitedFamilyList ?? this.recruitedFamilyList,
        searchedFamilyList: searchedFamilyList ?? this.searchedFamilyList,
      );

  @override
  List<Object?> get props => <Object?>[
        loadingStatus,
        recruitedFamilyList,
        searchedFamilyList,
      ];
}
