import 'package:bus_tracking/index.dart';
import 'package:faker/faker.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  static AppController instance = Get.find();

  final _initialLocationPoints = <LocationModel>[].obs;
  final _buses = <BusModel>[].obs;
  final _activeRoute = Rxn<BusModel>();

  /// faker [Faker]
  final _faker = Faker();

  /// List of bus names [String]
  final List<String> _busNames = <String>[
    "Commercial Area - KSB",
    "KSB - Commercial Area",
    "Brunei Complex - KSB",
    "KSB - Brunei Complex",
    "Gaza Area - Pharmacy",
    "Pharmacy - Gaza Area",
  ];

  /// List of route destinations [String]
  /// 0 -> KSB, 1 -> Commercial Area, 2 -> Caseley Hayford, 3 -> Pharmacy, 4 -> KNUST Admin, 5 -> Brunei Complex, 6 -> Wilkado Hostel, 7 -> Hall 7
  final List<String> _routeDestinations = <String>[
    "School of Business (KSB) KNUST, Kwame Nkrumah University of Science and Technology, Ayim Complex, P. V. Obeng Ave, Kumasi",
    "KNUST Commercial Area, MCMF+7GP, Kumasi",
    "Casely - Hayford Building, KNUST, Kumasi",
    "Pharmacy Department (KNUST), Kumasi",
    "KNUST Main Administration, MCFH+VFJ, Kumasi",
    "Brunei Complex, MC9G+C5X, Kumasi",
    "Wilkado Hostel, Kumasi",
    "Chancellor's Hall (Hall 7), MCHG+QHC, Kumasi",
  ];

  final List<DriverModel> _drivers = <DriverModel>[];

  /// create the list of all [DriverModel]
  Future<void> createDrivers() async {
    for (int i = 1; i <= _busNames.length; i++) {
      DriverModel driverModel = DriverModel(
        id: i,
        name: _faker.person.name(),
        description: _faker.lorem.sentence(),
        imageUrl: ProjectVariables.defaultUserIcon,
        rating: 3.0,
        bus: _busNames[i],
      );
      _drivers.add(driverModel);
    }
  }

  /// fetch the initial data [LocationModel]
  Future<bool> fetchInitialRoutesPoints() async {
    final List<LocationModel> newLocationPoints = <LocationModel>[];
    for (String element in _routeDestinations) {
      List<PredictionModel>? thisList = await HelperFunctions.searchPlace(element);
      // debugPrint("details $thisList");
      if (thisList != null) {
        PredictionModel prediction = thisList[0];
        AddressModel? addressModel = await HelperFunctions.getPlaceDetails(prediction.placeId!);
        LocationModel location = LocationModel(
          name: addressModel!.placeName!,
          secondaryText: addressModel.placeFormattedAddress ?? prediction.secondaryText ?? "",
          latitude: addressModel.latitude!,
          longitude: addressModel.longitude!,
          placeId: prediction.placeId!,
        );
        newLocationPoints.add(location);
      }
    }
    _initialLocationPoints.value = newLocationPoints;
    createBusList();
    update();
    return true;
  }

  /// possible routes
  /// school of business -> Caseley hayford -> knust admin -> brunei
  /// school of business -> Caseley hayford -> hall 7 -> commercial area
  /// commercial area -> pharmacy -> knust school business
  /// pharmacy -> wilkado hostel
  /// wilkado hostel -> pharmacy

  /// create a list of buses [BusModel]
  /// 0 -> KSB, 1 -> Commercial Area, 2 -> Caseley Hayford, 3 -> Pharmacy, 4 -> KNUST Admin, 5 -> Brunei Complex, 6 -> Wilkado Hostel, 7 -> Hall 7
  ///     "Commercial Area - KSB",
  ///     "KSB - Commercial Area",
  ///     "Brunei Complex - KSB",
  ///     "KSB - Brunei Complex",
  ///     "Gaza Area - Pharmacy",
  ///     "Pharmacy - Gaza Area",
  void createBusList() {
    final List<BusModel> newBuses = <BusModel>[];

    /// Create a map to associate drivers with buses
    Map<String, List<DriverModel>> busDriverMap = {};

    /// Iterate through the drivers and populate the busDriverMap
    for (var driver in _drivers) {
      if (!busDriverMap.containsKey(driver.bus)) {
        busDriverMap[driver.bus!] = [];
      }
      busDriverMap[driver.bus]!.add(driver);
    }

    /// loop and create the buses list
    for (String element in _busNames) {
      /// ksb to commercial area
      if (element == "Commercial Area - KSB") {
        BusModel bus = BusModel(
          name: element,
          description: "This bus moves from the Commercial area to the school of business and back",
          source: _initialLocationPoints[1],
          destinations: <LocationModel>[
            _initialLocationPoints[1],
            _initialLocationPoints[7],
            _initialLocationPoints[3],
            _initialLocationPoints[0],
          ],
          drivers: busDriverMap[element] ?? [],
          departureTime: [
            HelperFunctions.createTime(8, 0),
            HelperFunctions.createTime(8, 15),
            HelperFunctions.createTime(8, 30),
            HelperFunctions.createTime(8, 45),
          ],
        );
        // Iterate through drivers and add them to the bus if their 'bus' field matches
        for (DriverModel driver in _drivers) {
          if (driver.bus == bus.name) {
            bus.drivers?.add(driver);
          }
        }

        // debugPrint("bus ${bus.departureTime}");

        newBuses.add(bus);
      }

      /// commercial area to ksb
      if (element == "KSB - Commercial Area") {
        BusModel bus = BusModel(
          name: element,
          description: "This bus moves from the school of business to the commercial area and back",
          source: _initialLocationPoints[0],
          destinations: <LocationModel>[
            _initialLocationPoints[0],
            _initialLocationPoints[2],
            _initialLocationPoints[7],
            _initialLocationPoints[1],
          ],
          drivers: busDriverMap[element] ?? [],
          departureTime: <DateTime>[
            HelperFunctions.createTime(9, 0),
            HelperFunctions.createTime(9, 15),
            HelperFunctions.createTime(9, 30),
            HelperFunctions.createTime(9, 45),
          ],
        );
        newBuses.add(bus);
      }

      /// brunei to ksb
      if (element == "Brunei Complex - KSB") {
        BusModel bus = BusModel(
          name: element,
          description: "This bus moves from the Brunei complex area to the school of business and back",
          source: _initialLocationPoints[5],
          destinations: <LocationModel>[
            _initialLocationPoints[5],
            _initialLocationPoints[4],
            _initialLocationPoints[3],
            _initialLocationPoints[0],
          ],
          drivers: busDriverMap[element] ?? [],
          departureTime: <DateTime>[
            HelperFunctions.createTime(8, 0),
            HelperFunctions.createTime(8, 15),
            HelperFunctions.createTime(8, 30),
            HelperFunctions.createTime(8, 45),
          ],
        );
        newBuses.add(bus);
      }

      /// ksb to brunei
      if (element == "KSB - Brunei Complex") {
        BusModel bus = BusModel(
          name: element,
          description: "This bus moves from the school of business to Brunei complex area and back",
          source: _initialLocationPoints[0],
          destinations: <LocationModel>[
            _initialLocationPoints[0],
            _initialLocationPoints[2],
            _initialLocationPoints[4],
            _initialLocationPoints[5],
          ],
          drivers: busDriverMap[element] ?? [],
          departureTime: <DateTime>[
            HelperFunctions.createTime(8, 45),
            HelperFunctions.createTime(9, 0),
            HelperFunctions.createTime(9, 15),
            HelperFunctions.createTime(9, 30),
          ],
        );
        newBuses.add(bus);
      }

      /// gaza area to pharmacy
      if (element == "Gaza Area - Pharmacy") {
        BusModel bus = BusModel(
          name: element,
          description: "Ths bus moves from Gaza area to the pharmacy area and back",
          source: _initialLocationPoints[6],
          destinations: <LocationModel>[
            _initialLocationPoints[6],
            _initialLocationPoints[3],
          ],
          drivers: busDriverMap[element] ?? [],
          departureTime: <DateTime>[
            HelperFunctions.createTime(8, 0),
            HelperFunctions.createTime(8, 15),
            HelperFunctions.createTime(8, 30),
            HelperFunctions.createTime(8, 45),
          ],
        );
        newBuses.add(bus);
      }

      /// pharmacy to gaza area
      if (element == "Pharmacy - Gaza Area") {
        BusModel bus = BusModel(
          name: element,
          description: "Ths bus moves from the pharmacy area to Gaza area and back",
          source: _initialLocationPoints[3],
          destinations: <LocationModel>[
            _initialLocationPoints[3],
            _initialLocationPoints[6],
          ],
          drivers: busDriverMap[element] ?? [],
          departureTime: <DateTime>[
            HelperFunctions.createTime(8, 45),
            HelperFunctions.createTime(9, 0),
            HelperFunctions.createTime(9, 15),
            HelperFunctions.createTime(9, 30),
          ],
        );
        newBuses.add(bus);
      }
    }
    // state = state.copyWith(buses: newBuses);
    _buses.value = newBuses;
    update();
  }

  /// add a [BusModel] to the list of [busses]
  void addBus(BusModel bus) {
    _buses.add(bus);
  }

  /// remove a [BusModel] from the list of [busses]
  void removeBus(BusModel bus) {
    _buses.remove(bus);
  }

  /// add a [LocationModel] to the list of initial location points
  void addLocationPoint(LocationModel location) {
    _initialLocationPoints.add(location);
  }

  /// remove a [LocationModel] from the list of initial location points
  void removeLocationPoint(LocationModel location) {
    _initialLocationPoints.remove(location);
  }

  /// update the active route
  void updateActiveRoute(BusModel bus) {
    _activeRoute.value = bus;
  }

  /// reset the active route
  void resetActiveRoute() {
    _activeRoute.value = null;
  }

  List<BusModel> get buses => _buses;
  List<DriverModel> get drivers => _drivers;
  List<LocationModel> get initialLocationPoints => _initialLocationPoints;
  BusModel? get activeRoute => _activeRoute.value;
}
