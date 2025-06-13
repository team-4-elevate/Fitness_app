# Unified Responsive Design System

This is a comprehensive responsive design system for the Flutter fitness app that eliminates the need to pass `BuildContext` repeatedly while providing both const values for performance and dynamic responsive values for flexibility.

## 🚀 Quick Start

### 1. Setup
Wrap your `MaterialApp` with `ResponsiveWrapper` in `main.dart`:

```dart
import 'package:fitness_app/core/responsive/responsive.dart';

// In your main.dart
return ResponsiveWrapper(
  child: MaterialApp(
    // Your app configuration
  ),
);
```

### 2. Import
```dart
import 'package:fitness_app/core/responsive/responsive.dart';
```

### 3. Basic Usage
```dart
// Use R class for all design values
Container(
  padding: R.paddingMD,        // Const EdgeInsets.all(16)
  margin: EdgeInsets.all(R.spaceLG), // Const 24.0
  child: Text(
    'Hello World',
    style: TextStyle(fontSize: R.textLG), // Responsive font size
  ),
)
```

## 📐 Core Classes

### R - Unified Design Class
The `R` class provides all design system values in one place:

```dart
// Spacing (const values)
R.space4, R.space8, R.space16, R.space24, R.space32, R.space40, R.space60

// Responsive spacing (adapts to screen size)
R.spaceXS, R.spaceSM, R.spaceMD, R.spaceLG, R.spaceXL

// Typography (const values)
R.fontXS, R.fontSM, R.fontBase, R.fontMD, R.fontLG, R.fontXL

// Responsive typography
R.textXS, R.textSM, R.textBase, R.textMD, R.textLG, R.textXL

// Border radius
R.radiusXS, R.radiusSM, R.radiusBase, R.radiusLG, R.radiusXL

// Component sizes
R.buttonHeight, R.buttonHeightLG, R.iconBase, R.iconLG
```

### ResponsiveManager
Global manager that tracks screen dimensions without requiring `BuildContext`:

```dart
// Access device information anywhere
R.isMobile    // true if screen width <= 599
R.isTablet    // true if 600 <= screen width <= 1199
R.isDesktop   // true if screen width >= 1200
R.screenWidth // Current screen width
R.screenHeight // Current screen height
```

## 🎯 Usage Patterns

### 1. Const Values for Performance
Use const values when you want consistent spacing/sizing that doesn't need to adapt:

```dart
Container(
  padding: R.paddingMD,        // const EdgeInsets.all(16)
  margin: R.paddingLG,         // const EdgeInsets.all(24)
  decoration: BoxDecoration(
    borderRadius: R.borderRadiusBase, // const BorderRadius.circular(12)
  ),
  child: Column(
    children: [
      Text('Title'),
      R.spaceH16,  // const SizedBox(height: 16)
      Text('Content'),
    ],
  ),
)
```

### 2. Responsive Values for Adaptation
Use responsive values when you want components to scale with screen size:

```dart
Container(
  width: 200.w,  // Responsive width
  height: 100.h, // Responsive height
  padding: EdgeInsets.all(16.r), // Responsive padding
  child: Text(
    'Responsive Text',
    style: TextStyle(fontSize: 16.sp), // Responsive font size
  ),
)
```

### 3. Adaptive Values for Device Types
Use adaptive values when you want different values for different device types:

```dart
// Different grid columns for different devices
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: R.gridColumns, // 2 mobile, 3 tablet, 4 desktop
  ),
  // ...
)

// Custom adaptive values
final buttonHeight = R.adaptive(
  mobile: 48.0,
  tablet: 56.0,
  desktop: 64.0,
);
```

## 🔧 Extensions

### Responsive Number Extensions
```dart
// Responsive calculations
16.w   // Responsive width
20.h   // Responsive height
14.sp  // Responsive font size
12.r   // Responsive radius/general size
```

### Widget Extensions
```dart
// Responsive padding and margins
Widget().paddingAll(16)           // 16.r padding
Widget().paddingSymmetric(        // Responsive symmetric padding
  horizontal: 20, 
  vertical: 12
)
Widget().marginAll(8)             // 8.r margin
Widget().borderRadius(12)         // 12.r border radius
```

### Context Extensions
```dart
// Device information
context.isMobile
context.isTablet
context.screenWidth
context.safeArea

// Adaptive helper
final columns = context.adaptiveValue(
  mobile: 1,
  tablet: 2,
  desktop: 3,
);
```

## 📱 Device Breakpoints

```dart
Mobile:   width <= 599px
Tablet:   600px <= width <= 1199px
Desktop:  width >= 1200px
```

## 🎨 Common Patterns

### 1. Card Layout
```dart
Card(
  margin: R.paddingMD,
  child: Padding(
    padding: R.paddingLG,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card Title',
          style: TextStyle(
            fontSize: R.textXL,
            fontWeight: FontWeight.bold,
          ),
        ),
        R.spaceH12,
        Text(
          'Card content goes here...',
          style: TextStyle(fontSize: R.textBase),
        ),
      ],
    ),
  ),
)
```

### 2. Responsive Button
```dart
SizedBox(
  width: double.infinity,
  height: R.adaptiveButtonHeight, // Adaptive height
  child: ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(R.borderLG),
      ),
    ),
    child: Text(
      'Button Text',
      style: TextStyle(fontSize: R.textLG),
    ),
  ),
)
```

### 3. Responsive Grid
```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: R.getCrossAxisCount(
      mobile: 2,
      tablet: 3,
      desktop: 4,
    ),
    crossAxisSpacing: R.space12,
    mainAxisSpacing: R.space12,
    childAspectRatio: R.cardAspectRatio,
  ),
  itemBuilder: (context, index) => YourWidget(),
)
```

### 4. Form Layout
```dart
Column(
  children: [
    TextFormField(
      decoration: InputDecoration(
        contentPadding: R.paddingMD,
        border: OutlineInputBorder(
          borderRadius: R.borderRadiusBase,
        ),
      ),
    ),
    R.spaceH16,
    TextFormField(
      decoration: InputDecoration(
        contentPadding: R.paddingMD,
        border: OutlineInputBorder(
          borderRadius: R.borderRadiusBase,
        ),
      ),
    ),
    R.spaceH24,
    // Submit button
  ],
)
```

## 🎯 Best Practices

### 1. When to Use Const vs Responsive

**Use Const Values When:**
- Consistent spacing/sizing across all devices
- Performance is critical (lists, grids)
- Design doesn't need to scale proportionally

```dart
// Good for consistent spacing
Column(
  children: [
    Widget1(),
    R.spaceH16,  // Always 16px
    Widget2(),
  ],
)
```

**Use Responsive Values When:**
- Component size should scale with screen size
- Font sizes need to be readable on all devices
- Images/icons need proportional scaling

```dart
// Good for scalable components
Container(
  width: 300.w,  // Scales with screen
  height: 200.h, // Scales with screen
  child: Image.asset('image.png'),
)
```

### 2. Performance Optimization

**Prefer const values for:**
- ListView/GridView items
- Frequently rebuilt widgets
- Static layouts

**Use responsive values for:**
- Main layout components
- User interface elements
- Content that needs to be readable

### 3. Design Consistency

```dart
// ✅ Good - Using design system
Container(
  padding: R.paddingMD,
  margin: R.paddingLG,
  decoration: BoxDecoration(
    borderRadius: R.borderRadiusBase,
  ),
)

// ❌ Avoid - Hardcoded values
Container(
  padding: EdgeInsets.all(15), // Should use R.paddingMD
  margin: EdgeInsets.all(23),  // Should use R.paddingLG
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(11), // Should use R.borderRadiusBase
  ),
)
```

## 🔄 Migration from Old System

### Old Way (with BuildContext)
```dart
// Old responsive extensions
extension ResponsiveExtension on num {
  double w(BuildContext context) => 
    ResponsiveConstants.responsive(toDouble(), context);
}

// Usage required context
Container(
  width: 200.w(context),
  height: 100.h(context),
)
```

### New Way (without BuildContext)
```dart
// New responsive extensions
Container(
  width: 200.w,  // No context needed!
  height: 100.h, // No context needed!
)
```

## 🛠️ Troubleshooting

### ResponsiveWrapper Not Working
Make sure `ResponsiveWrapper` is wrapping your `MaterialApp`:

```dart
// ✅ Correct
ResponsiveWrapper(
  child: MaterialApp(...)
)

// ❌ Wrong
MaterialApp(
  home: ResponsiveWrapper(child: HomePage())
)
```

### Values Not Updating on Screen Rotation
The system automatically handles screen rotation. If values aren't updating, ensure:
1. `ResponsiveWrapper` is properly placed
2. You're using the responsive values (not storing them in variables)

```dart
// ✅ Good - Always gets current value
Text('Width: ${R.screenWidth}')

// ❌ Bad - Stores initial value
final width = R.screenWidth;
Text('Width: $width')
```

## 📊 Performance Notes

- **Const values**: Zero performance overhead
- **Responsive values**: Minimal overhead (single calculation)
- **Adaptive values**: Slight overhead (device type check)
- **Extensions**: Zero overhead (compile-time)

The system is designed for optimal performance while maintaining flexibility.
