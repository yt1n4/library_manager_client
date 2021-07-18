// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
    identifier: json['identifier'] as String,
    name: json['name'] as String,
    permission: json['permission'] as int,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
      'identifier': instance.identifier,
      'name': instance.name,
      'permission': instance.permission,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
