import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import 'body/create_question_request_body.dart';
import 'body/recruit_family_request_body.dart';
import 'entity/family_answers_entity.dart';
import 'entity/family_group_list_entity.dart';
import 'entity/family_questions_entity.dart';
import 'entity/fmaily_id_entity.dart';
import 'family_remote_data_source.dart';

final Provider<FamilyRepository> familyRepositoryProvider =
    Provider<FamilyRepository>(
  (ProviderRef<FamilyRepository> ref) =>
      FamilyRepository(ref.watch(familyRemoteDataSourceProvider)),
);

class FamilyRepository extends Repository {
  const FamilyRepository(this._familyRemoteDataSource);

  final FamilyRemoteDataSource _familyRemoteDataSource;

  // 가족 그룹 목록 조회
  Future<RepositoryResult<FamilyGroupListEntity>>
      getFamilyGroupListInfo() async {
    try {
      return SuccessRepositoryResult<FamilyGroupListEntity>(
        data: await _familyRemoteDataSource.getFamilyGroupListInfo(),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        _ => FailureRepositoryResult<FamilyGroupListEntity>(
            error: e,
            messages: <String>['가족 그룹 조회에 실패했습니다.'],
          ),
      };
    }
  }

  // 가족 그룹 구성원 조회
  Future<RepositoryResult<FamilyGroupEntity>> getFamilyInfo(
      {required int familyId}) async {
    try {
      return SuccessRepositoryResult<FamilyGroupEntity>(
        data: await _familyRemoteDataSource.getFamilyInfo(familyId: familyId),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        _ => FailureRepositoryResult<FamilyGroupEntity>(
            error: e,
            messages: <String>['가족 구성원 조회에 실패했습니다.'],
          ),
      };
    }
  }

  // 가족 그룹 모집
  Future<RepositoryResult<FamilyIdEntity>> recruitFamily({
    required List<int> userIds,
    required String familyName,
  }) async {
    try {
      return SuccessRepositoryResult<FamilyIdEntity>(
        data: await _familyRemoteDataSource.recruitFamily(
          body: RecruitFamilyRequestBody(
            userIds: userIds,
            familyName: familyName,
          ),
        ),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        404 => FailureRepositoryResult<FamilyIdEntity>(
            error: e,
            messages: <String>['가족 그룹에 찾을 수 없는 유저가 있습니다.'],
          ),
        _ => FailureRepositoryResult<FamilyIdEntity>(
            error: e,
            messages: <String>['가족 그룹 생성에 실패했습니다.'],
          ),
      };
    }
  }

// 가족 답변 조회
  Future<RepositoryResult<FamilyAnswersEntity>> getFamilyAnswers({
    required int familyQuestionId,
  }) async {
    try {
      return SuccessRepositoryResult<FamilyAnswersEntity>(
        data: await _familyRemoteDataSource.getFamilyAnswers(
            familyQuestionId: familyQuestionId),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        _ => FailureRepositoryResult<FamilyAnswersEntity>(
            error: e,
            messages: <String>['가족 답변 조회에 실패했습니다.'],
          ),
      };
    }
  }

// 가족 답변 생성
  Future<RepositoryResult<void>> postAnswer({
    required int familyQuestionId,
    required String answer,
  }) async {
    try {
      await _familyRemoteDataSource.postAnswer(
        familyQuestionId: familyQuestionId,
        body: PostAnswerRequestBody(content: answer),
      );
      return const SuccessRepositoryResult<void>(
        data: null,
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        _ => FailureRepositoryResult<void>(
            error: e,
            messages: <String>['답변 생성에 실패했습니다.'],
          ),
      };
    }
  }

// 가족 질문 조회
  Future<RepositoryResult<FamilyQuestionsEntity>> getFamilyQuestion({
    required int familyId,
    int? page,
    int? size,
  }) async {
    try {
      return SuccessRepositoryResult<FamilyQuestionsEntity>(
        data: await _familyRemoteDataSource.getFamilyQuestion(
          familyId: familyId,
          page: page ?? 0,
          size: size ?? 10,
        ),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        _ => FailureRepositoryResult<FamilyQuestionsEntity>(
            error: e,
            messages: <String>['가족 질문 조회에 실패했습니다.'],
          ),
      };
    }
  }

// 가족 질문 생성
  Future<RepositoryResult<void>> createFamilyQuestion({
    required int familyId,
  }) async {
    try {
      await _familyRemoteDataSource.createFamilyQuestion(
        familyId: familyId,
      );
      return const SuccessRepositoryResult<void>(data: null);
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        400 => FailureRepositoryResult<void>(
            error: e,
            messages: <String>['이전 가족 질문에 모두 답하지 않아 새로운 질문을 생성할 수 없습니다.'],
          ),
        _ => FailureRepositoryResult<void>(
            error: e,
            messages: <String>['알 수 없는 오류로 가족 질문 생성에 실패했습니다.'],
          ),
      };
    }
  }
}
