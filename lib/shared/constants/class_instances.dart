import 'package:bus_tracking/index.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppController appController = AppController.instance;
UserController userController = UserController.instance;
MapServices mapServices = MapServices.instance;
Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
