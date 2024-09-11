// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../bus_arrival_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusArrivalInfoEntity _$BusArrivalInfoEntityFromJson(
        Map<String, dynamic> json) =>
    BusArrivalInfoEntity(
      response:
          BusArrivalResponse.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BusArrivalInfoEntityToJson(
        BusArrivalInfoEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };

BusArrivalResponse _$BusArrivalResponseFromJson(Map<String, dynamic> json) =>
    BusArrivalResponse(
      header: BusArrivalResponseHeader.fromJson(
          json['header'] as Map<String, dynamic>),
      body: BusArrivalBody.fromJson(json['body'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BusArrivalResponseToJson(BusArrivalResponse instance) =>
    <String, dynamic>{
      'header': instance.header,
      'body': instance.body,
    };

BusArrivalResponseHeader _$BusArrivalResponseHeaderFromJson(
        Map<String, dynamic> json) =>
    BusArrivalResponseHeader(
      resultCode: json['resultCode'] as String,
      resultMsg: json['resultMsg'] as String,
    );

Map<String, dynamic> _$BusArrivalResponseHeaderToJson(
        BusArrivalResponseHeader instance) =>
    <String, dynamic>{
      'resultCode': instance.resultCode,
      'resultMsg': instance.resultMsg,
    };

BusArrivalBody _$BusArrivalBodyFromJson(Map<String, dynamic> json) =>
    BusArrivalBody(
      items: json['items'] == null
          ? null
          : BusArrivalBodyItems.fromJson(json['items'] as Map<String, dynamic>),
      numOfRows: (json['numOfRows'] as num).toInt(),
      pageNo: (json['pageNo'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
    );

Map<String, dynamic> _$BusArrivalBodyToJson(BusArrivalBody instance) =>
    <String, dynamic>{
      'items': instance.items,
      'numOfRows': instance.numOfRows,
      'pageNo': instance.pageNo,
      'totalCount': instance.totalCount,
    };

BusArrivalBodyItems _$BusArrivalBodyItemsFromJson(Map<String, dynamic> json) =>
    BusArrivalBodyItems(
      item: BusArrivalBodyItem.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BusArrivalBodyItemsToJson(
        BusArrivalBodyItems instance) =>
    <String, dynamic>{
      'item': instance.item,
    };

BusArrivalBodyItem _$BusArrivalBodyItemFromJson(Map<String, dynamic> json) =>
    BusArrivalBodyItem(
      arrivalPrevStationCount: (json['arrprevstationcnt'] as num).toInt(),
      arrivalTime: (json['arrtime'] as num).toInt(),
      nodeId: json['nodeid'] as String,
      nodeName: json['nodenm'] as String,
      routeId: json['routeid'] as String,
      routeNumber: (json['routeno'] as num).toInt(),
      routeType: json['routetp'] as String,
    );

Map<String, dynamic> _$BusArrivalBodyItemToJson(BusArrivalBodyItem instance) =>
    <String, dynamic>{
      'arrprevstationcnt': instance.arrivalPrevStationCount,
      'arrtime': instance.arrivalTime,
      'nodeid': instance.nodeId,
      'nodenm': instance.nodeName,
      'routeid': instance.routeId,
      'routeno': instance.routeNumber,
      'routetp': instance.routeType,
    };
