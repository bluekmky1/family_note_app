import 'package:json_annotation/json_annotation.dart';

part 'generated/bus_arrival_info_entity.g.dart';

@JsonSerializable()
class BusArrivalInfoEntity {
  BusArrivalInfoEntity({
    required this.response,
  });
  final BusArrivalResponse response;

  factory BusArrivalInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalInfoEntityFromJson(json);
}

@JsonSerializable()
class BusArrivalResponse {
  BusArrivalResponse({
    required this.header,
    required this.body,
  });
  final BusArrivalResponseHeader header;
  final BusArrivalBody body;

  factory BusArrivalResponse.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalResponseFromJson(json);
}

@JsonSerializable()
class BusArrivalResponseHeader {
  BusArrivalResponseHeader({required this.resultCode, required this.resultMsg});
  final String resultCode;
  final String resultMsg;

  factory BusArrivalResponseHeader.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalResponseHeaderFromJson(json);
}

@JsonSerializable()
class BusArrivalBody {
  BusArrivalBody({
    required this.items,
    required this.numOfRows,
    required this.pageNo,
    required this.totalCount,
  });

  final BusArrivalBodyItems? items;
  final int numOfRows;
  final int pageNo;
  final int totalCount;

  factory BusArrivalBody.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalBodyFromJson(json);
}

@JsonSerializable()
class BusArrivalBodyItems {
  BusArrivalBodyItems({
    required this.item,
  });
  final BusArrivalBodyItem item;

  factory BusArrivalBodyItems.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalBodyItemsFromJson(json);

  Map<String, dynamic> toJson() => _$BusArrivalBodyItemsToJson(this);
}

@JsonSerializable()
class BusArrivalBodyItem {
  BusArrivalBodyItem({
    required this.arrivalPrevStationCount,
    required this.arrivalTime,
    required this.nodeId,
    required this.nodeName,
    required this.routeId,
    required this.routeNumber,
    required this.routeType,
  });
  @JsonKey(name: 'arrprevstationcnt')
  final int arrivalPrevStationCount;
  @JsonKey(name: 'arrtime')
  final int arrivalTime;
  @JsonKey(name: 'nodeid')
  final String nodeId;
  @JsonKey(name: 'nodenm')
  final String nodeName;
  @JsonKey(name: 'routeid')
  final String routeId;
  @JsonKey(name: 'routeno')
  final int routeNumber;
  @JsonKey(name: 'routetp')
  final String routeType;

  factory BusArrivalBodyItem.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalBodyItemFromJson(json);
}
