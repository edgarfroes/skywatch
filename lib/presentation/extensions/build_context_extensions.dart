import 'package:flutter/material.dart';
import 'package:skywatch/presentation/l10n/l10n.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  EdgeInsets get safeAreaPadding => mediaQuery.padding;
  Localization get l10n => Localization.of(this);
  FocusScopeNode get focusScope => FocusScope.of(this);
}
