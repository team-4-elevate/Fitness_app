import 'dart:convert';
import 'dart:math';
import 'dart:math' as math;
import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/responsive/responsive_manager.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

/// =================== BUILD CONTEXT EXTENSIONS ===================
extension BuildContextExtensions on BuildContext {
  // =================== Screen & Responsive ===================
  // Screen dimensions
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
  Size get size => MediaQuery.sizeOf(this);
  double get statusBarHeight => MediaQuery.paddingOf(this).top;
  double get bottomBarHeight => MediaQuery.paddingOf(this).bottom;
  double get keyboardHeight => MediaQuery.viewInsetsOf(this).bottom;
  bool get isKeyboardOpen => keyboardHeight > 0;

  // Safe area
  EdgeInsets get padding => MediaQuery.paddingOf(this);
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);
  double get topPadding => MediaQuery.paddingOf(this).top;
  double get bottomPadding => MediaQuery.paddingOf(this).bottom;
  double get leftPadding => MediaQuery.paddingOf(this).left;
  double get rightPadding => MediaQuery.paddingOf(this).right;

  // Responsive manager
  ResponsiveManager get responsive => ResponsiveManager.instance;

  // Device type checks
  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1200;
  bool get isDesktop => width >= 1200;
  bool get isLandscape => width > height;
  bool get isPortrait => height > width;
  bool get isSmallScreen => height < 700;
  bool get isLargeScreen => height > 900;
  bool get isWatch => width < 300;
  bool get isIOS => Platform.isIOS;
  bool get isAndroid => Platform.isAndroid;
  bool get isWeb => identical(0, 0.0);

  // Responsive calculations
  double widthPercent(double percent) => width * percent;
  double heightPercent(double percent) => height * percent;
  double responsiveWidth(double value) => responsive.responsiveWidth(value);
  double responsiveHeight(double value) => responsive.responsiveHeight(value);

  // Adaptive value helper
  T adaptiveValue<T>({required T mobile, T? tablet, T? desktop}) => responsive
      .adaptiveValue(mobile: mobile, tablet: tablet, desktop: desktop);

  // =================== Theme ===================
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Brightness get brightness => Theme.of(this).brightness;
  bool get isDarkMode => brightness == Brightness.dark;
  bool get isLightMode => brightness == Brightness.light;

  // =================== Localization ===================
  AppLocalizations get l10n => AppLocalizations.of(this);
  AppLocalizations? get l10nOrNull => AppLocalizations.of(this);

  bool get isRTL => Localizations.localeOf(this).languageCode == 'ar';
  String get languageCode => Localizations.localeOf(this).languageCode;
  Locale get locale => Localizations.localeOf(this);
  bool get isArabic => languageCode == 'ar';
  bool get isEnglish => languageCode == 'en';
  TextDirection get textDirection =>
      isRTL ? TextDirection.RTL : TextDirection.LTR;

  // =================== Navigation ===================
  // Standard navigation with context
  void pushNamedWithArguments(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  void pushWidget(Widget page) {
    Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
  }

  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  void pushReplacementWidget(Widget page) {
    Navigator.of(this).pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  void pushReplacementNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }

  void pushNamedAndRemoveUntilWidget(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  void pushAndRemoveUntil(Widget page) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  void popUntil(RoutePredicate predicate) {
    Navigator.of(this).popUntil(predicate);
  }

  void popUntilFirst() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }

  bool canPop() {
    return Navigator.of(this).canPop();
  }

  Future<bool> maybePop<T>([T? result]) {
    return Navigator.of(this).maybePop(result);
  }

  // =================== UI Helpers ===================
  void showSnackBar(
    String message, {
    Color? backgroundColor,
    Duration? duration,
    SnackBarAction? action,
    double? width,
    ShapeBorder? shape,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor ?? AppColors.primaryOrange,
        duration: duration ?? const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape:
            shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        action: action,
        width: width,
        elevation: elevation,
        margin: margin,
        padding: padding,
      ),
    );
  }

  Future<void> showLoadingIndicator() async {
    await showDialog(
      barrierDismissible: false,
      context: this,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void showErrorSnackBar(String message) {
    showSnackBar(message, backgroundColor: AppColors.error);
  }

  void showSuccessSnackBar(String message) {
    showSnackBar(message, backgroundColor: AppColors.green);
  }

  void showWarningSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.amber);
  }

  void showInfoSnackBar(String message, {Color? backgroundColor}) {
    showSnackBar(
      message,
      backgroundColor: backgroundColor ?? AppColors.primaryBlue,
    );
  }

  void hideSnackBar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }

  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  void requestFocus(FocusNode node) {
    FocusScope.of(this).requestFocus(node);
  }

  void nextFocus() {
    FocusScope.of(this).nextFocus();
  }

  void previousFocus() {
    FocusScope.of(this).previousFocus();
  }

  // =================== Platform Helper ===================
  T platformValue<T>({required T ios, required T android, T? web}) {
    if (Platform.isIOS) return ios;
    if (Platform.isAndroid) return android;
    if (web != null && isWeb) return web;
    return android;
  }

  // =================== Modal Helpers ===================
  Future<T?> showCustomBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = true,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    Color? barrierColor,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape:
          shape ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
      clipBehavior: clipBehavior,
      barrierColor: barrierColor,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: (context) => child,
    );
  }

  Future<T?> showCustomDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useSafeArea = true,
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      builder: (context) => child,
    );
  }

  Future<DateTime?> showCustomDatePicker({
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
  }) {
    return showDatePicker(
      context: this,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDatePickerMode: initialDatePickerMode,
      initialEntryMode: initialEntryMode,
    );
  }

  Future<TimeOfDay?> showCustomTimePicker({
    required TimeOfDay initialTime,
    bool useRootNavigator = true,
    TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial,
  }) {
    return showTimePicker(
      context: this,
      initialTime: initialTime,
      useRootNavigator: useRootNavigator,
      initialEntryMode: initialEntryMode,
    );
  }
}

/// =================== WIDGET EXTENSIONS ===================
extension WidgetExtensions on Widget {
  // =================== Padding & Margin ===================
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value.r), child: this);

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal.r,
          vertical: vertical.r,
        ),
        child: this,
      );

  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left.r,
      top: top.r,
      right: right.r,
      bottom: bottom.r,
    ),
    child: this,
  );

  Widget paddingLTRB(double left, double top, double right, double bottom) =>
      Padding(
        padding: EdgeInsets.fromLTRB(left.r, top.r, right.r, bottom.r),
        child: this,
      );

  Widget marginAll(double value) =>
      Container(margin: EdgeInsets.all(value.r), child: this);

  Widget marginSymmetric({double horizontal = 0, double vertical = 0}) =>
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: horizontal.r,
          vertical: vertical.r,
        ),
        child: this,
      );

  Widget marginOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Container(
    margin: EdgeInsets.only(
      left: left.r,
      top: top.r,
      right: right.r,
      bottom: bottom.r,
    ),
    child: this,
  );

  Widget marginLTRB(double left, double top, double right, double bottom) =>
      Container(
        margin: EdgeInsets.fromLTRB(left.r, top.r, right.r, bottom.r),
        child: this,
      );

  // =================== Layout Helpers ===================
  Widget get center => Center(child: this);
  Widget get centerLeft => Align(alignment: Alignment.centerLeft, child: this);
  Widget get centerRight =>
      Align(alignment: Alignment.centerRight, child: this);
  Widget get topCenter => Align(alignment: Alignment.topCenter, child: this);
  Widget get bottomCenter =>
      Align(alignment: Alignment.bottomCenter, child: this);
  Widget get topLeft => Align(alignment: Alignment.topLeft, child: this);
  Widget get topRight => Align(alignment: Alignment.topRight, child: this);
  Widget get bottomLeft => Align(alignment: Alignment.bottomLeft, child: this);
  Widget get bottomRight =>
      Align(alignment: Alignment.bottomRight, child: this);

  Widget get expanded => Expanded(child: this);
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(flex: flex, fit: fit, child: this);

  Widget get safeArea => SafeArea(child: this);
  Widget safeAreaOnly({
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
  }) =>
      SafeArea(top: top, bottom: bottom, left: left, right: right, child: this);

  Widget get scrollable => SingleChildScrollView(child: this);
  Widget scrollableWithPhysics(ScrollPhysics physics) =>
      SingleChildScrollView(physics: physics, child: this);

  Widget get disableScroll => NotificationListener<ScrollNotification>(
    onNotification: (_) => true,
    child: this,
  );

  Widget get intrinsicHeight => IntrinsicHeight(child: this);
  Widget get intrinsicWidth => IntrinsicWidth(child: this);
  Widget aspectRatio(double ratio) =>
      AspectRatio(aspectRatio: ratio, child: this);
  Widget align(Alignment alignment) => Align(alignment: alignment, child: this);
  Widget get sizedBox250 => SizedBox(height: 250, child: this);
  Widget constrainedBox({double? maxWidth, double? maxHeight}) =>
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? double.infinity,
          maxHeight: maxHeight ?? double.infinity,
        ),
        child: this,
      );

  // =================== Styling ===================
  Widget borderRadius(double radius) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius.r), child: this);

  Widget roundedTop(double radius) => ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(radius.r),
      topRight: Radius.circular(radius.r),
    ),
    child: this,
  );

  Widget roundedBottom(double radius) => ClipRRect(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(radius.r),
      bottomRight: Radius.circular(radius.r),
    ),
    child: this,
  );

  Widget roundedLeft(double radius) => ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(radius.r),
      bottomLeft: Radius.circular(radius.r),
    ),
    child: this,
  );

  Widget roundedRight(double radius) => ClipRRect(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(radius.r),
      bottomRight: Radius.circular(radius.r),
    ),
    child: this,
  );

  Widget roundedCustom({
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) => ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(topLeft.r),
      topRight: Radius.circular(topRight.r),
      bottomLeft: Radius.circular(bottomLeft.r),
      bottomRight: Radius.circular(bottomRight.r),
    ),
    child: this,
  );

  Widget rounded(double radius) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius.r), child: this);

  Widget get circular => ClipOval(child: this);

  Widget shadow({
    Color color = Colors.black26,
    double blurRadius = 4,
    Offset offset = const Offset(0, 2),
    double spreadRadius = 0,
  }) => Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: color,
          blurRadius: blurRadius,
          offset: offset,
          spreadRadius: spreadRadius,
        ),
      ],
    ),
    child: this,
  );

  Widget elevation(double elevation) =>
      Material(elevation: elevation, child: this);

  // =================== Animation & Effects ===================
  Widget fadeIn({Duration duration = const Duration(milliseconds: 300)}) =>
      AnimatedOpacity(opacity: 1.0, duration: duration, child: this);

  Widget fadeInOut(
    bool isVisible, {
    Duration duration = const Duration(milliseconds: 300),
  }) => AnimatedOpacity(
    opacity: isVisible ? 1.0 : 0.0,
    duration: duration,
    child: this,
  );

  Widget scale(double scale) => Transform.scale(scale: scale, child: this);

  Widget rotate(double angle) => Transform.rotate(angle: angle, child: this);

  Widget translate({double x = 0, double y = 0}) =>
      Transform.translate(offset: Offset(x, y), child: this);

  Widget opacity(double opacity) => Opacity(opacity: opacity, child: this);

  // =================== Interaction ===================
  Widget onTap(VoidCallback onTap) =>
      GestureDetector(onTap: onTap, child: this);

  Widget onDoubleTap(VoidCallback onDoubleTap) =>
      GestureDetector(onDoubleTap: onDoubleTap, child: this);

  Widget onLongPress(VoidCallback onLongPress) =>
      GestureDetector(onLongPress: onLongPress, child: this);

  Widget onTapDown(Function(TapDownDetails) onTapDown) =>
      GestureDetector(onTapDown: onTapDown, child: this);

  Widget tooltip(String message) => Tooltip(message: message, child: this);

  Widget hero(String tag) => Hero(tag: tag, child: this);

  Widget visible(bool isVisible) => Visibility(visible: isVisible, child: this);

  Widget visibleWithReplacement(
    bool isVisible, {
    Widget replacement = const SizedBox(),
  }) => Visibility(visible: isVisible, replacement: replacement, child: this);

  // =================== Layout & Positioning ===================
  Widget fitted({BoxFit fit = BoxFit.contain}) =>
      FittedBox(fit: fit, child: this);

  Widget positioned({
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) => Positioned(
    left: left?.r,
    top: top?.r,
    right: right?.r,
    bottom: bottom?.r,
    width: width?.r,
    height: height?.r,
    child: this,
  );

  // =================== Decoration ===================
  Widget decorated({
    Color? color,
    double? borderRadius,
    List<BoxShadow>? boxShadow,
    Border? border,
    BorderRadius? customBorderRadius,
    Gradient? gradient,
    DecorationImage? image,
  }) => Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius:
          borderRadius != null
              ? BorderRadius.circular(borderRadius.r)
              : customBorderRadius,
      boxShadow: boxShadow,
      border: border,
      gradient: gradient,
      image: image,
    ),
    child: this,
  );

  // =================== Special Effects ===================
  Widget blur({
    double sigma = 10,
    bool enabled = true,
    TileMode tileMode = TileMode.clamp,
  }) =>
      enabled
          ? ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: sigma,
              sigmaY: sigma,
              tileMode: tileMode,
            ),
            child: this,
          )
          : this;

  Widget blurBackground({double sigma = 10, Color? color}) => ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: Container(
        color: color ?? Colors.black.withOpacity(0.1),
        child: this,
      ),
    ),
  );

  // =================== Theming ===================
  Widget withTheme(ThemeData theme) => Theme(data: theme, child: this);

  // =================== System UI ===================
  Widget withSystemUI({
    SystemUiOverlayStyle? style,
    Color? statusBarColor,
    Brightness? statusBarIconBrightness,
    Color? systemNavigationBarColor,
    Brightness? systemNavigationBarIconBrightness,
  }) => AnnotatedRegion<SystemUiOverlayStyle>(
    value:
        style ??
        SystemUiOverlayStyle(
          statusBarColor: statusBarColor ?? Colors.transparent,
          statusBarIconBrightness: statusBarIconBrightness,
          systemNavigationBarColor: systemNavigationBarColor,
          systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
        ),
    child: this,
  );
}

/// =================== NUMERIC EXTENSIONS ===================
extension ResponsiveNum on num {
  /// Responsive width - automatically uses global ResponsiveManager
  double get w => ResponsiveManager.instance.responsiveWidth(toDouble());

  /// Responsive height - automatically uses global ResponsiveManager
  double get h => ResponsiveManager.instance.responsiveHeight(toDouble());

  /// Responsive size (same as width) - for padding, margins, etc.
  double get r => ResponsiveManager.instance.responsiveWidth(toDouble());

  /// Responsive font size
  double get sp => ResponsiveManager.instance.responsiveWidth(toDouble());

  /// Convert days to Duration
  Duration get days => Duration(days: toInt());

  /// Convert hours to Duration
  Duration get hours => Duration(hours: toInt());

  /// Convert minutes to Duration
  Duration get minutes => Duration(minutes: toInt());

  /// Convert seconds to Duration
  Duration get seconds => Duration(seconds: toInt());

  /// Convert milliseconds to Duration
  Duration get milliseconds => Duration(milliseconds: toInt());

  /// Convert microseconds to Duration
  Duration get microseconds => Duration(microseconds: toInt());

  /// Convert to radians
  double get radians => (this * pi) / 180;

  /// Convert to degrees
  double get degrees => (this * 180) / pi;

  /// Check if value is between range (inclusive)
  bool isBetween(num min, num max) => this >= min && this <= max;

  /// Clamp value between min and max
  num clamp(num min, num max) => this < min ? min : (this > max ? max : this);

  /// Map value from one range to another
  double mapRange(num inMin, num inMax, num outMin, num outMax) {
    return (((this - inMin) * (outMax - outMin)) / (inMax - inMin)) + outMin;
  }
}

/// =================== STRING EXTENSIONS ===================
extension StringExtensions on String {
  /// Capitalize first letter
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Convert to Title Case (capitalize each word)
  String get titleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Check if string is empty or consists only of whitespace
  bool get isBlank => trim().isEmpty;

  /// Check if string is not empty and not just whitespace
  bool get isNotBlank => !isBlank;

  /// Check if string is email
  bool get isEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  /// Check if string is phone number
  bool get isPhoneNumber {
    return RegExp(r'^\+?[\d\s\-\(\)]{10,}$').hasMatch(this);
  }

  /// Check if string is strong password
  bool get isStrongPassword {
    return RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    ).hasMatch(this);
  }

  /// Check if string is URL
  bool get isUrl {
    return RegExp(
      r'^(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    ).hasMatch(this);
  }

  /// Check if string is numeric
  bool get isNumeric {
    return RegExp(r'^\d+$').hasMatch(this);
  }

  /// Check if string is hex color
  bool get isHexColor {
    return RegExp(
      r'^#?([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$',
    ).hasMatch(this);
  }

  /// Check if string is JSON
  bool get isJson {
    try {
      json.decode(this);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Convert to int if possible
  int? toIntOrNull() {
    try {
      return int.parse(this);
    } catch (_) {
      return null;
    }
  }

  /// Convert to double if possible
  double? toDoubleOrNull() {
    try {
      return double.parse(this);
    } catch (_) {
      return null;
    }
  }

  /// Convert hex color string to Color
  Color? toColor() {
    if (!isHexColor) return null;

    String hex = replaceAll('#', '');
    if (hex.length == 3) {
      hex = '${hex[0]}${hex[0]}${hex[1]}${hex[1]}${hex[2]}${hex[2]}';
    }

    int? value = int.tryParse('0xFF$hex');
    return value != null ? Color(value) : null;
  }

  /// Remove all whitespace
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Remove all special characters
  String get removeSpecialCharacters => replaceAll(RegExp(r'[^\w\s]+'), '');

  /// Mask string (e.g. for credit card)
  String mask({int visibleChars = 4, String maskChar = '*'}) {
    if (length <= visibleChars) return this;
    return '${maskChar * (length - visibleChars)}${substring(length - visibleChars)}';
  }

  /// Add ellipsis if string exceeds max length
  String ellipsis(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }

  /// Extract digits only
  String get extractDigits => replaceAll(RegExp(r'[^\d]'), '');

  /// Extract letters only
  String get extractLetters => replaceAll(RegExp(r'[^a-zA-Z]'), '');

  /// Format as phone number
  String formatPhoneNumber({String separator = '-'}) {
    final digits = extractDigits;
    if (digits.length < 10) return this;

    return '${digits.substring(0, 3)}$separator${digits.substring(3, 6)}$separator${digits.substring(6)}';
  }
}

/// =================== LIST EXTENSIONS ===================
extension ListExtensions<T> on List<T> {
  /// Get random item from list
  T get random => this[_getRandomIndex()];

  int _getRandomIndex() => (math.Random().nextDouble() * length).floor();

  /// Get list with unique items
  List<T> get unique => toSet().toList();

  /// Sort list with a custom key
  List<T> sortedBy<K extends Comparable>(K Function(T) keyOf) {
    final copy = [...this];
    copy.sort((a, b) => keyOf(a).compareTo(keyOf(b)));
    return copy;
  }

  /// Group list by key
  Map<K, List<T>> groupBy<K>(K Function(T) keyOf) {
    return fold<Map<K, List<T>>>({}, (map, element) {
      final key = keyOf(element);
      if (!map.containsKey(key)) map[key] = [];
      map[key]!.add(element);
      return map;
    });
  }

  /// Get item at index safely (returns null if index out of bounds)
  T? getOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// Split list into chunks of given size
  List<List<T>> chunked(int size) {
    if (size <= 0) return [this];

    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }

  /// Split list into specified number of parts
  List<List<T>> splitIntoParts(int parts) {
    if (parts <= 0) return [this];
    if (parts > length) parts = length;

    final result = <List<T>>[];
    final itemsPerPart = (length / parts).ceil();

    for (var i = 0; i < parts; i++) {
      final start = i * itemsPerPart;
      final end = start + itemsPerPart > length ? length : start + itemsPerPart;
      if (start < length) {
        result.add(sublist(start, end));
      }
    }

    return result;
  }

  /// Shuffle list and return new shuffled list
  List<T> get shuffled {
    final copy = [...this];
    copy.shuffle();
    return copy;
  }

  /// Add item to list if condition is true
  List<T> addIf(bool condition, T item) {
    if (condition) add(item);
    return this;
  }

  /// Add all items to list if condition is true
  List<T> addAllIf(bool condition, List<T> items) {
    if (condition) addAll(items);
    return this;
  }
}

/// =================== MAP EXTENSIONS ===================
extension MapExtensions<K, V> on Map<K, V> {
  /// Check if map contains all keys
  bool containsAllKeys(List<K> keys) => keys.every(containsKey);

  /// Check if map contains any of the keys
  bool containsAnyKey(List<K> keys) => keys.any(containsKey);

  /// Get value or null if key doesn't exist
  V? getOrNull(K key) => containsKey(key) ? this[key] : null;

  /// Get value or default if key doesn't exist
  V getOrDefault(K key, V defaultValue) =>
      containsKey(key) ? this[key]! : defaultValue;

  /// Filter map by keys
  Map<K, V> filterKeys(bool Function(K key) predicate) {
    return Map.fromEntries(entries.where((entry) => predicate(entry.key)));
  }

  /// Filter map by values
  Map<K, V> filterValues(bool Function(V value) predicate) {
    return Map.fromEntries(entries.where((entry) => predicate(entry.value)));
  }

  /// Map keys to new map
  Map<R, V> mapKeys<R>(R Function(K key) transform) {
    return Map.fromEntries(
      entries.map((entry) => MapEntry(transform(entry.key), entry.value)),
    );
  }

  /// Map values to new map
  Map<K, R> mapValues<R>(R Function(V value) transform) {
    return Map.fromEntries(
      entries.map((entry) => MapEntry(entry.key, transform(entry.value))),
    );
  }
}

/// =================== DATETIME EXTENSIONS ===================
extension DateTimeExtensions on DateTime {
  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Get difference in days
  int getDifferenceInDays(DateTime other) {
    final date1 = DateTime(year, month, day);
    final date2 = DateTime(other.year, other.month, other.day);
    return date1.difference(date2).inDays.abs();
  }

  /// Format date to string (e.g. "2023-04-01")
  String format({String pattern = 'yyyy-MM-dd'}) {
    return DateFormat(pattern).format(this);
  }

  /// Format date with localization
  String formatLocalized(
    BuildContext context, {
    String pattern = 'yyyy-MM-dd',
  }) {
    final locale = Localizations.localeOf(context);
    return DateFormat(pattern, locale.languageCode).format(this);
  }

  /// Get start of day (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  /// Get end of day (23:59:59.999)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Get start of week (Monday)
  DateTime get startOfWeek {
    final weekday = this.weekday;
    return subtract(Duration(days: weekday - 1));
  }

  /// Get end of week (Sunday)
  DateTime get endOfWeek {
    final weekday = this.weekday;
    return add(Duration(days: 7 - weekday)).endOfDay;
  }

  /// Get start of month
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Get end of month
  DateTime get endOfMonth => DateTime(year, month + 1, 0).endOfDay;

  /// Add days
  DateTime addDays(int days) => add(Duration(days: days));

  /// Subtract days
  DateTime subtractDays(int days) => subtract(Duration(days: days));

  /// Add months
  DateTime addMonths(int months) {
    final newMonth = month + months;
    final newYear = year + (newMonth - 1) ~/ 12;
    final adjustedMonth = ((newMonth - 1) % 12) + 1;

    // Handle day overflow (e.g. Jan 31 + 1 month should be Feb 28/29)
    final lastDayOfMonth = DateTime(newYear, adjustedMonth + 1, 0).day;
    final adjustedDay = day > lastDayOfMonth ? lastDayOfMonth : day;

    return DateTime(
      newYear,
      adjustedMonth,
      adjustedDay,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  /// Subtract months
  DateTime subtractMonths(int months) => addMonths(-months);

  /// Add years
  DateTime addYears(int years) => DateTime(
    year + years,
    month,
    day,
    hour,
    minute,
    second,
    millisecond,
    microsecond,
  );

  /// Subtract years
  DateTime subtractYears(int years) => addYears(-years);

  /// Check if date is between start and end (inclusive)
  bool isBetween(DateTime start, DateTime end) {
    return (isAtSameMomentAs(start) || isAfter(start)) &&
        (isAtSameMomentAs(end) || isBefore(end));
  }

  /// Get age from birthdate
  int getAge() {
    final today = DateTime.now();
    int age = today.year - year;
    if (today.month < month || (today.month == month && today.day < day)) {
      age--;
    }
    return age;
  }

  /// Get relative time (e.g. "2 hours ago", "in 3 days")
  String getRelativeTime() {
    final now = DateTime.now();
    final difference = now.difference(this);

    // Past dates
    if (difference.isNegative) {
      final positiveDiff = difference.abs();
      if (positiveDiff.inDays > 365) {
        return 'in ${(positiveDiff.inDays / 365).floor()} years';
      }
      if (positiveDiff.inDays > 30) {
        return 'in ${(positiveDiff.inDays / 30).floor()} months';
      }
      if (positiveDiff.inDays > 7) {
        return 'in ${(positiveDiff.inDays / 7).floor()} weeks';
      }
      if (positiveDiff.inDays > 0) return 'in ${positiveDiff.inDays} days';
      if (positiveDiff.inHours > 0) return 'in ${positiveDiff.inHours} hours';
      if (positiveDiff.inMinutes > 0) {
        return 'in ${positiveDiff.inMinutes} minutes';
      }
      return 'just now';
    }

    // Past dates
    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    }
    if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    }
    if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    }
    if (difference.inDays > 0) return '${difference.inDays} days ago';
    if (difference.inHours > 0) return '${difference.inHours} hours ago';
    if (difference.inMinutes > 0) return '${difference.inMinutes} minutes ago';
    return 'just now';
  }
}

/// =================== SCROLL CONTROLLER EXTENSIONS ===================
extension ScrollControllerExtensions on ScrollController {
  /// Scroll to top
  void scrollToTop() {
    animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  /// Scroll to bottom
  void scrollToBottom() {
    animateTo(
      position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  /// Check if scroll is at top
  bool get isAtTop => position.pixels == 0;

  /// Check if scroll is at bottom
  bool get isAtBottom => position.pixels >= position.maxScrollExtent - 50;

  /// Add listener for scroll direction
  void onScrollDirection({
    VoidCallback? onScrollUp,
    VoidCallback? onScrollDown,
  }) {
    double lastPosition = 0.0;
    addListener(() {
      if (position.pixels < lastPosition && onScrollUp != null) {
        onScrollUp();
      } else if (position.pixels > lastPosition && onScrollDown != null) {
        onScrollDown();
      }
      lastPosition = position.pixels;
    });
  }
}
