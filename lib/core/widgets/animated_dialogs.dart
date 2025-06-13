/// Animated Dialogs with Lottie animations for Fitness App
///
/// Provides beautiful success and failure dialogs with:
/// - Lottie animations with completion callbacks
/// - Optional button functionality
/// - Responsive design integration
/// - Customizable content and actions
/// - BuildContext extensions for easy usage
/// - Full customization of colors, sizes, animations, and styling

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../responsive/responsive.dart';
import '../theme/app_colors.dart';

/// Callback function type for animation completion
typedef AnimationCallback = void Function();

/// Callback function type for button actions
typedef ButtonCallback = void Function();

/// Dialog size presets
enum DialogSize { small, medium, large, custom }

/// Animation style presets
enum AnimationStyle { elastic, bounce, fade, scale, slide }

/// Customization class for dialog appearance
class DialogCustomization {
  final Color? backgroundColor;
  final Color? primaryColor;
  final Color? buttonColor;
  final Color? titleColor;
  final Color? messageColor;
  final Color? barrierColor;

  final double? borderRadius;
  final double? elevation;
  final List<BoxShadow>? customShadows;

  final double? titleFontSize;
  final double? messageFontSize;
  final FontWeight? titleFontWeight;
  final FontWeight? messageFontWeight;
  final String? fontFamily;

  final double? animationSize;
  final EdgeInsets? contentPadding;
  final EdgeInsets? buttonPadding;
  final EdgeInsets? dialogMargin;

  final double? buttonHeight;
  final double? buttonBorderRadius;
  final Color? buttonTextColor;
  final double? buttonFontSize;

  final Duration? animationDuration;
  final Duration? fadeAnimationDuration;
  final Curve? animationCurve;
  final Curve? fadeAnimationCurve;

  final DialogSize dialogSize;
  final AnimationStyle animationStyle;
  final Size? customSize;

  final bool enableHapticFeedback;
  final bool enableSoundEffects;
  final int? maxTitleLines;
  final int? maxMessageLines;
  final TextOverflow? textOverflow;

  const DialogCustomization({
    // Colors
    this.backgroundColor,
    this.primaryColor,
    this.buttonColor,
    this.titleColor,
    this.messageColor,
    this.barrierColor,

    // Shape & Shadow
    this.borderRadius,
    this.elevation,
    this.customShadows,

    // Typography
    this.titleFontSize,
    this.messageFontSize,
    this.titleFontWeight,
    this.messageFontWeight,
    this.fontFamily,

    // Layout
    this.animationSize,
    this.contentPadding,
    this.buttonPadding,
    this.dialogMargin,

    // Button
    this.buttonHeight,
    this.buttonBorderRadius,
    this.buttonTextColor,
    this.buttonFontSize,

    // Animation
    this.animationDuration,
    this.fadeAnimationDuration,
    this.animationCurve,
    this.fadeAnimationCurve,

    // Presets
    this.dialogSize = DialogSize.medium,
    this.animationStyle = AnimationStyle.elastic,
    this.customSize,

    // Behavior
    this.enableHapticFeedback = true,
    this.enableSoundEffects = false,
    this.maxTitleLines,
    this.maxMessageLines,
    this.textOverflow,
  });

  /// Create a copy with modified values
  DialogCustomization copyWith({
    Color? backgroundColor,
    Color? primaryColor,
    Color? buttonColor,
    Color? titleColor,
    Color? messageColor,
    Color? barrierColor,
    double? borderRadius,
    double? elevation,
    List<BoxShadow>? customShadows,
    double? titleFontSize,
    double? messageFontSize,
    FontWeight? titleFontWeight,
    FontWeight? messageFontWeight,
    String? fontFamily,
    double? animationSize,
    EdgeInsets? contentPadding,
    EdgeInsets? buttonPadding,
    EdgeInsets? dialogMargin,
    double? buttonHeight,
    double? buttonBorderRadius,
    Color? buttonTextColor,
    double? buttonFontSize,
    Duration? animationDuration,
    Duration? fadeAnimationDuration,
    Curve? animationCurve,
    Curve? fadeAnimationCurve,
    DialogSize? dialogSize,
    AnimationStyle? animationStyle,
    Size? customSize,
    bool? enableHapticFeedback,
    bool? enableSoundEffects,
    int? maxTitleLines,
    int? maxMessageLines,
    TextOverflow? textOverflow,
  }) {
    return DialogCustomization(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      primaryColor: primaryColor ?? this.primaryColor,
      buttonColor: buttonColor ?? this.buttonColor,
      titleColor: titleColor ?? this.titleColor,
      messageColor: messageColor ?? this.messageColor,
      barrierColor: barrierColor ?? this.barrierColor,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      customShadows: customShadows ?? this.customShadows,
      titleFontSize: titleFontSize ?? this.titleFontSize,
      messageFontSize: messageFontSize ?? this.messageFontSize,
      titleFontWeight: titleFontWeight ?? this.titleFontWeight,
      messageFontWeight: messageFontWeight ?? this.messageFontWeight,
      fontFamily: fontFamily ?? this.fontFamily,
      animationSize: animationSize ?? this.animationSize,
      contentPadding: contentPadding ?? this.contentPadding,
      buttonPadding: buttonPadding ?? this.buttonPadding,
      dialogMargin: dialogMargin ?? this.dialogMargin,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      buttonBorderRadius: buttonBorderRadius ?? this.buttonBorderRadius,
      buttonTextColor: buttonTextColor ?? this.buttonTextColor,
      buttonFontSize: buttonFontSize ?? this.buttonFontSize,
      animationDuration: animationDuration ?? this.animationDuration,
      fadeAnimationDuration:
          fadeAnimationDuration ?? this.fadeAnimationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      fadeAnimationCurve: fadeAnimationCurve ?? this.fadeAnimationCurve,
      dialogSize: dialogSize ?? this.dialogSize,
      animationStyle: animationStyle ?? this.animationStyle,
      customSize: customSize ?? this.customSize,
      enableHapticFeedback: enableHapticFeedback ?? this.enableHapticFeedback,
      enableSoundEffects: enableSoundEffects ?? this.enableSoundEffects,
      maxTitleLines: maxTitleLines ?? this.maxTitleLines,
      maxMessageLines: maxMessageLines ?? this.maxMessageLines,
      textOverflow: textOverflow ?? this.textOverflow,
    );
  }

  /// Predefined customization presets
  static const DialogCustomization success = DialogCustomization(
    primaryColor: AppColors.green,
    buttonColor: AppColors.green,
    dialogSize: DialogSize.medium,
    animationStyle: AnimationStyle.elastic,
  );

  static const DialogCustomization failure = DialogCustomization(
    primaryColor: AppColors.red,
    buttonColor: AppColors.red,
    dialogSize: DialogSize.medium,
    animationStyle: AnimationStyle.bounce,
  );

  static const DialogCustomization warning = DialogCustomization(
    primaryColor: AppColors.primaryOrange,
    buttonColor: AppColors.primaryOrange,
    dialogSize: DialogSize.medium,
    animationStyle: AnimationStyle.bounce,
  );

  static const DialogCustomization info = DialogCustomization(
    primaryColor: AppColors.primaryBlue,
    buttonColor: AppColors.primaryBlue,
    dialogSize: DialogSize.medium,
    animationStyle: AnimationStyle.fade,
  );

  static const DialogCustomization compact = DialogCustomization(
    dialogSize: DialogSize.small,
    animationStyle: AnimationStyle.scale,
    titleFontSize: 14,
    messageFontSize: 12,
    animationSize: 60,
  );

  static const DialogCustomization large = DialogCustomization(
    dialogSize: DialogSize.large,
    animationStyle: AnimationStyle.elastic,
    titleFontSize: 24,
    messageFontSize: 16,
    animationSize: 160,
  );
}

/// Base animated dialog class with full customization
abstract class BaseAnimatedDialog extends StatefulWidget {
  const BaseAnimatedDialog({
    super.key,
    required this.title,
    this.message,
    required this.animationPath,
    this.showButton = false,
    this.buttonText,
    this.onButtonPressed,
    this.onAnimationComplete,
    this.autoDismiss = true,
    this.dismissDelay = const Duration(seconds: 2),
    this.barrierDismissible = true,
    this.customization = const DialogCustomization(),
    this.lottieRepeat = false,
    this.lottieReverse = false,
    this.customWidget,
    this.secondaryButton = false,
    this.secondaryButtonText,
    this.onSecondaryButtonPressed,
  });

  final String title;
  final String? message;
  final String animationPath;
  final bool showButton;
  final String? buttonText;
  final ButtonCallback? onButtonPressed;
  final AnimationCallback? onAnimationComplete;
  final bool autoDismiss;
  final Duration dismissDelay;
  final bool barrierDismissible;
  final DialogCustomization customization;
  final bool lottieRepeat;
  final bool lottieReverse;
  final Widget? customWidget;
  final bool secondaryButton;
  final String? secondaryButtonText;
  final ButtonCallback? onSecondaryButtonPressed;
}

abstract class BaseAnimatedDialogState<T extends BaseAnimatedDialog>
    extends State<T>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startEntryAnimation();

    if (widget.autoDismiss && !widget.showButton) {
      _scheduleAutoDismiss();
    }
  }

  void _initializeAnimations() {
    _scaleController = AnimationController(
      duration:
          widget.customization.animationDuration ??
          const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration:
          widget.customization.fadeAnimationDuration ??
          const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: _getAnimationCurve(),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: widget.customization.fadeAnimationCurve ?? Curves.easeInOut,
    );
  }

  Curve _getAnimationCurve() {
    if (widget.customization.animationCurve != null) {
      return widget.customization.animationCurve!;
    }

    switch (widget.customization.animationStyle) {
      case AnimationStyle.elastic:
        return Curves.elasticOut;
      case AnimationStyle.bounce:
        return Curves.bounceOut;
      case AnimationStyle.fade:
        return Curves.easeInOut;
      case AnimationStyle.scale:
        return Curves.fastOutSlowIn;
      case AnimationStyle.slide:
        return Curves.easeOutCubic;
    }
  }

  void _startEntryAnimation() {
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _scaleController.forward();
    });
  }

  void _scheduleAutoDismiss() {
    Future.delayed(widget.dismissDelay, () {
      if (mounted) {
        _dismissDialog();
      }
    });
  }

  void _dismissDialog() {
    _scaleController.reverse().then((_) {
      _fadeController.reverse().then((_) {
        if (mounted) Navigator.of(context).pop();
      });
    });
  }

  void _onButtonPressed() {
    if (widget.customization.enableHapticFeedback) {
      // Add haptic feedback if available
    }
    widget.onButtonPressed?.call();
    if (widget.onButtonPressed == null) {
      _dismissDialog();
    }
  }

  void _onSecondaryButtonPressed() {
    if (widget.customization.enableHapticFeedback) {
      // Add haptic feedback if available
    }
    widget.onSecondaryButtonPressed?.call();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  /// Abstract method to get dialog-specific colors
  Color get primaryColor;
  Color get backgroundColor;
  Color get buttonColor;

  /// Get dialog size based on customization
  Size _getDialogSize() {
    if (widget.customization.customSize != null) {
      return widget.customization.customSize!;
    }

    switch (widget.customization.dialogSize) {
      case DialogSize.small:
        return Size(
          R.adaptive(mobile: 240, tablet: 280, desktop: 320),
          R.adaptive(mobile: 240, tablet: 280, desktop: 320),
        );
      case DialogSize.medium:
        return Size(
          R.adaptive(mobile: 280, tablet: 350, desktop: 400),
          R.adaptive(mobile: 280, tablet: 350, desktop: 400),
        );
      case DialogSize.large:
        return Size(
          R.adaptive(mobile: 320, tablet: 400, desktop: 480),
          R.adaptive(mobile: 320, tablet: 400, desktop: 480),
        );
      case DialogSize.custom:
        return Size(
          R.adaptive(mobile: 280, tablet: 350, desktop: 400),
          R.adaptive(mobile: 280, tablet: 350, desktop: 400),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dialogSize = _getDialogSize();
    final customization = widget.customization;

    return Material(
      type: MaterialType.transparency,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              margin:
                  customization.dialogMargin ??
                  EdgeInsets.symmetric(horizontal: R.space24),
              width: dialogSize.width,
              height: dialogSize.height,
              decoration: BoxDecoration(
                color: customization.backgroundColor ?? backgroundColor,
                borderRadius: BorderRadius.circular(
                  customization.borderRadius ?? R.borderLGValue,
                ),
                boxShadow:
                    customization.customShadows ??
                    [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                      BoxShadow(
                        color: (customization.primaryColor ?? primaryColor)
                            .withOpacity(0.1),
                        blurRadius: 40,
                        offset: const Offset(0, 0),
                      ),
                    ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAnimationSection(),
                  _buildContentSection(),
                  if (widget.customWidget != null) widget.customWidget!,
                  if (widget.showButton || widget.secondaryButton)
                    _buildButtonSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimationSection() {
    final customization = widget.customization;
    final animationSize =
        customization.animationSize ??
        R.adaptive(mobile: 100, tablet: 120, desktop: 140);

    return SizedBox(
      width: animationSize,
      height: animationSize,
      child: Lottie.asset(
        widget.animationPath,
        fit: BoxFit.contain,
        repeat: widget.lottieRepeat,
        reverse: widget.lottieReverse,
        onLoaded: (composition) {
          Future.delayed(composition.duration, () {
            if (mounted) {
              widget.onAnimationComplete?.call();
            }
          });
        },
        frameRate: FrameRate.max,
      ),
    );
  }

  Widget _buildContentSection() {
    final customization = widget.customization;

    return Padding(
      padding:
          customization.contentPadding ??
          EdgeInsets.symmetric(horizontal: R.space20, vertical: R.space12),
      child: Column(
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: customization.titleFontSize ?? R.textLG,
              fontWeight: customization.titleFontWeight ?? FontWeight.bold,
              color:
                  customization.titleColor ??
                  customization.primaryColor ??
                  primaryColor,
              height: 1.3,
              fontFamily: customization.fontFamily,
            ),
            textAlign: TextAlign.center,
            maxLines: customization.maxTitleLines,
            overflow: customization.textOverflow ?? TextOverflow.ellipsis,
          ),
          if (widget.message != null) ...[
            SizedBox(height: R.space8),
            Text(
              widget.message!,
              style: TextStyle(
                fontSize: customization.messageFontSize ?? R.textSM,
                fontWeight:
                    customization.messageFontWeight ?? FontWeight.normal,
                color: customization.messageColor ?? AppColors.gray,
                height: 1.4,
                fontFamily: customization.fontFamily,
              ),
              textAlign: TextAlign.center,
              maxLines: customization.maxMessageLines ?? 2,
              overflow: customization.textOverflow ?? TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildButtonSection() {
    final customization = widget.customization;

    if (widget.secondaryButton) {
      return Padding(
        padding:
            customization.buttonPadding ??
            EdgeInsets.symmetric(horizontal: R.space20),
        child: Row(
          children: [
            // Secondary button
            Expanded(
              child: SizedBox(
                height: customization.buttonHeight ?? R.buttonHeight,
                child: OutlinedButton(
                  onPressed: _onSecondaryButtonPressed,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: customization.buttonColor ?? buttonColor,
                    side: BorderSide(
                      color: customization.buttonColor ?? buttonColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        customization.buttonBorderRadius ?? R.borderBaseValue,
                      ),
                    ),
                  ),
                  child: Text(
                    widget.secondaryButtonText ?? 'Cancel',
                    style: TextStyle(
                      fontSize: customization.buttonFontSize ?? R.textMD,
                      fontWeight: FontWeight.w600,
                      fontFamily: customization.fontFamily,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: R.space12),
            // Primary button
            Expanded(
              child: SizedBox(
                height: customization.buttonHeight ?? R.buttonHeight,
                child: ElevatedButton(
                  onPressed: _onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customization.buttonColor ?? buttonColor,
                    foregroundColor:
                        customization.buttonTextColor ?? Colors.white,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        customization.buttonBorderRadius ?? R.borderBaseValue,
                      ),
                    ),
                  ),
                  child: Text(
                    widget.buttonText ?? 'OK',
                    style: TextStyle(
                      fontSize: customization.buttonFontSize ?? R.textMD,
                      fontWeight: FontWeight.w600,
                      fontFamily: customization.fontFamily,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Single button
    return Padding(
      padding:
          customization.buttonPadding ??
          EdgeInsets.symmetric(horizontal: R.space20),
      child: SizedBox(
        width: double.infinity,
        height: customization.buttonHeight ?? R.buttonHeight,
        child: ElevatedButton(
          onPressed: _onButtonPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: customization.buttonColor ?? buttonColor,
            foregroundColor: customization.buttonTextColor ?? Colors.white,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                customization.buttonBorderRadius ?? R.borderBaseValue,
              ),
            ),
          ),
          child: Text(
            widget.buttonText ?? 'OK',
            style: TextStyle(
              fontSize: customization.buttonFontSize ?? R.textMD,
              fontWeight: FontWeight.w600,
              fontFamily: customization.fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}

/// Success dialog with customization support
class SuccessDialog extends BaseAnimatedDialog {
  const SuccessDialog({
    super.key,
    required super.title,
    super.message,
    super.showButton = false,
    super.buttonText,
    super.onButtonPressed,
    super.onAnimationComplete,
    super.autoDismiss = true,
    super.dismissDelay = const Duration(seconds: 2),
    super.barrierDismissible = true,
    super.customization = DialogCustomization.success,
    super.lottieRepeat = false,
    super.lottieReverse = false,
    super.customWidget,
    super.secondaryButton = false,
    super.secondaryButtonText,
    super.onSecondaryButtonPressed,
  }) : super(animationPath: 'assets/images/app_suucess_animation.json');

  @override
  State<SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends BaseAnimatedDialogState<SuccessDialog> {
  @override
  Color get primaryColor =>
      widget.customization.primaryColor ?? AppColors.green;

  @override
  Color get backgroundColor =>
      widget.customization.backgroundColor ?? Colors.white;

  @override
  Color get buttonColor => widget.customization.buttonColor ?? AppColors.green;
}

/// Failure dialog with customization support
class FailureDialog extends BaseAnimatedDialog {
  const FailureDialog({
    super.key,
    required super.title,
    super.message,
    super.showButton = false,
    super.buttonText,
    super.onButtonPressed,
    super.onAnimationComplete,
    super.autoDismiss = true,
    super.dismissDelay = const Duration(seconds: 2),
    super.barrierDismissible = true,
    super.customization = DialogCustomization.failure,
    super.lottieRepeat = false,
    super.lottieReverse = false,
    super.customWidget,
    super.secondaryButton = false,
    super.secondaryButtonText,
    super.onSecondaryButtonPressed,
  }) : super(animationPath: 'assets/images/appfailAnimation.json');

  @override
  State<FailureDialog> createState() => _FailureDialogState();
}

class _FailureDialogState extends BaseAnimatedDialogState<FailureDialog> {
  @override
  Color get primaryColor => widget.customization.primaryColor ?? AppColors.red;

  @override
  Color get backgroundColor =>
      widget.customization.backgroundColor ?? Colors.white;

  @override
  Color get buttonColor => widget.customization.buttonColor ?? AppColors.red;
}

/// Enhanced extension with full customization support
extension DialogExtensions on BuildContext {
  /// Show fully customizable dialog
  Future<void> showCustomDialog({
    required String title,
    String? message,
    required String animationPath,
    bool showButton = false,
    String? buttonText,
    ButtonCallback? onButtonPressed,
    AnimationCallback? onAnimationComplete,
    bool autoDismiss = true,
    Duration dismissDelay = const Duration(seconds: 2),
    bool barrierDismissible = true,
    DialogCustomization customization = const DialogCustomization(),
    bool lottieRepeat = false,
    bool lottieReverse = false,
    Widget? customWidget,
    bool secondaryButton = false,
    String? secondaryButtonText,
    ButtonCallback? onSecondaryButtonPressed,
  }) {
    return showDialog(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierColor: customization.barrierColor ?? Colors.black.withOpacity(0.5),
      builder:
          (context) => BaseAnimatedDialogImpl(
            title: title,
            message: message,
            animationPath: animationPath,
            showButton: showButton,
            buttonText: buttonText,
            onButtonPressed: onButtonPressed,
            onAnimationComplete: onAnimationComplete,
            autoDismiss: autoDismiss,
            dismissDelay: dismissDelay,
            barrierDismissible: barrierDismissible,
            customization: customization,
            lottieRepeat: lottieRepeat,
            lottieReverse: lottieReverse,
            customWidget: customWidget,
            secondaryButton: secondaryButton,
            secondaryButtonText: secondaryButtonText,
            onSecondaryButtonPressed: onSecondaryButtonPressed,
          ),
    );
  }

  /// Show success dialog with customization
  Future<void> showSuccessDialog({
    required String title,
    String? message,
    bool showButton = false,
    String? buttonText,
    ButtonCallback? onButtonPressed,
    AnimationCallback? onAnimationComplete,
    bool autoDismiss = true,
    Duration dismissDelay = const Duration(seconds: 2),
    bool barrierDismissible = true,
    DialogCustomization? customization,
    bool lottieRepeat = false,
    bool lottieReverse = false,
    Widget? customWidget,
    bool secondaryButton = false,
    String? secondaryButtonText,
    ButtonCallback? onSecondaryButtonPressed,
  }) {
    return showDialog(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierColor:
          (customization?.barrierColor) ?? Colors.black.withOpacity(0.5),
      builder:
          (context) => SuccessDialog(
            title: title,
            message: message,
            showButton: showButton,
            buttonText: buttonText,
            onButtonPressed: onButtonPressed,
            onAnimationComplete: onAnimationComplete,
            autoDismiss: autoDismiss,
            dismissDelay: dismissDelay,
            barrierDismissible: barrierDismissible,
            customization: customization ?? DialogCustomization.success,
            lottieRepeat: lottieRepeat,
            lottieReverse: lottieReverse,
            customWidget: customWidget,
            secondaryButton: secondaryButton,
            secondaryButtonText: secondaryButtonText,
            onSecondaryButtonPressed: onSecondaryButtonPressed,
          ),
    );
  }

  /// Show failure dialog with customization
  Future<void> showFailureDialog({
    required String title,
    String? message,
    bool showButton = false,
    String? buttonText,
    ButtonCallback? onButtonPressed,
    AnimationCallback? onAnimationComplete,
    bool autoDismiss = true,
    Duration dismissDelay = const Duration(seconds: 2),
    bool barrierDismissible = true,
    DialogCustomization? customization,
    bool lottieRepeat = false,
    bool lottieReverse = false,
    Widget? customWidget,
    bool secondaryButton = false,
    String? secondaryButtonText,
    ButtonCallback? onSecondaryButtonPressed,
  }) {
    return showDialog(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierColor:
          (customization?.barrierColor) ?? Colors.black.withOpacity(0.5),
      builder:
          (context) => FailureDialog(
            title: title,
            message: message,
            showButton: showButton,
            buttonText: buttonText,
            onButtonPressed: onButtonPressed,
            onAnimationComplete: onAnimationComplete,
            autoDismiss: autoDismiss,
            dismissDelay: dismissDelay,
            barrierDismissible: barrierDismissible,
            customization: customization ?? DialogCustomization.failure,
            lottieRepeat: lottieRepeat,
            lottieReverse: lottieReverse,
            customWidget: customWidget,
            secondaryButton: secondaryButton,
            secondaryButtonText: secondaryButtonText,
            onSecondaryButtonPressed: onSecondaryButtonPressed,
          ),
    );
  }

  /// Quick success notification
  Future<void> showSuccessNotification({
    required String title,
    String? message,
    Duration dismissDelay = const Duration(seconds: 2),
    AnimationCallback? onAnimationComplete,
    DialogCustomization? customization,
  }) {
    return showSuccessDialog(
      title: title,
      message: message,
      showButton: false,
      autoDismiss: true,
      dismissDelay: dismissDelay,
      onAnimationComplete: onAnimationComplete,
      barrierDismissible: false,
      customization: customization,
    );
  }

  /// Quick failure notification
  Future<void> showFailureNotification({
    required String title,
    String? message,
    Duration dismissDelay = const Duration(seconds: 2),
    AnimationCallback? onAnimationComplete,
    DialogCustomization? customization,
  }) {
    return showFailureDialog(
      title: title,
      message: message,
      showButton: false,
      autoDismiss: true,
      dismissDelay: dismissDelay,
      onAnimationComplete: onAnimationComplete,
      barrierDismissible: false,
      customization: customization,
    );
  }

  /// Success with action
  Future<void> showSuccessAction({
    required String title,
    String? message,
    required String buttonText,
    required ButtonCallback onButtonPressed,
    AnimationCallback? onAnimationComplete,
    DialogCustomization? customization,
    bool secondaryButton = false,
    String? secondaryButtonText,
    ButtonCallback? onSecondaryButtonPressed,
  }) {
    return showSuccessDialog(
      title: title,
      message: message,
      showButton: true,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
      onAnimationComplete: onAnimationComplete,
      autoDismiss: false,
      barrierDismissible: true,
      customization: customization,
      secondaryButton: secondaryButton,
      secondaryButtonText: secondaryButtonText,
      onSecondaryButtonPressed: onSecondaryButtonPressed,
    );
  }

  /// Failure with action
  Future<void> showFailureAction({
    required String title,
    String? message,
    required String buttonText,
    required ButtonCallback onButtonPressed,
    AnimationCallback? onAnimationComplete,
    DialogCustomization? customization,
    bool secondaryButton = false,
    String? secondaryButtonText,
    ButtonCallback? onSecondaryButtonPressed,
  }) {
    return showFailureDialog(
      title: title,
      message: message,
      showButton: true,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
      onAnimationComplete: onAnimationComplete,
      autoDismiss: false,
      barrierDismissible: true,
      customization: customization,
      secondaryButton: secondaryButton,
      secondaryButtonText: secondaryButtonText,
      onSecondaryButtonPressed: onSecondaryButtonPressed,
    );
  }
}

/// Implementation class for custom dialogs
class BaseAnimatedDialogImpl extends BaseAnimatedDialog {
  const BaseAnimatedDialogImpl({
    super.key,
    required super.title,
    super.message,
    required super.animationPath,
    super.showButton = false,
    super.buttonText,
    super.onButtonPressed,
    super.onAnimationComplete,
    super.autoDismiss = true,
    super.dismissDelay = const Duration(seconds: 2),
    super.barrierDismissible = true,
    super.customization = const DialogCustomization(),
    super.lottieRepeat = false,
    super.lottieReverse = false,
    super.customWidget,
    super.secondaryButton = false,
    super.secondaryButtonText,
    super.onSecondaryButtonPressed,
  });

  @override
  State<BaseAnimatedDialogImpl> createState() => _BaseAnimatedDialogImplState();
}

class _BaseAnimatedDialogImplState
    extends BaseAnimatedDialogState<BaseAnimatedDialogImpl> {
  @override
  Color get primaryColor =>
      widget.customization.primaryColor ?? AppColors.primaryOrange;

  @override
  Color get backgroundColor =>
      widget.customization.backgroundColor ?? Colors.white;

  @override
  Color get buttonColor =>
      widget.customization.buttonColor ?? AppColors.primaryOrange;
}
