/// Unified Responsive Design System for Flutter Fitness App
///
/// This package provides a comprehensive responsive design system that works
/// without requiring BuildContext to be passed every time. It combines the
/// performance benefits of const values with the flexibility of dynamic
/// responsive values.
///
/// Key Features:
/// - Global responsive manager that tracks screen dimensions
/// - Smart responsive values that automatically decide when to use const vs dynamic
/// - Unified design class (R) with all spacing, typography, and component sizes
/// - Extensions for easy responsive calculations
/// - Automatic device type detection and adaptive values
///
/// Usage:
/// 1. Wrap your MaterialApp with ResponsiveWrapper
/// 2. Use R class for all design values: R.space16, R.textMD, R.borderBase
/// 3. Use responsive extensions: 16.w, 20.h, 14.sp, 12.r
/// 4. Use adaptive values: R.adaptive(mobile: 2, tablet: 3, desktop: 4)

export 'responsive_manager.dart';
export 'responsive_design.dart';
export 'responsive_extensions.dart';
