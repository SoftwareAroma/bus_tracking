// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BusModel _$$_BusModelFromJson(Map<String, dynamic> json) => _$_BusModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      price: json['price'] as String?,
      rating: json['rating'] as String?,
      duration: json['duration'] as String?,
      drivers: (json['drivers'] as List<dynamic>?)
          ?.map((e) => DriverModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      source: json['source'] == null
          ? null
          : LocationModel.fromJson(json['source'] as Map<String, dynamic>),
      destinations: (json['destinations'] as List<dynamic>?)
          ?.map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      departureTime: (json['departureTime'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      arrivalTime: (json['arrivalTime'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      busType: json['busType'] as String?,
    );

Map<String, dynamic> _$$_BusModelToJson(_$_BusModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'rating': instance.rating,
      'duration': instance.duration,
      'drivers': instance.drivers,
      'source': instance.source,
      'destinations': instance.destinations,
      'departureTime':
          instance.departureTime?.map((e) => e.toIso8601String()).toList(),
      'arrivalTime':
          instance.arrivalTime?.map((e) => e.toIso8601String()).toList(),
      'busType': instance.busType,
    };
