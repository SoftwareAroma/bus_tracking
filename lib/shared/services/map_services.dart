import 'package:bus_tracking/index.dart';

class MapServices {
  MapServices._();

  static final MapServices instance = MapServices._();

  CustomInfoWindowController pickupInfoWindowController = CustomInfoWindowController();
  CustomInfoWindowController destinationInfoWindowController = CustomInfoWindowController();
}
