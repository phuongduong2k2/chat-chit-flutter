// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
  user: User.fromJson(json['user'] as Map<String, dynamic>),
  message: json['message'] as String,
  createdAt: json['createdAt'] as String,
);

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
  'user': instance.user,
  'message': instance.message,
  'createdAt': instance.createdAt,
};
