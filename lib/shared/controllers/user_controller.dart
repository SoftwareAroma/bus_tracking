import 'package:bus_tracking/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  final _currentUser = Rxn<UserModel>();
  final _isLoggedIn = false.obs;

  /// update the current user [UserModel]
  void updateUser(UserModel user) async {
    _currentUser.value = user;
    storeLoggedInUserId(user.id!);
  }

  /// store [UserModel] id in preferences
  void storeLoggedInUserId(int userId) async {
    final prefs = await sharedPreferences;
    await prefs.setInt('loggedInUserId', userId);
  }

  /// get [UserModel] id from preferences
  Future<UserModel?> getLoggedInUserId() async {
    final prefs = await sharedPreferences;
    int? userId = prefs.getInt('loggedInUserId');
    debugPrint("current user id $userId");
    if (userId == null) return null;
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, Object?>> userMapList = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (userMapList.isEmpty) {
      return null;
    }
    UserModel userModel = UserModel.fromJson(userMapList.first);
    _currentUser.value = userModel;
    debugPrint("user from userController ${_currentUser.value?.firstName}");

    /// get all events
    getEvents();
    update();
    return _currentUser.value;
  }

  /// get all events [EventModel]
  void getEvents() async {
    try {
      /// Create Database reference
      final Database db = await DatabaseHelper.instance.database;

      /// Query all events from the 'events' table
      final List<Map<String, Object?>> eventMapList = await db.query('events');

      /// Check if there are any events in the database
      if (eventMapList.isNotEmpty) {
        // Create a list to store EventModel instances
        List<EventModel> events = <EventModel>[];

        // Iterate through the eventMapList and create EventModel instances
        for (Map<String, Object?> eventMap in eventMapList) {
          events.add(EventModel.fromJson(eventMap));
        }
        _currentUser.value = currentUser?.copyWith(events: events);
        addNotification();
      }
    } catch (e) {
      // Handle any errors that may occur during database access
      debugPrint('Error fetching events: $e');
    }
  }

  Future<void> addNotification() async {
    final DateTime now = DateTime.now();
    final List<EventModel> upcomingEvents = _currentUser.value?.events ?? [];

    upcomingEvents.where((EventModel eventModel) {
      // Filter out events with past dates
      final DateTime eventTime = DateTime.parse(eventModel.time.toString());
      return eventTime.isAfter(now);
    }).forEach((EventModel eventModel) async {
      DateTime scheduleTime = DateTime.parse(eventModel.time.toString());
      // Subtract 5 minutes from the scheduled time
      // DateTime notificationTime = scheduleTime.subtract(const Duration(minutes: 5));
      NotificationService().scheduleNotification(
        title: eventModel.title ?? "Upcoming Event",
        body: '${eventModel.description}',
        scheduledNotificationDateTime: scheduleTime,
      );
      debugPrint("Notification added for ${eventModel.title}");
    });
  }

  /// reset current user [UserModel]
  void logoutUser() async {
    final prefs = await sharedPreferences;
    await prefs.remove('loggedInUserId');
    _currentUser.value = null;
  }

  UserModel? get currentUser => _currentUser.value;
  bool get isLoggedIn => _isLoggedIn.value;
}
