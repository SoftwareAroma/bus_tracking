// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direction_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DirectionDetailsModel _$$_DirectionDetailsModelFromJson(
        Map<String, dynamic> json) =>
    _$_DirectionDetailsModel(
      distanceText: json['distanceText'] as String?,
      durationText: json['durationText'] as String?,
      distanceValue: json['distanceValue'] as int?,
      durationValue: json['durationValue'] as int?,
      encodedPoints: json['encodedPoints'] as String?,
    );

Map<String, dynamic> _$$_DirectionDetailsModelToJson(
        _$_DirectionDetailsModel instance) =>
    <String, dynamic>{
      'distanceText': instance.distanceText,
      'durationText': instance.durationText,
      'distanceValue': instance.distanceValue,
      'durationValue': instance.durationValue,
      'encodedPoints': instance.encodedPoints,
    };
