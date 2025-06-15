import 'package:flutter/material.dart';
import 'responsive_manager.dart';

/// Widget that automatically initializes and updates ResponsiveManager
/// Wrap your MaterialApp with this widget
class ResponsiveWrapper extends StatefulWidget {
  final Widget child;

  const ResponsiveWrapper({super.key, required this.child});

  @override
  State<ResponsiveWrapper> createState() => _ResponsiveWrapperState();
}

class _ResponsiveWrapperState extends State<ResponsiveWrapper>
    with WidgetsBindingObserver {
  final ResponsiveManager _manager = ResponsiveManager.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _manager.initialize(context);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // Update responsive manager when screen metrics change
    if (mounted) {
      final mediaQuery = MediaQuery.of(context);
      _manager.updateScreenSize(
        mediaQuery.size,
        mediaQuery.padding,
        mediaQuery.devicePixelRatio,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Update manager with current constraints
        final mediaQuery = MediaQuery.of(context);
        _manager.updateScreenSize(
          mediaQuery.size,
          mediaQuery.padding,
          mediaQuery.devicePixelRatio,
        );
        return widget.child;
      },
    );
  }
}
