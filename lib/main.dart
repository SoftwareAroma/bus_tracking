import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bus_tracking/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification();

  /// initialize data layers
  Get.lazyPut(() => AppController());
  Get.lazyPut(() => UserController());
  runApp(App());

  /// orientation (portraitUp, portraitDown)
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: userController.getLoggedInUserId(),
      builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final _ = snapshot.data;
          return AdaptiveTheme(
            light: AppTheme.light,
            dark: AppTheme.dark,
            initial: AdaptiveThemeMode.system,
            builder: (ThemeData theme, ThemeData darkTheme) => GetMaterialApp.router(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                FormBuilderLocalizations.delegate,
                ...GlobalMaterialLocalizations.delegates,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: FormBuilderLocalizations.supportedLocales,
              title: AppStrings.appTitle,
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
              routeInformationProvider: router.routeInformationProvider,
              theme: theme,
              darkTheme: darkTheme,
            ),
          );
        } else {
          // Return a loading indicator or splash screen while data is loading.
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

// class App extends StatelessWidget {
//   App({super.key}) {
//     userController.getLoggedInUserId();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AdaptiveTheme(
//       light: AppTheme.light,
//       dark: AppTheme.dark,
//       initial: AdaptiveThemeMode.light,
//       builder: (ThemeData theme, ThemeData darkTheme) => GetMaterialApp.router(
//         debugShowCheckedModeBanner: false,
//         localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
//           FormBuilderLocalizations.delegate,
//           ...GlobalMaterialLocalizations.delegates,
//           GlobalWidgetsLocalizations.delegate,
//         ],
//         supportedLocales: FormBuilderLocalizations.supportedLocales,
//         title: AppStrings.appTitle,
//         // routerConfig: router,
//         routeInformationParser: router.routeInformationParser,
//         routerDelegate: router.routerDelegate,
//         routeInformationProvider: router.routeInformationProvider,
//         theme: theme,
//         darkTheme: darkTheme,
//       ),
//     );
//   }
// }
