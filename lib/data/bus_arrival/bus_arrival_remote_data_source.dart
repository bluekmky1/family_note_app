import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import '../../service/network/dio_service.dart';
import 'entity/bus_arrival_info_entity.dart';

part 'generated/bus_arrival_remote_data_source.g.dart';

final Provider<BusArrivalRemoteDataSource> busArrivalRemoteDataSourceProvider =
    Provider<BusArrivalRemoteDataSource>(
  (ProviderRef<BusArrivalRemoteDataSource> ref) =>
      BusArrivalRemoteDataSource(ref.read(dioService)),
);

@RestApi()
abstract class BusArrivalRemoteDataSource {
  factory BusArrivalRemoteDataSource(Dio dio) = _BusArrivalRemoteDataSource;
  // 정류소 별 특정 노선 버스 도착 예정 정보 목록 조회
  @GET('/ArvlInfoInqireService/getSttnAcctoSpcifyRouteBusArvlPrearngeInfoList')
  Future<BusArrivalInfoEntity> getExpectedBusArrivalInfo({
    @Query('serviceKey') required String serviceKey,
    @Query('pageNo') required String pageNumber,
    @Query('numOfRows') required String numberOfRows,
    @Query('_type') required String dataType,
    @Query('cityCode') required String cityCode,
    @Query('nodeId') required String nodeId,
    @Query('routeId') required String routeId,
  });
}
