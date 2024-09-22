import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/recruit_family_request_body.g.dart';

@JsonSerializable()
class RecruitFamilyRequestBody extends Equatable {
  final List<int> userIds;
  final String familyName;

  const RecruitFamilyRequestBody({
    required this.userIds,
    required this.familyName,
  });

  Map<String, dynamic> toJson() => _$RecruitFamilyRequestBodyToJson(this);

  @override
  List<Object?> get props => <Object?>[
        userIds,
        familyName,
      ];
}
