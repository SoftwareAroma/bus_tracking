import 'package:freezed_annotation/freezed_annotation.dart';

part 'direction_details_model.freezed.dart';
part 'direction_details_model.g.dart';

@freezed
class DirectionDetailsModel with _$DirectionDetailsModel {
  const factory DirectionDetailsModel({
    String? distanceText,
    String? durationText,
    int? distanceValue,
    int? durationValue,
    String? encodedPoints,
  }) = _DirectionDetailsModel;
  factory DirectionDetailsModel.fromJson(Map<String, dynamic> json) => _$DirectionDetailsModelFromJson(json);
}
