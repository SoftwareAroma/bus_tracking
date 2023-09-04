import 'package:bus_tracking/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavigation extends StatelessWidget {
  const ScaffoldWithNavigation({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return _ScaffoldWithDrawer(navigationShell);
  }
}

/// Scaffold with Drawer for [MOBILE] and [TABLET]
class _ScaffoldWithDrawer extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const _ScaffoldWithDrawer(this.navigationShell);

  @override
  Widget build(BuildContext context) {
    // debugPrint("currentIndex ${navigationShell.route.routes[navigationShell.currentIndex]}");
    // debugPrint("currentIndex ${navigationShell.currentIndex}");
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: (!(navigationShell.currentIndex == 0))
          ? (appController.activeRoute == null)
              ? const NavigationAppBar()
              : null
          : null,
      body: SafeArea(child: navigationShell),
      drawer: SafeArea(
        child: Drawer(
          shadowColor: Colors.black12,
          elevation: 10.0,
          child: Column(
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  boxShadow: null,
                  border: Border(
                    bottom: BorderSide.none,
                  ),
                ),
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: Center(
                  child: CustomText(
                    AppStrings.appTitle,
                    fontWeight: FontWeight.w900,
                    fontSize: 26.0,
                  ),
                ),
              ),
              Expanded(
                child: _NavigationRail(
                  navigationShell: navigationShell,
                  expand: true,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: ThemeModeButton.outlined(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Navigation Rail
class _NavigationRail extends StatelessWidget {
  const _NavigationRail({
    required this.navigationShell,
    required this.expand,
  });

  final StatefulNavigationShell navigationShell;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    List<NavigationRailDestination> destinations = <NavigationRailDestination>[];

    for (final NavigationItem item in NavigationItem.values) {
      // debugPrint("item: ${item.label.toTitleCase()}");
      destinations.add(
        NavigationRailDestination(
          icon: Icon(item.iconData),
          label: Text(item.label.toTitleCase()),
        ),
      );
    }

    final theme = Theme.of(context);
    return NavigationRail(
      extended: expand,
      selectedIndex: navigationShell.currentIndex,
      unselectedLabelTextStyle: theme.textTheme.bodyMedium,
      selectedLabelTextStyle: theme.textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.bold,
      ),
      onDestinationSelected: (int index) {
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
      },
      destinations: destinations,
    );
  }
}
