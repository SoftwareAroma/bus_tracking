import 'package:bus_tracking/index.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class HelperFunctions {
  HelperFunctions._();

  static final HelperFunctions instance = HelperFunctions._();

  /// extract time from date time string
  static String getTimeFromString(String dateTimeString) {
    /// Your DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString);

    /// Format the DateTime object to a string with only hours and minutes
    String formattedTime = DateFormat('HH:mm').format(dateTime);

    /// Print the formatted time string
    return formattedTime; // 12:34
  }

  /// create [DateTime]
  static DateTime createTime(int hour, int minute) {
    DateTime dateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      hour,
      minute,
    );
    return dateTime;
  }

  /// get direction details
  static Future<DirectionDetailsModel?> getDirectionDetails(LatLng startPosition, LatLng endPosition) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=${ProjectVariables.mapKey}';

    dynamic response = await RequestHelper.getRequest(url);

    if (response == 'failed') {
      return null;
    }

    DirectionDetailsModel directionDetails = const DirectionDetailsModel();

    directionDetails = directionDetails.copyWith(durationText: response['routes'][0]['legs'][0]['duration']['text']);
    directionDetails = directionDetails.copyWith(durationValue: response['routes'][0]['legs'][0]['duration']['value']);

    directionDetails = directionDetails.copyWith(distanceText: response['routes'][0]['legs'][0]['distance']['text']);
    directionDetails = directionDetails.copyWith(distanceValue: response['routes'][0]['legs'][0]['distance']['value']);

    directionDetails = directionDetails.copyWith(encodedPoints: response['routes'][0]['overview_polyline']['points']);

    return directionDetails;
  }

  /// hide all keyboard
  static void unFocus(BuildContext context, dynamic currentFocus) {
    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      // use the focus manager to unFocus
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  /// get place details
  static Future<AddressModel?> getPlaceDetails(String placeID, {BuildContext? context}) async {
    context != null ? showLoading(context) : null;
    String url = 'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=${ProjectVariables.mapKey}';
    dynamic response = await RequestHelper.getRequest(url);
    (context != null && context.mounted) ? Navigator.pop(context) : null;
    if (response == 'failed') {
      return null;
    }
    if (response['status'] == 'OK') {
      AddressModel thisPlace = const AddressModel();
      thisPlace = thisPlace.copyWith(placeName: response['result']['name']);
      thisPlace = thisPlace.copyWith(placeId: placeID);
      thisPlace = thisPlace.copyWith(latitude: response['result']['geometry']['location']['lat']);
      thisPlace = thisPlace.copyWith(longitude: response['result']['geometry']['location']['lng']);
      // rideController.updateDestinationAddress(thisPlace);
      // rideController.changeDestination();
      return thisPlace;
    }
    return null;
  }

  /// Search for the place and its suggestion on changing the value of the
  /// destination text box
  static Future<List<PredictionModel>?> searchPlace(String placeName) async {
    if (placeName.length > 1) {
      String url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=${ProjectVariables.mapKey}&sessiontoken=123254251&components=country:gh';
      dynamic response = await RequestHelper.getRequest(url);
      // debugPrint("response search >>>>>>>> $response");
      if (response == 'failed') {
        return null;
      }

      if (response['status'] == 'OK') {
        var predictionJson = response['predictions'];

        List<PredictionModel> thisList = (predictionJson as List).map((place) {
          Map<String, dynamic> placeData = {
            "placeId": place['place_id'],
            "mainText": place['structured_formatting']['main_text'],
            "secondaryText": place['structured_formatting']['secondary_text'],
          };
          return PredictionModel.fromJson(placeData);
        }).toList();
        return thisList;
      }
      return null;
    }
    return null;
  }
}
