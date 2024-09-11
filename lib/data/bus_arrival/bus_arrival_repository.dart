import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/common/repository/repository.dart';
import 'bus_arrival_remote_data_source.dart';

final Provider<BusArrivalRepository> busArrivalRepositoryProvider =
    Provider<BusArrivalRepository>(
  (ProviderRef<BusArrivalRepository> ref) =>
      BusArrivalRepository(ref.watch(busArrivalRemoteDataSourceProvider)),
);

class BusArrivalRepository extends Repository {
  const BusArrivalRepository(this._busArrivalRemoteDataSource);

  final BusArrivalRemoteDataSource _busArrivalRemoteDataSource;

  // // 정류소 별 특정 노선 버스 도착 예정 정보 목록 조회
  // Future<RepositoryResult<BusArrivalInfoEntity>> getExpectedBusArrivalInfo({
  //   required String nodeId,
  //   required String routeId,
  // }) async {
  //   try {
  //     return SuccessRepositoryResult<BusArrivalInfoEntity>(
  //       data: await _busArrivalRemoteDataSource.getExpectedBusArrivalInfo(
  //         serviceKey: Env.openDataPortalServiceKey,
  //         pageNumber: '1',
  //         numberOfRows: '10',
  //         dataType: 'json',
  //         cityCode: '31040',
  //         nodeId: nodeId,
  //         routeId: routeId,
  //       ),
  //     );
  //   } on DioException catch (e) {
  //     final int? statusCode = e.response?.statusCode;

  //     return switch (statusCode) {
  //       _ => FailureRepositoryResult<BusArrivalInfoEntity>(
  //           error: e,
  //           messages: <String>['1대1 문의 답변 작성에 실패했습니다.'],
  //         ),
  //     };
  //   }
  // }
}
