// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      id: json['id'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      password: json['password'] as String?,
      otherName: json['otherName'] as String?,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
      department: json['department'] as String?,
      faculty: json['faculty'] as String?,
      college: json['college'] as String?,
      level: json['level'] as String?,
      programme: json['programme'] as String?,
      referenceNumber: json['referenceNumber'] as String?,
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => EventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'password': instance.password,
      'otherName': instance.otherName,
      'email': instance.email,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'department': instance.department,
      'faculty': instance.faculty,
      'college': instance.college,
      'level': instance.level,
      'programme': instance.programme,
      'referenceNumber': instance.referenceNumber,
      'events': instance.events,
    };
