// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'direction_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DirectionDetailsModel _$DirectionDetailsModelFromJson(
    Map<String, dynamic> json) {
  return _DirectionDetailsModel.fromJson(json);
}

/// @nodoc
mixin _$DirectionDetailsModel {
  String? get distanceText => throw _privateConstructorUsedError;
  String? get durationText => throw _privateConstructorUsedError;
  int? get distanceValue => throw _privateConstructorUsedError;
  int? get durationValue => throw _privateConstructorUsedError;
  String? get encodedPoints => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DirectionDetailsModelCopyWith<DirectionDetailsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectionDetailsModelCopyWith<$Res> {
  factory $DirectionDetailsModelCopyWith(DirectionDetailsModel value,
          $Res Function(DirectionDetailsModel) then) =
      _$DirectionDetailsModelCopyWithImpl<$Res, DirectionDetailsModel>;
  @useResult
  $Res call(
      {String? distanceText,
      String? durationText,
      int? distanceValue,
      int? durationValue,
      String? encodedPoints});
}

/// @nodoc
class _$DirectionDetailsModelCopyWithImpl<$Res,
        $Val extends DirectionDetailsModel>
    implements $DirectionDetailsModelCopyWith<$Res> {
  _$DirectionDetailsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distanceText = freezed,
    Object? durationText = freezed,
    Object? distanceValue = freezed,
    Object? durationValue = freezed,
    Object? encodedPoints = freezed,
  }) {
    return _then(_value.copyWith(
      distanceText: freezed == distanceText
          ? _value.distanceText
          : distanceText // ignore: cast_nullable_to_non_nullable
              as String?,
      durationText: freezed == durationText
          ? _value.durationText
          : durationText // ignore: cast_nullable_to_non_nullable
              as String?,
      distanceValue: freezed == distanceValue
          ? _value.distanceValue
          : distanceValue // ignore: cast_nullable_to_non_nullable
              as int?,
      durationValue: freezed == durationValue
          ? _value.durationValue
          : durationValue // ignore: cast_nullable_to_non_nullable
              as int?,
      encodedPoints: freezed == encodedPoints
          ? _value.encodedPoints
          : encodedPoints // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DirectionDetailsModelCopyWith<$Res>
    implements $DirectionDetailsModelCopyWith<$Res> {
  factory _$$_DirectionDetailsModelCopyWith(_$_DirectionDetailsModel value,
          $Res Function(_$_DirectionDetailsModel) then) =
      __$$_DirectionDetailsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? distanceText,
      String? durationText,
      int? distanceValue,
      int? durationValue,
      String? encodedPoints});
}

/// @nodoc
class __$$_DirectionDetailsModelCopyWithImpl<$Res>
    extends _$DirectionDetailsModelCopyWithImpl<$Res, _$_DirectionDetailsModel>
    implements _$$_DirectionDetailsModelCopyWith<$Res> {
  __$$_DirectionDetailsModelCopyWithImpl(_$_DirectionDetailsModel _value,
      $Res Function(_$_DirectionDetailsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distanceText = freezed,
    Object? durationText = freezed,
    Object? distanceValue = freezed,
    Object? durationValue = freezed,
    Object? encodedPoints = freezed,
  }) {
    return _then(_$_DirectionDetailsModel(
      distanceText: freezed == distanceText
          ? _value.distanceText
          : distanceText // ignore: cast_nullable_to_non_nullable
              as String?,
      durationText: freezed == durationText
          ? _value.durationText
          : durationText // ignore: cast_nullable_to_non_nullable
              as String?,
      distanceValue: freezed == distanceValue
          ? _value.distanceValue
          : distanceValue // ignore: cast_nullable_to_non_nullable
              as int?,
      durationValue: freezed == durationValue
          ? _value.durationValue
          : durationValue // ignore: cast_nullable_to_non_nullable
              as int?,
      encodedPoints: freezed == encodedPoints
          ? _value.encodedPoints
          : encodedPoints // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DirectionDetailsModel implements _DirectionDetailsModel {
  const _$_DirectionDetailsModel(
      {this.distanceText,
      this.durationText,
      this.distanceValue,
      this.durationValue,
      this.encodedPoints});

  factory _$_DirectionDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$$_DirectionDetailsModelFromJson(json);

  @override
  final String? distanceText;
  @override
  final String? durationText;
  @override
  final int? distanceValue;
  @override
  final int? durationValue;
  @override
  final String? encodedPoints;

  @override
  String toString() {
    return 'DirectionDetailsModel(distanceText: $distanceText, durationText: $durationText, distanceValue: $distanceValue, durationValue: $durationValue, encodedPoints: $encodedPoints)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DirectionDetailsModel &&
            (identical(other.distanceText, distanceText) ||
                other.distanceText == distanceText) &&
            (identical(other.durationText, durationText) ||
                other.durationText == durationText) &&
            (identical(other.distanceValue, distanceValue) ||
                other.distanceValue == distanceValue) &&
            (identical(other.durationValue, durationValue) ||
                other.durationValue == durationValue) &&
            (identical(other.encodedPoints, encodedPoints) ||
                other.encodedPoints == encodedPoints));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, distanceText, durationText,
      distanceValue, durationValue, encodedPoints);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DirectionDetailsModelCopyWith<_$_DirectionDetailsModel> get copyWith =>
      __$$_DirectionDetailsModelCopyWithImpl<_$_DirectionDetailsModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DirectionDetailsModelToJson(
      this,
    );
  }
}

abstract class _DirectionDetailsModel implements DirectionDetailsModel {
  const factory _DirectionDetailsModel(
      {final String? distanceText,
      final String? durationText,
      final int? distanceValue,
      final int? durationValue,
      final String? encodedPoints}) = _$_DirectionDetailsModel;

  factory _DirectionDetailsModel.fromJson(Map<String, dynamic> json) =
      _$_DirectionDetailsModel.fromJson;

  @override
  String? get distanceText;
  @override
  String? get durationText;
  @override
  int? get distanceValue;
  @override
  int? get durationValue;
  @override
  String? get encodedPoints;
  @override
  @JsonKey(ignore: true)
  _$$_DirectionDetailsModelCopyWith<_$_DirectionDetailsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
