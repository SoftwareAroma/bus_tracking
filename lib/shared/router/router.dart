import 'package:bus_tracking/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart';

const routerAuthLocation = '/auth';
const routerUserEventsLocation = '/events';
const routerUserEventLocation = ':id';
const routerHomeLocation = '/home';
const routerUserProfileLocation = '/profile';

/// [GoRouter] for the entire app
final router = GoRouter(
  routes: $appRoutes,
  errorBuilder: (BuildContext context, GoRouterState state) {
    return const NotFoundPage();
  },
  debugLogDiagnostics: kDebugMode,
  // initialLocation: routerAuthLocation,
  initialLocation: userController.currentUser != null
      ? routerHomeLocation // User is authenticated, navigate to home
      : routerAuthLocation, // User is not authenticated, navigate to auth
);

/// wrapper for the entire app
@TypedStatefulShellRoute<ShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    /// Auth Route
    TypedStatefulShellBranch(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<AuthScreenRoute>(
          path: routerAuthLocation,
        ),
      ],
    ),

    /// Home Route
    TypedStatefulShellBranch(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeScreenRoute>(
          path: routerHomeLocation,
        ),
      ],
    ),

    /// Profile Route
    TypedStatefulShellBranch(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ProfileScreenRoute>(
          path: routerUserProfileLocation,
        ),
      ],
    ),
  ],
)

/// [ShellRouteData] for the entire app
class ShellRouteData extends StatefulShellRouteData {
  const ShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return ScaffoldWithNavigation(
      navigationShell: navigationShell,
    );
  }
}

/// [HomeScreenRoute] for the dashboard
class HomeScreenRoute extends GoRouteData {
  const HomeScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

/// [AuthScreenRoute] for the dashboard
class AuthScreenRoute extends GoRouteData {
  const AuthScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AuthScreen();
  }
}

/// [ProfileScreenRoute] for the dashboard
class ProfileScreenRoute extends GoRouteData {
  const ProfileScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileScreen();
  }
}
