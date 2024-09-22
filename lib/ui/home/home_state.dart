import 'package:equatable/equatable.dart';

import '../../../core/loading_status.dart';
import '../../domain/family/model/family_question_model.dart';

class HomeState extends Equatable {
  final LoadingStatus getFamilyInfoLoadingStatus;
  final String familyName;
  final List<String> familyNicknameList;

  final LoadingStatus initFamilyQuestionsLoading;
  final LoadingStatus getFamilyQuestionsLoadingStatus;
  final LoadingStatus createNewQuestionLoadingStatus;
  final String createNewQuestionError;
  final int totalCount;
  final int loadedPage;
  final bool isEndPage;
  final List<FamilyQuestionModel> questionList;

  const HomeState({
    required this.getFamilyInfoLoadingStatus,
    required this.familyName,
    required this.familyNicknameList,
    required this.initFamilyQuestionsLoading,
    required this.getFamilyQuestionsLoadingStatus,
    required this.createNewQuestionLoadingStatus,
    required this.createNewQuestionError,
    required this.totalCount,
    required this.loadedPage,
    required this.isEndPage,
    required this.questionList,
  });

  HomeState.init()
      : getFamilyInfoLoadingStatus = LoadingStatus.none,
        familyName = '',
        familyNicknameList = <String>[],
        initFamilyQuestionsLoading = LoadingStatus.none,
        getFamilyQuestionsLoadingStatus = LoadingStatus.none,
        createNewQuestionLoadingStatus = LoadingStatus.none,
        createNewQuestionError = '',
        totalCount = 0,
        loadedPage = 0,
        isEndPage = false,
        questionList = <FamilyQuestionModel>[];

  HomeState copyWith({
    LoadingStatus? getFamilyInfoLoadingStatus,
    String? familyName,
    List<String>? familyNicknameList,
    LoadingStatus? initFamilyQuestionsLoading,
    LoadingStatus? getFamilyQuestionsLoadingStatus,
    LoadingStatus? createNewQuestionLoadingStatus,
    String? createNewQuestionError,
    int? totalCount,
    int? loadedPage,
    bool? isEndPage,
    List<FamilyQuestionModel>? questionList,
  }) =>
      HomeState(
        getFamilyInfoLoadingStatus:
            getFamilyInfoLoadingStatus ?? this.getFamilyInfoLoadingStatus,
        familyName: familyName ?? this.familyName,
        familyNicknameList: familyNicknameList ?? this.familyNicknameList,
        initFamilyQuestionsLoading:
            initFamilyQuestionsLoading ?? this.initFamilyQuestionsLoading,
        getFamilyQuestionsLoadingStatus: getFamilyQuestionsLoadingStatus ??
            this.getFamilyQuestionsLoadingStatus,
        createNewQuestionLoadingStatus: createNewQuestionLoadingStatus ??
            this.createNewQuestionLoadingStatus,
        createNewQuestionError:
            createNewQuestionError ?? this.createNewQuestionError,
        totalCount: totalCount ?? this.totalCount,
        loadedPage: loadedPage ?? this.loadedPage,
        isEndPage: isEndPage ?? this.isEndPage,
        questionList: questionList ?? this.questionList,
      );

  @override
  List<Object?> get props => <Object?>[
        getFamilyInfoLoadingStatus,
        familyName,
        familyNicknameList,
        initFamilyQuestionsLoading,
        getFamilyQuestionsLoadingStatus,
        createNewQuestionLoadingStatus,
        createNewQuestionError,
        totalCount,
        loadedPage,
        isEndPage,
        questionList,
      ];

  bool get isLoading =>
      getFamilyQuestionsLoadingStatus == LoadingStatus.loading;

  bool get isInitLoading =>
      initFamilyQuestionsLoading == LoadingStatus.loading ||
      initFamilyQuestionsLoading == LoadingStatus.none;
}
