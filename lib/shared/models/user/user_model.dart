import 'package:bus_tracking/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    int? id,
    String? firstName,
    String? lastName,
    String? password,
    String? otherName,
    String? email,
    String? avatar,
    String? phone,
    String? department,
    String? faculty,
    String? college,
    String? level,
    String? programme,
    String? referenceNumber,
    List<EventModel>? events,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
