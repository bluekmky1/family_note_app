import 'package:equatable/equatable.dart';
import '../../core/loading_status.dart';
import '../../domain/users/model/user_info_model.dart';

class RecruitState extends Equatable {
  final LoadingStatus saerchUserLoadingStatus;
  final LoadingStatus recruitFmailyLoadingStatus;
  final List<UserInfoModel> searchedFamilyList;
  final List<UserInfoModel> recruitedFamilyList;
  final String familyName;
  final int createdIFamilyId;

  const RecruitState({
    required this.saerchUserLoadingStatus,
    required this.recruitFmailyLoadingStatus,
    required this.recruitedFamilyList,
    required this.searchedFamilyList,
    required this.familyName,
    required this.createdIFamilyId,
  });

  RecruitState.init()
      : saerchUserLoadingStatus = LoadingStatus.none,
        recruitFmailyLoadingStatus = LoadingStatus.none,
        recruitedFamilyList = <UserInfoModel>[],
        searchedFamilyList = <UserInfoModel>[],
        familyName = '',
        createdIFamilyId = -99;

  RecruitState copyWith({
    LoadingStatus? saerchUserLoadingStatus,
    LoadingStatus? recruitFmailyLoadingStatus,
    List<UserInfoModel>? recruitedFamilyList,
    List<UserInfoModel>? searchedFamilyList,
    String? familyName,
    int? createdIFamilyId,
  }) =>
      RecruitState(
        saerchUserLoadingStatus:
            saerchUserLoadingStatus ?? this.saerchUserLoadingStatus,
        recruitFmailyLoadingStatus:
            recruitFmailyLoadingStatus ?? this.recruitFmailyLoadingStatus,
        recruitedFamilyList: recruitedFamilyList ?? this.recruitedFamilyList,
        searchedFamilyList: searchedFamilyList ?? this.searchedFamilyList,
        familyName: familyName ?? this.familyName,
        createdIFamilyId: createdIFamilyId ?? this.createdIFamilyId,
      );

  @override
  List<Object?> get props => <Object?>[
        saerchUserLoadingStatus,
        recruitFmailyLoadingStatus,
        recruitedFamilyList,
        searchedFamilyList,
        familyName,
        createdIFamilyId,
      ];
}
