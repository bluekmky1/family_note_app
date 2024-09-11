import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';

// final Provider<GetTransitBusByBusStopIdUseCase>
//     getTransitBusByBusStopIdUseCaseProvider =
//     Provider<GetTransitBusByBusStopIdUseCase>(
//   (ProviderRef<GetTransitBusByBusStopIdUseCase> ref) =>
//       GetTransitBusByBusStopIdUseCase(
//     busStopRepository: ref.watch(busStopRepositoryProvider),
//   ),
// );

// class GetTransitBusByBusStopIdUseCase {
//   const GetTransitBusByBusStopIdUseCase({
//     required busStopRepository,
//   }) : _busStopRepository = busStopRepository;

//   final BusStopRepository _busStopRepository;

//   Future<UseCaseResult<List<BusModel>>> call({
//     required String nodeId,
//     required String cityCode,
//   }) async {
//     final RepositoryResult<BusEntity> repositoryResult =
//         await _busStopRepository.getTransitBusByBusStopId(
//       cityCode: cityCode,
//       nodeId: nodeId,
//     );

//     return switch (repositoryResult) {
//       SuccessRepositoryResult<BusEntity>() =>
//         SuccessUseCaseResult<List<BusModel>>(
//           data: List<BusModel>.generate(
//             repositoryResult.data.response.body.items.item.length,
//             (int index) => BusModel.fromEntity(
//               busItem: repositoryResult.data.response.body.items.item[index],
//             ),
//           ),
//         ),
//       FailureRepositoryResult<BusEntity>() =>
//         FailureUseCaseResult<List<BusModel>>(
//           message: repositoryResult.messages?[0],
//         )
//     };
//   }
// }
