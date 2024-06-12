import 'package:flutter/material.dart';

abstract class BuzzChatPalette {
  static const primary = _PrimaryColor();
  static const secondary = _SecondaryColor();
  static const warning = _WarningColor();
  static const success = _SuccessColor();
  static const error = _ErrorColor();
  static const grayscale = _GrayscaleColor();
}

class _PrimaryColor {
  const _PrimaryColor();
  final Color primary100 = const Color(0xff000614);
  final Color primary200 = const Color(0xff001a52);
  final Color primary300 = const Color(0xff002d8f);
  final Color primary400 = const Color(0xff0041cc);
  final Color primary500 = const Color(0xff004fff);
  final Color primary600 = const Color(0xff4782ff);
  final Color primary700 = const Color(0xff85abff);
  final Color primary800 = const Color(0xffc2d5ff);
  final Color primary900 = const Color(0xffebf1ff);
}

class _SecondaryColor {
  const _SecondaryColor();
  final Color secondary100 = const Color(0xff0b0722);
  final Color secondary200 = const Color(0xff150d45);
  final Color secondary300 = const Color(0xff251778);
  final Color secondary400 = const Color(0xff3521ab);
  final Color secondary500 = const Color(0xff4a31d8);
  final Color secondary600 = const Color(0xff7865e2);
  final Color secondary700 = const Color(0xffa598eb);
  final Color secondary800 = const Color(0xffc3baf2);
  final Color secondary900 = const Color(0xfff0eefc);
}

class _WarningColor {
  const _WarningColor();
  final Color warning100 = const Color(0xff141101);
  final Color warning200 = const Color(0xff3b3202);
  final Color warning300 = const Color(0xff776404);
  final Color warning400 = const Color(0xffb29506);
  final Color warning500 = const Color(0xffefca08);
  final Color warning600 = const Color(0xfff9d939);
  final Color warning700 = const Color(0xfffbe474);
  final Color warning800 = const Color(0xfffdf0b0);
  final Color warning900 = const Color(0xfffefbeb);
}

class _SuccessColor {
  const _SuccessColor();
  final Color success100 = const Color(0xff112008);
  final Color success200 = const Color(0xff19310d);
  final Color success300 = const Color(0xff326119);
  final Color success400 = const Color(0xff4c9226);
  final Color success500 = const Color(0xff65c332);
  final Color success600 = const Color(0xff87d55d);
  final Color success700 = const Color(0xffabe28d);
  final Color success800 = const Color(0xffcfeebe);
  final Color success900 = const Color(0xfff3fbef);
}

class _ErrorColor {
  const _ErrorColor();
  final Color error100 = const Color(0xff290000);
  final Color error200 = const Color(0xff3d0000);
  final Color error300 = const Color(0xff7a0000);
  final Color error400 = const Color(0xffb80000);
  final Color error500 = const Color(0xfff50000);
  final Color error600 = const Color(0xffff3333);
  final Color error700 = const Color(0xffff7070);
  final Color error800 = const Color(0xffffadad);
  final Color error900 = const Color(0xffffebeb);
}

class _GrayscaleColor {
  const _GrayscaleColor();
  final Color grayscale100 = const Color(0xff08090d);
  final Color grayscale200 = const Color(0xff0f121a);
  final Color grayscale300 = const Color(0xff171b26);
  final Color grayscale400 = const Color(0xff1f2433);
  final Color grayscale500 = const Color(0xff262d40);
  final Color grayscale600 = const Color(0xff8c99ba);
  final Color grayscale700 = const Color(0xffa6b0c9);
  final Color grayscale800 = const Color(0xffbfc6d9);
  final Color grayscale900 = const Color(0xffd9dde8);
  final Color grayscale1000 = const Color(0xfff2f4f7);
}

class BuzzChatPaletteExtension
    extends ThemeExtension<BuzzChatPaletteExtension> {
  BuzzChatPaletteExtension(
      {required this.background,
      required this.foreground,
      required this.primary,
      required this.onPrimary,
      required this.container,
      required this.primaryInputBackground,
      required this.primaryInputForeground,
      required this.primaryInputHint,
      required this.primaryInputFocusedBackground,
      required this.error,
      required this.inputErrorHint,
      required this.primaryInputErrorBackground,
      required this.inputFocusedHint,
      required this.primaryButtonDisabledBackground,
      required this.containerVariant,
      required this.primaryVariant,
      required this.inverseContainer,
      required this.onError,
      required this.success,
      required this.onSuccess,
      required this.warning,
      required this.onWarning,
      required this.secondary,
      required this.onSecondary});
  final Color background;
  final Color foreground;
  final Color containerVariant;
  final Color primary;
  final Color onPrimary;
  final Color container;
  final Color primaryInputBackground;
  final Color primaryInputForeground;
  final Color primaryInputHint;
  final Color primaryInputFocusedBackground;
  final Color error;
  final Color onError;
  final Color inputErrorHint;
  final Color inputFocusedHint;
  final Color primaryButtonDisabledBackground;
  final Color primaryInputErrorBackground;
  final Color primaryVariant;
  final Color inverseContainer;
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color secondary;
  final Color onSecondary;
  final Color onWarning;

  @override
  ThemeExtension<BuzzChatPaletteExtension> copyWith(
      {Color? background,
      Color? foreground,
      Color? primaryVariant,
      Color? primaryInputFocusedBorder,
      Color? primary,
      Color? inverseContainer,
      Color? onPrimary,
      Color? containerVariant,
      Color? container,
      Color? primaryInputBackground,
      Color? primaryInputForeground,
      Color? primaryInputHint,
      Color? error,
      Color? onError,
      Color? inputErrorHint,
      Color? inputFocusedHint,
      Color? primaryInputErrorBackground,
      Color? primaryButtonDisabledBackground,
      Color? primaryInputFocusedBackground,
      Color? success,
      Color? onSuccess,
      Color? warning,
      Color? onWarning,
      Color? secondary,
      Color? onSecondary}) {
    return BuzzChatPaletteExtension(
        secondary: secondary ?? this.secondary,
        onSecondary: onSecondary ?? this.onSecondary,
        success: success ?? this.success,
        onSuccess: onSuccess ?? this.onSuccess,
        warning: warning ?? this.warning,
        onWarning: onWarning ?? this.onWarning,
        inverseContainer: inverseContainer ?? this.inverseContainer,
        primaryVariant: primaryVariant ?? this.primaryVariant,
        containerVariant: containerVariant ?? this.containerVariant,
        primaryInputErrorBackground:
            primaryInputErrorBackground ?? this.primaryInputErrorBackground,
        primaryButtonDisabledBackground: primaryButtonDisabledBackground ??
            this.primaryButtonDisabledBackground,
        error: error ?? this.error,
        inputErrorHint: inputErrorHint ?? this.inputErrorHint,
        inputFocusedHint: inputFocusedHint ?? this.inputFocusedHint,
        onError: onError ?? this.onError,
        primaryInputFocusedBackground:
            primaryInputFocusedBackground ?? this.primaryInputFocusedBackground,
        background: background ?? this.background,
        foreground: foreground ?? this.foreground,
        primary: primary ?? this.primary,
        onPrimary: onPrimary ?? this.onPrimary,
        container: container ?? this.container,
        primaryInputBackground:
            primaryInputBackground ?? this.primaryInputBackground,
        primaryInputForeground:
            primaryInputForeground ?? this.primaryInputForeground,
        primaryInputHint: primaryInputHint ?? this.primaryInputHint);
  }

  @override
  ThemeExtension<BuzzChatPaletteExtension> lerp(
      covariant ThemeExtension<BuzzChatPaletteExtension>? other, double t) {
    if (other is! BuzzChatPaletteExtension) {
      return this;
    }
    return BuzzChatPaletteExtension(
        secondary: Color.lerp(secondary, other.secondary, t)!,
        onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
        success: Color.lerp(success, other.success, t)!,
        onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
        warning: Color.lerp(warning, other.warning, t)!,
        onWarning: Color.lerp(onWarning, other.onWarning, t)!,
        inverseContainer:
            Color.lerp(inverseContainer, other.inverseContainer, t)!,
        primaryVariant: Color.lerp(primaryVariant, other.primaryVariant, t)!,
        containerVariant:
            Color.lerp(containerVariant, other.containerVariant, t)!,
        primaryInputErrorBackground: Color.lerp(
            primaryInputErrorBackground, other.primaryInputErrorBackground, t)!,
        primaryButtonDisabledBackground: Color.lerp(
            primaryButtonDisabledBackground,
            other.primaryButtonDisabledBackground,
            t)!,
        error: Color.lerp(error, other.error, t)!,
        inputErrorHint: Color.lerp(inputErrorHint, other.inputErrorHint, t)!,
        inputFocusedHint:
            Color.lerp(inputFocusedHint, other.inputFocusedHint, t)!,
        onError: Color.lerp(onError, other.onError, t)!,
        primaryInputFocusedBackground: Color.lerp(primaryInputFocusedBackground,
            other.primaryInputFocusedBackground, t)!,
        background: Color.lerp(background, other.background, t)!,
        foreground: Color.lerp(foreground, other.foreground, t)!,
        primary: Color.lerp(primary, other.primary, t)!,
        onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
        container: Color.lerp(container, other.container, t)!,
        primaryInputBackground: Color.lerp(
            primaryInputBackground, other.primaryInputBackground, t)!,
        primaryInputForeground: Color.lerp(
            primaryInputForeground, other.primaryInputForeground, t)!,
        primaryInputHint:
            Color.lerp(primaryInputHint, other.primaryInputHint, t)!);
  }
}

class BuzzChatTheme with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  static final lightPalette = BuzzChatPaletteExtension(
      secondary: BuzzChatPalette.secondary.secondary500,
      onSecondary: BuzzChatPalette.secondary.secondary900,
      warning: BuzzChatPalette.warning.warning500,
      onWarning: BuzzChatPalette.warning.warning900,
      success: BuzzChatPalette.success.success500,
      onSuccess: BuzzChatPalette.success.success900,
      inverseContainer: BuzzChatPalette.grayscale.grayscale800,
      primaryVariant: BuzzChatPalette.primary.primary400,
      containerVariant: BuzzChatPalette.grayscale.grayscale600,
      primaryButtonDisabledBackground: BuzzChatPalette.primary.primary700,
      inputErrorHint: BuzzChatPalette.error.error800,
      inputFocusedHint: BuzzChatPalette.primary.primary700,
      error: BuzzChatPalette.error.error500,
      onError: BuzzChatPalette.error.error900,
      primaryInputErrorBackground: BuzzChatPalette.error.error900,
      background: BuzzChatPalette.grayscale.grayscale1000,
      primaryInputFocusedBackground: BuzzChatPalette.primary.primary800,
      foreground: BuzzChatPalette.grayscale.grayscale100,
      primary: BuzzChatPalette.primary.primary500,
      onPrimary: BuzzChatPalette.primary.primary900,
      container: BuzzChatPalette.grayscale.grayscale900,
      primaryInputBackground: BuzzChatPalette.grayscale.grayscale900,
      primaryInputForeground: BuzzChatPalette.grayscale.grayscale100,
      primaryInputHint: BuzzChatPalette.grayscale.grayscale600);

  static final light = ThemeData.light().copyWith(extensions: [lightPalette]);
  static final darkPalette = BuzzChatPaletteExtension(
      secondary: BuzzChatPalette.secondary.secondary500,
      onSecondary: BuzzChatPalette.secondary.secondary900,
      warning: BuzzChatPalette.warning.warning500,
      onWarning: BuzzChatPalette.warning.warning900,
      success: BuzzChatPalette.success.success500,
      onSuccess: BuzzChatPalette.success.success900,
      inverseContainer: BuzzChatPalette.grayscale.grayscale500,
      primaryVariant: BuzzChatPalette.primary.primary400,
      containerVariant: BuzzChatPalette.grayscale.grayscale600,
      primaryButtonDisabledBackground: BuzzChatPalette.primary.primary700,
      inputErrorHint: BuzzChatPalette.error.error300,
      inputFocusedHint: BuzzChatPalette.primary.primary200,
      error: BuzzChatPalette.error.error500,
      onError: BuzzChatPalette.error.error900,
      background: BuzzChatPalette.grayscale.grayscale100,
      primaryInputFocusedBackground: BuzzChatPalette.primary.primary100,
      primaryInputErrorBackground: BuzzChatPalette.error.error100,
      foreground: BuzzChatPalette.grayscale.grayscale1000,
      primary: BuzzChatPalette.primary.primary500,
      onPrimary: BuzzChatPalette.primary.primary900,
      container: BuzzChatPalette.grayscale.grayscale200,
      primaryInputBackground: BuzzChatPalette.grayscale.grayscale200,
      primaryInputForeground: BuzzChatPalette.grayscale.grayscale1000,
      primaryInputHint: BuzzChatPalette.grayscale.grayscale500);

  static final dark = ThemeData.dark().copyWith(extensions: [darkPalette]);
}

extension AppThemeExtension on ThemeData {
  /// Usage example: Theme.of(context).appColors;
  BuzzChatPaletteExtension get palette =>
      extension<BuzzChatPaletteExtension>() ?? BuzzChatTheme.lightPalette;
}

extension ThemeGetter on BuildContext {
  // Usage example: `context.theme`
  ThemeData get theme => Theme.of(this);
}
