import 'package:bus_tracking/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class NavigationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NavigationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 25,
      scrolledUnderElevation: 10,
      shadowColor: Colors.black12,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              LineAwesomeIcons.bars,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      title: InkWell(
        onTap: () => context.go(routerHomeLocation),
        child: CustomText(
          AppStrings.appTitle.toUpperCase(),
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          letterSpacing: 1.4,
        ),
      ),
      actions: <Widget>[
        const Gap(10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: PopupMenuButton<void>(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<void>>[
              if (!(userController.currentUser == null))
                PopupMenuItem(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(80.0),
                      child: CachedNetworkImage(
                        // width: 200.0,
                        // height: 200.0,
                        imageUrl: userController.currentUser?.avatar ?? ProjectVariables.defaultUserIcon,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Image.asset(
                          Assets.imagesAccount,
                          // width: 200.0,
                          // height: 200.0,
                        ),
                        errorWidget: (context, url, dynamic) {
                          return Image.asset(
                            Assets.imagesAccount,
                            // width: 200.0,
                            // height: 200.0,
                          );
                        },
                      ),
                    ),
                    title: const Text('Profile'),
                  ),
                  onTap: () {
                    // go to the ProfileScreen
                    context.go(routerUserProfileLocation);
                  },
                ),
              if ((userController.currentUser == null))
                PopupMenuItem(
                  child: const ListTile(
                    leading: Icon(LineAwesomeIcons.alternate_sign_in),
                    title: Text('Sign in'),
                  ),
                  onTap: () {
                    /// go to AuthScreen
                    context.go(routerAuthLocation);
                  },
                ),
              if (!(userController.currentUser == null))
                PopupMenuItem(
                  child: const ListTile(
                    leading: Icon(LineAwesomeIcons.alternate_sign_out),
                    title: Text('Sign out'),
                  ),
                  onTap: () {
                    /// Sign out user
                    userController.logoutUser();

                    /// go to the HomeScreen
                    context.go(routerHomeLocation);
                  },
                ),
            ],
            child: const Icon(
              LineAwesomeIcons.user_circle,
              size: 30.0,
            ),
          ),
        ),
        const Gap(8.0),
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
