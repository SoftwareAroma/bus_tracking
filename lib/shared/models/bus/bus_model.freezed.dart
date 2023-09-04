// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BusModel _$BusModelFromJson(Map<String, dynamic> json) {
  return _BusModel.fromJson(json);
}

/// @nodoc
mixin _$BusModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;
  String? get rating => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;
  List<DriverModel>? get drivers => throw _privateConstructorUsedError;
  LocationModel? get source => throw _privateConstructorUsedError;
  List<LocationModel>? get destinations => throw _privateConstructorUsedError;
  List<DateTime>? get departureTime => throw _privateConstructorUsedError;
  List<DateTime>? get arrivalTime => throw _privateConstructorUsedError;
  String? get busType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BusModelCopyWith<BusModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusModelCopyWith<$Res> {
  factory $BusModelCopyWith(BusModel value, $Res Function(BusModel) then) =
      _$BusModelCopyWithImpl<$Res, BusModel>;
  @useResult
  $Res call(
      {int? id,
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
      String? busType});

  $LocationModelCopyWith<$Res>? get source;
}

/// @nodoc
class _$BusModelCopyWithImpl<$Res, $Val extends BusModel>
    implements $BusModelCopyWith<$Res> {
  _$BusModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? price = freezed,
    Object? rating = freezed,
    Object? duration = freezed,
    Object? drivers = freezed,
    Object? source = freezed,
    Object? destinations = freezed,
    Object? departureTime = freezed,
    Object? arrivalTime = freezed,
    Object? busType = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      drivers: freezed == drivers
          ? _value.drivers
          : drivers // ignore: cast_nullable_to_non_nullable
              as List<DriverModel>?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as LocationModel?,
      destinations: freezed == destinations
          ? _value.destinations
          : destinations // ignore: cast_nullable_to_non_nullable
              as List<LocationModel>?,
      departureTime: freezed == departureTime
          ? _value.departureTime
          : departureTime // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
      arrivalTime: freezed == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
      busType: freezed == busType
          ? _value.busType
          : busType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationModelCopyWith<$Res>? get source {
    if (_value.source == null) {
      return null;
    }

    return $LocationModelCopyWith<$Res>(_value.source!, (value) {
      return _then(_value.copyWith(source: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_BusModelCopyWith<$Res> implements $BusModelCopyWith<$Res> {
  factory _$$_BusModelCopyWith(
          _$_BusModel value, $Res Function(_$_BusModel) then) =
      __$$_BusModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
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
      String? busType});

  @override
  $LocationModelCopyWith<$Res>? get source;
}

/// @nodoc
class __$$_BusModelCopyWithImpl<$Res>
    extends _$BusModelCopyWithImpl<$Res, _$_BusModel>
    implements _$$_BusModelCopyWith<$Res> {
  __$$_BusModelCopyWithImpl(
      _$_BusModel _value, $Res Function(_$_BusModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? price = freezed,
    Object? rating = freezed,
    Object? duration = freezed,
    Object? drivers = freezed,
    Object? source = freezed,
    Object? destinations = freezed,
    Object? departureTime = freezed,
    Object? arrivalTime = freezed,
    Object? busType = freezed,
  }) {
    return _then(_$_BusModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      drivers: freezed == drivers
          ? _value._drivers
          : drivers // ignore: cast_nullable_to_non_nullable
              as List<DriverModel>?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as LocationModel?,
      destinations: freezed == destinations
          ? _value._destinations
          : destinations // ignore: cast_nullable_to_non_nullable
              as List<LocationModel>?,
      departureTime: freezed == departureTime
          ? _value._departureTime
          : departureTime // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
      arrivalTime: freezed == arrivalTime
          ? _value._arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
      busType: freezed == busType
          ? _value.busType
          : busType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BusModel implements _BusModel {
  const _$_BusModel(
      {this.id,
      this.name,
      this.description,
      this.imageUrl,
      this.price,
      this.rating,
      this.duration,
      final List<DriverModel>? drivers,
      this.source,
      final List<LocationModel>? destinations,
      final List<DateTime>? departureTime,
      final List<DateTime>? arrivalTime,
      this.busType})
      : _drivers = drivers,
        _destinations = destinations,
        _departureTime = departureTime,
        _arrivalTime = arrivalTime;

  factory _$_BusModel.fromJson(Map<String, dynamic> json) =>
      _$$_BusModelFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? imageUrl;
  @override
  final String? price;
  @override
  final String? rating;
  @override
  final String? duration;
  final List<DriverModel>? _drivers;
  @override
  List<DriverModel>? get drivers {
    final value = _drivers;
    if (value == null) return null;
    if (_drivers is EqualUnmodifiableListView) return _drivers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final LocationModel? source;
  final List<LocationModel>? _destinations;
  @override
  List<LocationModel>? get destinations {
    final value = _destinations;
    if (value == null) return null;
    if (_destinations is EqualUnmodifiableListView) return _destinations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<DateTime>? _departureTime;
  @override
  List<DateTime>? get departureTime {
    final value = _departureTime;
    if (value == null) return null;
    if (_departureTime is EqualUnmodifiableListView) return _departureTime;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<DateTime>? _arrivalTime;
  @override
  List<DateTime>? get arrivalTime {
    final value = _arrivalTime;
    if (value == null) return null;
    if (_arrivalTime is EqualUnmodifiableListView) return _arrivalTime;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? busType;

  @override
  String toString() {
    return 'BusModel(id: $id, name: $name, description: $description, imageUrl: $imageUrl, price: $price, rating: $rating, duration: $duration, drivers: $drivers, source: $source, destinations: $destinations, departureTime: $departureTime, arrivalTime: $arrivalTime, busType: $busType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BusModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other._drivers, _drivers) &&
            (identical(other.source, source) || other.source == source) &&
            const DeepCollectionEquality()
                .equals(other._destinations, _destinations) &&
            const DeepCollectionEquality()
                .equals(other._departureTime, _departureTime) &&
            const DeepCollectionEquality()
                .equals(other._arrivalTime, _arrivalTime) &&
            (identical(other.busType, busType) || other.busType == busType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      imageUrl,
      price,
      rating,
      duration,
      const DeepCollectionEquality().hash(_drivers),
      source,
      const DeepCollectionEquality().hash(_destinations),
      const DeepCollectionEquality().hash(_departureTime),
      const DeepCollectionEquality().hash(_arrivalTime),
      busType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BusModelCopyWith<_$_BusModel> get copyWith =>
      __$$_BusModelCopyWithImpl<_$_BusModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BusModelToJson(
      this,
    );
  }
}

abstract class _BusModel implements BusModel {
  const factory _BusModel(
      {final int? id,
      final String? name,
      final String? description,
      final String? imageUrl,
      final String? price,
      final String? rating,
      final String? duration,
      final List<DriverModel>? drivers,
      final LocationModel? source,
      final List<LocationModel>? destinations,
      final List<DateTime>? departureTime,
      final List<DateTime>? arrivalTime,
      final String? busType}) = _$_BusModel;

  factory _BusModel.fromJson(Map<String, dynamic> json) = _$_BusModel.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get description;
  @override
  String? get imageUrl;
  @override
  String? get price;
  @override
  String? get rating;
  @override
  String? get duration;
  @override
  List<DriverModel>? get drivers;
  @override
  LocationModel? get source;
  @override
  List<LocationModel>? get destinations;
  @override
  List<DateTime>? get departureTime;
  @override
  List<DateTime>? get arrivalTime;
  @override
  String? get busType;
  @override
  @JsonKey(ignore: true)
  _$$_BusModelCopyWith<_$_BusModel> get copyWith =>
      throw _privateConstructorUsedError;
}
