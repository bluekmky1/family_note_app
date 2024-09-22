import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import '../../service/network/dio_service.dart';
import 'body/create_question_request_body.dart';
import 'body/recruit_family_request_body.dart';
import 'entity/family_answers_entity.dart';
import 'entity/family_group_list_entity.dart';
import 'entity/family_questions_entity.dart';
import 'entity/fmaily_id_entity.dart';

part 'generated/family_remote_data_source.g.dart';

final Provider<FamilyRemoteDataSource> familyRemoteDataSourceProvider =
    Provider<FamilyRemoteDataSource>(
  (ProviderRef<FamilyRemoteDataSource> ref) =>
      FamilyRemoteDataSource(ref.read(dioServiceProvider)),
);

@RestApi()
abstract class FamilyRemoteDataSource {
  factory FamilyRemoteDataSource(Dio dio) = _FamilyRemoteDataSource;

  // 가족 그룹 목록 조회
  @GET('/family/list')
  Future<FamilyGroupListEntity> getFamilyGroupListInfo();

  // 가족 그룹 조회
  @GET('/family/{familyId}')
  Future<FamilyGroupEntity> getFamilyInfo({
    @Path() required int familyId,
  });

  // 가족 구성원 모집
  @POST('/family/members')
  Future<FamilyIdEntity> recruitFamily({
    @Body() required RecruitFamilyRequestBody body,
  });

  // 가족 답변 조회
  @GET('/family/answer/{familyQuestionId}')
  Future<FamilyAnswersEntity> getFamilyAnswers({
    @Path() required int familyQuestionId,
  });

  // 가족 답변 생성
  @POST('family/answer/{familyQuestionId}')
  Future<void> postAnswer({
    @Path() required int familyQuestionId,
    @Body() required PostAnswerRequestBody body,
  });

  // 가족 질문 조회
  @GET('/family/question/{familyId}')
  Future<FamilyQuestionsEntity> getFamilyQuestion({
    @Path() required int familyId,
    @Query('page') required int page,
    @Query('size') required int size,
  });

  // 가족 질문 생성
  @POST('/family/question/{familyId}')
  Future<void> createFamilyQuestion({
    @Path() required int familyId,
  });
}
