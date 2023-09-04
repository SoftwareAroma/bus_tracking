import 'package:bus_tracking/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_model.freezed.dart';
part 'bus_model.g.dart';

@freezed
class BusModel with _$BusModel {
  const factory BusModel({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    String? price,
    String? rating,
    String? duration,
    List<DriverModel>? drivers,
    LocationModel? source,
    List<LocationModel>? destinations,
    List<DateTime>? departureTime,
    List<DateTime>? arrivalTime,
    String? busType,
  }) = _BusModel;
  factory BusModel.fromJson(Map<String, dynamic> json) => _$BusModelFromJson(json);
}
