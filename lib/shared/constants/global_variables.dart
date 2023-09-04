import 'package:bus_tracking/index.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqflite/sqflite.dart';

class ProjectVariables {
  ProjectVariables._();

  static MapServices mapServices = MapServices.instance;

  static CameraPosition get googlePlex => const CameraPosition(
        target: LatLng(6.673175, -1.565423),
        zoom: 18.4746,
      );

  static String get mapKey => 'AIzaSyCPwnvCYFCfo4gtIw5EXMEndLuS978-tCc';
  static String get defaultUserIcon =>
      'https://firebasestorage.googleapis.com/v0/b/stuber-ghana.appspot.com/o/account.png?alt=media&token=4c6a0809-e58b-4e89-a1e4-ec996fb34865';

  /// marker ids [MarkerId]
  static MarkerId get pickupMarkerId => const MarkerId("pickup");
  static MarkerId get destinationMarkerId => const MarkerId("destination");

  /// circle ids [CircleId]
  static CircleId get pickupCircleId => const CircleId("pickup");
  static CircleId get destinationCircleId => const CircleId("destination");

  /// [Database] path
  static String get databasePath => 'bus_tracking.db';

  /// change defaultLatLng to default country [LAT_LNG] if the user didn't provide any location
  static LatLng get defaultLatLng => const LatLng(30.033333, 31.233334);
  static double get defaultMapZoom => 18.4746;
  static double get mediumMapZoom => 14.0;
  static int get locationChangeInterval => 5000; // in milliseconds
}
