import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class AccessibilityUtils {
  static const double minTouchTarget = 48.0;
  
  static Widget wrapWithSemantics({
    required Widget child,
    required String label,
    String? hint,
    bool? button,
    bool? focusable,
    VoidCallback? onTap,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      button: button ?? false,
      focusable: focusable ?? true,
      onTap: onTap,
      child: child,
    );
  }
  
  static Widget ensureMinTouchTarget({
    required Widget child,
    double minSize = minTouchTarget,
  }) {
    return SizedBox(
      width: minSize,
      height: minSize,
      child: Center(child: child),
    );
  }
  
  static Color getContrastColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
  
  static bool hasGoodContrast(Color foreground, Color background) {
    final fLuminance = foreground.computeLuminance();
    final bLuminance = background.computeLuminance();
    
    final lighter = fLuminance > bLuminance ? fLuminance : bLuminance;
    final darker = fLuminance > bLuminance ? bLuminance : fLuminance;
    
    final contrast = (lighter + 0.05) / (darker + 0.05);
    return contrast >= 4.5; // WCAG AA standard
  }
  
  static void announceToScreenReader(BuildContext context, String message) {
    SemanticsService.announce(message, TextDirection.ltr);
  }
  
  static Widget buildAccessibleButton({
    required Widget child,
    required VoidCallback onPressed,
    required String semanticLabel,
    String? semanticHint,
    bool enabled = true,
  }) {
    return Semantics(
      label: semanticLabel,
      hint: semanticHint,
      button: true,
      enabled: enabled,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            constraints: const BoxConstraints(
              minWidth: minTouchTarget,
              minHeight: minTouchTarget,
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}