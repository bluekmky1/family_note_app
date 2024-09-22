// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../sign_in_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInRequestBody _$SignInRequestBodyFromJson(Map<String, dynamic> json) =>
    SignInRequestBody(
      nickname: json['nickname'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignInRequestBodyToJson(SignInRequestBody instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'password': instance.password,
    };
