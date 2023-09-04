import 'dart:async';
import 'dart:io';

import 'package:bus_tracking/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// polylineCoordinates list [LatLng]
  List<LatLng> polylineCoordinates = <LatLng>[];

  /// polyline
  final List<Polyline> _polyLines = <Polyline>[];

  /// markers
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  final Map<CircleId, Circle> _circles = <CircleId, Circle>{};

  /// static variables
  double _minExtent = 0.3;
  final double _maxExtent = 0.9;
  double _initialExtent = 0.3;
  bool _isExpanded = false;
  double _percent = 0.0;

  /// other variables
  late BuildContext _draggableSheetContext;
  late ScrollController _scrollController;

  /// destination and pickup points bitmap images
  late BitmapDescriptor _destinationIcon;
  late BitmapDescriptor _pickupIcon;

  /// focus node for controlling keyboards
  late FocusNode currentFocus;

  late GoogleMapController _mapController;
  late Position currentPosition;
  double mapBottomPadding = 0;

  bool _isMapLoading = true; // is the map loading
  // bool _isDataLoading = true; // is the map loading

  /// google maps
  final Completer<GoogleMapController> _controller = Completer();

  /// initial Location [LatLng]
  LatLng initialLocation = LatLng(
    ProjectVariables.googlePlex.target.latitude,
    ProjectVariables.googlePlex.target.longitude,
  );

  /// set up position locator [Position]
  _setupPositionLocator() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );
      currentPosition = position;

      LatLng pos = LatLng(position.latitude, position.longitude);
      CameraPosition cp = CameraPosition(target: pos, zoom: 16.5);
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(cp),
      );

      setState(() {
        initialLocation = LatLng(pos.latitude, pos.longitude);
      });

      if (!mounted) return;
    } catch (exception) {
      debugPrint("Exception ${exception.toString()}");
    }
  }

  // ask for permission function
  _askForLocationPermission() async {
    if (Platform.isIOS) {
      // ios
      await Geolocator.requestPermission();
    } else {
      // android
      await Geolocator.requestPermission();
    }
  }

  /// toggle the scrollable sheet height
  _toggleScrollableSheet() {
    if (!mounted) return;
    setState(() {
      _initialExtent = _isExpanded ? _minExtent : _maxExtent;
      _isExpanded = !_isExpanded;
    });
    currentFocus = FocusScope.of(context);
    // hide all keyboards
    HelperFunctions.unFocus(context, currentFocus);
    // reset the scrollable sheet actuator
    DraggableScrollableActuator.reset(_draggableSheetContext);

    /// check if scrollController has any clients
    if (_scrollController.hasClients) {
      /// if it does, jump to 0.0
      _scrollController.jumpTo(0.0);
    }
  }

  @override
  void initState() {
    // if permission is not granted then ask for permission
    _askForLocationPermission();
    // _isDataLoading = true;

    /// create map markers
    _createMarker();

    userController.getLoggedInUserId();

    // _fetchData();

    super.initState();
  }

  /// create markers
  _createMarker() {
    try {
      /// destination and pickup points bitmap images
      ImageConfiguration pickupIconImageConfig = createLocalImageConfiguration(
        context,
        size: const Size(120, 120),
      );

      ImageConfiguration destinationIconImageConfig = createLocalImageConfiguration(
        context,
        size: const Size(120, 120),
      );

      /// destination point icon
      BitmapDescriptor.fromAssetImage(
        destinationIconImageConfig,
        (Platform.isIOS) ? Assets.imagesDestinationAndroid : Assets.imagesDestinationAndroid,
      ).then((icon) {
        _destinationIcon = icon;
      });

      /// pickup points bitmap images
      BitmapDescriptor.fromAssetImage(
        pickupIconImageConfig,
        (Platform.isIOS) ? Assets.imagesPickupAndroid : Assets.imagesPickupAndroid,
      ).then((icon) {
        _pickupIcon = icon;
      });
    } catch (e) {
      return;
    }
  }

  // _fetchData() async {
  //   final bool isDone = await appController.fetchInitialRoutesPoints();
  //   if (isDone) {
  //     setState(() {
  //       _isDataLoading = false;
  //     });
  //   }
  // }

  @override
  void didChangeDependencies() {
    /// create map markers
    _createMarker();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: appController.fetchInitialRoutesPoints(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Obx(
            () => ContentView(
              child: Stack(
                children: <Widget>[
                  /// google maps widget with a StatefulBuilder
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter state) {
                      return GoogleMap(
                        padding: EdgeInsets.only(bottom: mapBottomPadding),
                        initialCameraPosition: ProjectVariables.googlePlex,
                        mapType: MapType.normal,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        zoomGesturesEnabled: true,
                        scrollGesturesEnabled: true,
                        tiltGesturesEnabled: true,
                        rotateGesturesEnabled: true,
                        compassEnabled: true,
                        zoomControlsEnabled: true,
                        trafficEnabled: true,
                        indoorViewEnabled: false,
                        buildingsEnabled: true,
                        cameraTargetBounds: CameraTargetBounds.unbounded,
                        mapToolbarEnabled: true,
                        minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                        polylines: Set<Polyline>.of(_polyLines),
                        markers: Set<Marker>.of(_markers.values),
                        circles: Set<Circle>.of(_circles.values),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                          _mapController = controller;
                          ProjectVariables.mapServices.pickupInfoWindowController.googleMapController = controller;
                          ProjectVariables.mapServices.destinationInfoWindowController.googleMapController = controller;
                          setState(() {
                            _isMapLoading = false;
                            mapBottomPadding = (Platform.isAndroid) ? 250 : 220;
                          });
                          _setupPositionLocator();
                        },
                        onTap: (position) {
                          if (ProjectVariables.mapServices.pickupInfoWindowController.hideInfoWindow != null) {
                            ProjectVariables.mapServices.pickupInfoWindowController.hideInfoWindow!();
                          }
                          if (ProjectVariables.mapServices.destinationInfoWindowController.hideInfoWindow != null) {
                            ProjectVariables.mapServices.destinationInfoWindowController.hideInfoWindow!();
                          }
                        },
                        onCameraMove: (CameraPosition position) {
                          if (ProjectVariables.mapServices.pickupInfoWindowController.onCameraMove != null) {
                            ProjectVariables.mapServices.pickupInfoWindowController.onCameraMove!();
                          }
                          if (ProjectVariables.mapServices.destinationInfoWindowController.onCameraMove != null) {
                            ProjectVariables.mapServices.destinationInfoWindowController.onCameraMove!();
                          }
                        },
                      );
                    },
                  ),

                  /// when map is loading
                  if (_isMapLoading)
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 10.0,
                        ),
                      ),
                    ),

                  /// custom info window for source location
                  CustomInfoWindow(
                    controller: ProjectVariables.mapServices.pickupInfoWindowController,
                    height: MediaQuery.of(context).size.width * 0.19,
                    width: MediaQuery.of(context).size.width * 0.59,
                    offset: 40.0,
                  ),

                  /// custom info window for destination location
                  CustomInfoWindow(
                    controller: ProjectVariables.mapServices.destinationInfoWindowController,
                    height: MediaQuery.of(context).size.width * 0.19,
                    width: MediaQuery.of(context).size.width * 0.59,
                    offset: 40.0,
                  ),

                  /// close button
                  if (appController.activeRoute != null)
                    Positioned(
                      top: 10.0,
                      left: 10.0,
                      child: MenuButton(
                        onPressed: () {
                          appController.resetActiveRoute();
                          setState(() {
                            // clear coordinates and map stuff
                            polylineCoordinates.clear();
                            _polyLines.clear();
                            _markers.clear();
                            _circles.clear();
                            mapBottomPadding = (Platform.isAndroid) ? 250 : 220;

                            // set isExpanded to false
                            _isExpanded = false;

                            // set min extent
                            _minExtent = 0.3;
                            _initialExtent = 0.3;
                            _percent = 0.0;

                            /// hide the info windows
                            mapServices.pickupInfoWindowController.hideInfoWindow!();
                            mapServices.destinationInfoWindowController.hideInfoWindow!();
                          });
                          // debugPrint("${appController.activeRoute}");
                          _toggleScrollableSheet();
                        },
                        icon: const Icon(
                          LineAwesomeIcons.times,
                        ),
                      ),
                    ),

                  /// route details
                  if (appController.activeRoute != null)
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      bottom: 0.0,
                      child: Container(
                        height: 250.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 15.0,
                              offset: Offset(0.7, 0.7),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Gap(10.0),
                            CustomText(
                              appController.activeRoute!.name!.toUpperCase(),
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.6,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Gap(10.0),
                            const BrandDivider(),
                            const Gap(5.0),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    /// all destinations
                                    Column(
                                      children: appController.activeRoute!.destinations!
                                          .asMap()
                                          .map(
                                            (int index, LocationModel locationModel) => MapEntry(
                                              index,
                                              Column(
                                                children: <Widget>[
                                                  Card(
                                                    elevation: 5.0,
                                                    shadowColor: Colors.black12,
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 12.0,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          Image.asset(
                                                            Assets.imagesBusStop,
                                                            width: 20.0,
                                                            height: 20.0,
                                                          ),
                                                          const Gap(15.0),
                                                          Expanded(
                                                            child: Row(
                                                              children: <Widget>[
                                                                Expanded(
                                                                  child: CustomText(
                                                                    locationModel.name!,
                                                                    fontWeight: FontWeight.normal,
                                                                    letterSpacing: 1.6,
                                                                    maxLines: 5,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                ),
                                                                CustomText(
                                                                  HelperFunctions.getTimeFromString(
                                                                    appController.activeRoute!.departureTime![index].toString(),
                                                                  ),
                                                                  fontWeight: FontWeight.normal,
                                                                  letterSpacing: 1.6,
                                                                  maxLines: 5,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const Gap(10.0),

                                                  /// hide if last item
                                                  if (appController.activeRoute!.destinations!.indexOf(locationModel) !=
                                                      appController.activeRoute!.destinations!.length - 1)
                                                    const Icon(LineAwesomeIcons.angle_down),
                                                  if (appController.activeRoute!.destinations!.indexOf(locationModel) !=
                                                      appController.activeRoute!.destinations!.length - 1)
                                                    const Gap(10.0),
                                                ],
                                              ),
                                            ),
                                          )
                                          .values
                                          .toList(),
                                    ),

                                    /// trip details, duration, time, driver, bus details
                                    const Gap(10.0),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                  /// information sheet
                  if (appController.activeRoute == null)
                    Positioned.fill(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: DraggableScrollableActuator(
                        child: NotificationListener<DraggableScrollableNotification>(
                          onNotification: (DraggableScrollableNotification notification) {
                            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                              setState(() {
                                _percent = 2 * notification.extent - 0.8;
                                if (_percent > 0.5) {
                                  _isExpanded = true;
                                } else {
                                  _percent = 0.0;
                                  _isExpanded = false;
                                  _initialExtent = 0.3;
                                }
                              });
                            });
                            return true;
                          },
                          child: DraggableScrollableSheet(
                            initialChildSize: _initialExtent,
                            minChildSize: _minExtent,
                            maxChildSize: _maxExtent,
                            builder: (BuildContext scrollContext, ScrollController scrollController) {
                              _draggableSheetContext = scrollContext;
                              _scrollController = scrollController;
                              return Material(
                                elevation: 10.0,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Gap(12.0),
                                      CustomText(
                                        "Select Route".toUpperCase(),
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1.6,
                                      ),
                                      const Gap(10.0),
                                      Expanded(
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          physics: const ClampingScrollPhysics(),
                                          padding: const EdgeInsets.all(0.0),
                                          itemCount: !snapshot.hasData ? 4 : appController.buses.length,
                                          controller: _scrollController,
                                          itemBuilder: (BuildContext context, int index) {
                                            return !snapshot.hasData
                                                ? SkeletonLoader(isEnabled: snapshot.hasData)
                                                : PredictionTile(
                                                    prediction: appController.buses[index],
                                                    onPressed: () async {
                                                      /// show the details sheet
                                                      appController.updateActiveRoute(appController.buses[index]);
                                                      _toggleScrollableSheet();

                                                      /// get the place details
                                                      AddressModel? pickup = await HelperFunctions.getPlaceDetails(
                                                        appController.buses[index].source!.placeId!,
                                                      );
                                                      AddressModel? destination = await HelperFunctions.getPlaceDetails(
                                                        appController
                                                            .buses[index].destinations![appController.buses[index].destinations!.length - 1].placeId!,
                                                      );

                                                      /// get the direction from start to finish of the route selected
                                                      _getDirection(pickup!, destination!);
                                                    },
                                                  );
                                          },
                                          separatorBuilder: (BuildContext context, int index) {
                                            return const Gap(15.0);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        } else {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SkeletonLoader(isEnabled: true),
              Gap(10.01),
              SkeletonLoader(isEnabled: true),
              Gap(10.01),
              SkeletonLoader(isEnabled: true),
              Gap(10.01),
              SkeletonLoader(isEnabled: true),
              Gap(10.01),
              SkeletonLoader(isEnabled: true),
              Gap(10.01),
            ],
          );
        }
      },
    );
  }

  /// get directions
  Future<void> _getDirection(AddressModel pickup, AddressModel destination) async {
    try {
      if (pickup.latitude != null && destination.latitude != null) {
        LatLng pickLatLng = LatLng(
          pickup.latitude!,
          pickup.longitude!,
        );

        LatLng destinationLatLng = LatLng(
          destination.latitude!,
          destination.longitude!,
        );

        DirectionDetailsModel? thisDetails = await HelperFunctions.getDirectionDetails(
          pickLatLng,
          destinationLatLng,
        );

        /// get the duration text
        String? durationText = thisDetails?.durationText?.split(" ")[0];

        /// update the trip direction details
        // rideController.updateDirectionDetails(thisDetails!);

        /// pick up marker
        CustomWindow customPickUpMarker = CustomWindow(
          info: InfoWindowModel(
            name: "${pickup.placeName}",
            position: pickLatLng,
            type: InfoWindowType.position,
            time: Duration(minutes: int.parse(durationText!)),
          ),
          triangleColor: BrandColors.kColorDarkGreen,
        );

        /// destination marker
        CustomWindow customDestinationMarker = CustomWindow(
          info: InfoWindowModel(
            name: "${destination.placeName}",
            position: destinationLatLng,
            type: InfoWindowType.position,
            time: Duration(minutes: int.parse(durationText)),
          ),
          triangleColor: BrandColors.kColorRed,
          tileColor: BrandColors.kColorDarkBlue,
        );

        if (!mounted) return;

        // showLoading(context);

        PolylinePoints polylinePoints = PolylinePoints();
        List<PointLatLng> results = polylinePoints.decodePolyline(
          thisDetails!.encodedPoints!,
        );

        polylineCoordinates.clear();
        if (results.isNotEmpty) {
          /// loop through all PointLatLng points and convert them
          /// to a list of LatLng, required by the Polyline
          for (PointLatLng point in results) {
            polylineCoordinates.add(
              LatLng(
                point.latitude,
                point.longitude,
              ),
            );
          }
        }

        _polyLines.clear();

        setState(() {
          Polyline polyline = Polyline(
            polylineId: const PolylineId('poly_id'),
            color: const Color.fromARGB(255, 95, 109, 237),
            points: polylineCoordinates,
            jointType: JointType.round,
            width: 4,
            startCap: Cap.buttCap,
            endCap: Cap.buttCap,
            geodesic: true,
          );

          _polyLines.add(polyline);
        });

        // make polyline to fit into the map
        LatLngBounds bounds;

        // create a bounds from polyline
        if (pickLatLng.latitude > destinationLatLng.latitude && pickLatLng.longitude > destinationLatLng.longitude) {
          bounds = LatLngBounds(
            southwest: destinationLatLng,
            northeast: pickLatLng,
          );
        } else if (pickLatLng.longitude > destinationLatLng.longitude) {
          bounds = LatLngBounds(
            southwest: LatLng(
              pickLatLng.latitude,
              destinationLatLng.longitude,
            ),
            northeast: LatLng(
              destinationLatLng.latitude,
              pickLatLng.longitude,
            ),
          );
        } else if (pickLatLng.latitude > destinationLatLng.latitude) {
          bounds = LatLngBounds(
            southwest: LatLng(
              destinationLatLng.latitude,
              pickLatLng.longitude,
            ),
            northeast: LatLng(
              pickLatLng.latitude,
              destinationLatLng.longitude,
            ),
          );
        } else {
          bounds = LatLngBounds(
            southwest: pickLatLng,
            northeast: destinationLatLng,
          );
        }

        _mapController.animateCamera(
          CameraUpdate.newLatLngBounds(bounds, 70.0),
        );

        /// pick up marker
        Marker pickupMarker = Marker(
          markerId: ProjectVariables.pickupMarkerId,
          position: pickLatLng,
          icon: _pickupIcon,
          onTap: () {
            mapServices.pickupInfoWindowController.addInfoWindow!(
              customPickUpMarker,
              pickLatLng,
            );
          },
        );

        /// destination marker
        Marker destinationMarker = Marker(
          markerId: ProjectVariables.destinationMarkerId,
          position: destinationLatLng,
          icon: _destinationIcon,
          onTap: () {
            mapServices.destinationInfoWindowController.addInfoWindow!(
              customDestinationMarker,
              destinationLatLng,
            );
          },
        );

        /// add the markers
        setState(() {
          _markers[ProjectVariables.pickupMarkerId] = pickupMarker;
          _markers[ProjectVariables.destinationMarkerId] = destinationMarker;
        });

        /// pick up circle
        Circle pickupCircle = Circle(
          circleId: ProjectVariables.pickupCircleId,
          strokeColor: BrandColors.kColorDarkGreen,
          strokeWidth: 3,
          radius: 12,
          center: pickLatLng,
          fillColor: Colors.green,
        );

        /// destination circle
        Circle destinationCircle = Circle(
          circleId: ProjectVariables.destinationCircleId,
          strokeColor: BrandColors.kColorDarkBlue,
          strokeWidth: 3,
          radius: 12,
          center: destinationLatLng,
          fillColor: BrandColors.kColorLightBlue,
        );

        /// add the circles
        setState(() {
          _circles[ProjectVariables.pickupCircleId] = pickupCircle;
          _circles[ProjectVariables.destinationCircleId] = destinationCircle;
        });

        mapServices.pickupInfoWindowController.addInfoWindow!(
          customPickUpMarker,
          pickLatLng,
        );

        mapServices.destinationInfoWindowController.addInfoWindow!(
          customDestinationMarker,
          destinationLatLng,
        );
      } else {
        return;
      }
    } catch (e) {
      return;
    }
  }
}
