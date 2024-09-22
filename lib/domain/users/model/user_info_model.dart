import 'package:equatable/equatable.dart';

import '../../../data/users/entity/user_entity.dart';

class UserInfoModel extends Equatable {
  const UserInfoModel({
    required this.id,
    required this.nickname,
  });
  final int id;
  final String nickname;

  factory UserInfoModel.fromEntity({
    required UserInfoEntity entity,
  }) =>
      UserInfoModel(
        id: entity.id,
        nickname: entity.nickname,
      );

  @override
  List<Object?> get props => <Object?>[
        id,
        nickname,
      ];
}
