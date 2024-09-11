import 'package:equatable/equatable.dart';

import '../../../data/bus_arrival/entity/bus_arrival_info_entity.dart';

class BusArrivalInfoModel extends Equatable {
  const BusArrivalInfoModel({
    required this.id,
  });
  final String id;

  factory BusArrivalInfoModel.fromEntity({
    required BusArrivalInfoEntity entity,
  }) =>
      BusArrivalInfoModel(
        id: entity.response.body.items?.item.nodeId ?? '',
      );

  @override
  List<Object?> get props => <Object?>[
        id,
      ];
}
