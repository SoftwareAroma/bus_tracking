import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

enum _Variant {
  icon,
  outlined,
}

class ThemeModeButton extends StatelessWidget {
  const ThemeModeButton._(this.variant);

  const ThemeModeButton.icon() : this._(_Variant.icon);
  const ThemeModeButton.outlined() : this._(_Variant.outlined);

  // ignore: library_private_types_in_public_api
  final _Variant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final brightness = Theme.of(context).brightness;
    final (iconData, action, actionLabel) = switch (brightness) {
      Brightness.light => (LineAwesomeIcons.moon, AdaptiveTheme.of(context).setDark, 'Switch to dark'),
      Brightness.dark => (LineAwesomeIcons.sun, AdaptiveTheme.of(context).setLight, 'Switch to light')
    };

    return switch (variant) {
      _Variant.icon => IconButton(
          icon: Icon(iconData),
          onPressed: action,
        ),
      _Variant.outlined => OutlinedButton.icon(
          onPressed: action,
          icon: Icon(iconData),
          label: Text(actionLabel),
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: colorScheme.primary.withOpacity(0.5),
            ),
          ),
        )
    };
  }
}
