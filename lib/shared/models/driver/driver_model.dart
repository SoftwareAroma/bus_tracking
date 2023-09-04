import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_model.freezed.dart';
part 'driver_model.g.dart';

@freezed
class DriverModel with _$DriverModel {
  const factory DriverModel({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    double? rating,
    String? bus,
  }) = _DriverModel;
  factory DriverModel.fromJson(Map<String, dynamic> json) => _$DriverModelFromJson(json);
}
