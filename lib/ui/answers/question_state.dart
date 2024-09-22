import 'package:equatable/equatable.dart';

import '../../../core/loading_status.dart';
import '../../domain/family/model/family_answer_model.dart';

class QuestionState extends Equatable {
  final LoadingStatus getFamilyInfoLoadingStatus;
  final String myName;
  final String familyName;
  final List<String> familyNicknameList;

  final LoadingStatus getFamilyAnswerLoadingStatus;
  final List<FamilyAnswerModel> familyAnswerList;
  final bool isAnswered;

  final LoadingStatus postAnswerLoadingStatus;
  final String answerValue;

  const QuestionState({
    required this.getFamilyInfoLoadingStatus,
    required this.myName,
    required this.familyName,
    required this.familyNicknameList,
    required this.getFamilyAnswerLoadingStatus,
    required this.familyAnswerList,
    required this.isAnswered,
    required this.postAnswerLoadingStatus,
    required this.answerValue,
  });

  QuestionState.init()
      : getFamilyInfoLoadingStatus = LoadingStatus.none,
        myName = '',
        familyName = '',
        familyNicknameList = <String>[],
        getFamilyAnswerLoadingStatus = LoadingStatus.none,
        familyAnswerList = <FamilyAnswerModel>[],
        isAnswered = false,
        postAnswerLoadingStatus = LoadingStatus.none,
        answerValue = '';

  QuestionState copyWith({
    LoadingStatus? getFamilyAnswerLoadingStatus,
    List<FamilyAnswerModel>? familyAnswerList,
    bool? isAnswered,
    LoadingStatus? getFamilyInfoLoadingStatus,
    String? myName,
    String? familyName,
    List<String>? familyNicknameList,
    LoadingStatus? postAnswerLoadingStatus,
    String? answerValue,
  }) =>
      QuestionState(
        getFamilyAnswerLoadingStatus:
            getFamilyAnswerLoadingStatus ?? this.getFamilyAnswerLoadingStatus,
        familyAnswerList: familyAnswerList ?? this.familyAnswerList,
        isAnswered: isAnswered ?? this.isAnswered,
        getFamilyInfoLoadingStatus:
            getFamilyInfoLoadingStatus ?? this.getFamilyInfoLoadingStatus,
        myName: myName ?? this.myName,
        familyName: familyName ?? this.familyName,
        familyNicknameList: familyNicknameList ?? this.familyNicknameList,
        postAnswerLoadingStatus:
            postAnswerLoadingStatus ?? this.postAnswerLoadingStatus,
        answerValue: answerValue ?? this.answerValue,
      );

  @override
  List<Object?> get props => <Object?>[
        getFamilyAnswerLoadingStatus,
        familyAnswerList,
        isAnswered,
        getFamilyInfoLoadingStatus,
        myName,
        familyName,
        familyNicknameList,
        postAnswerLoadingStatus,
        answerValue,
      ];

  bool get isLoading =>
      getFamilyAnswerLoadingStatus == LoadingStatus.loading &&
      getFamilyInfoLoadingStatus == LoadingStatus.loading;
}
