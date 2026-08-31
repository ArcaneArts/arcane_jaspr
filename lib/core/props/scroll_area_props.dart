import 'package:arcane_jaspr/flutter.dart';

enum ScrollDirectionVariant { vertical, horizontal, both }

enum ScrollbarVisibilityVariant { always, hover, auto_, hidden }

enum ScrollbarStyleVariant { default_, thin, minimal, custom }

/// Scroll area component properties.
class ScrollAreaProps {
  final Widget child;
  final String? height;
  final String? width;
  final String? maxHeight;
  final String? maxWidth;
  final ScrollDirectionVariant direction;
  final ScrollbarVisibilityVariant scrollbar;
  final ScrollbarStyleVariant scrollbarStyle;
  final String? trackColor;
  final String? thumbColor;
  final String scrollbarSize;
  final String? padding;
  final String? className;
  final int instanceId;

  const ScrollAreaProps({
    required this.child,
    this.height,
    this.width,
    this.maxHeight,
    this.maxWidth,
    this.direction = ScrollDirectionVariant.vertical,
    this.scrollbar = ScrollbarVisibilityVariant.hover,
    this.scrollbarStyle = ScrollbarStyleVariant.thin,
    this.trackColor,
    this.thumbColor,
    this.scrollbarSize = '8px',
    this.padding,
    this.className,
    this.instanceId = 0,
  });

  ScrollAreaProps copyWith({
    Widget? child,
    String? height,
    String? width,
    String? maxHeight,
    String? maxWidth,
    ScrollDirectionVariant? direction,
    ScrollbarVisibilityVariant? scrollbar,
    ScrollbarStyleVariant? scrollbarStyle,
    String? trackColor,
    String? thumbColor,
    String? scrollbarSize,
    String? padding,
    String? className,
    int? instanceId,
  }) {
    return ScrollAreaProps(
      child: child ?? this.child,
      height: height ?? this.height,
      width: width ?? this.width,
      maxHeight: maxHeight ?? this.maxHeight,
      maxWidth: maxWidth ?? this.maxWidth,
      direction: direction ?? this.direction,
      scrollbar: scrollbar ?? this.scrollbar,
      scrollbarStyle: scrollbarStyle ?? this.scrollbarStyle,
      trackColor: trackColor ?? this.trackColor,
      thumbColor: thumbColor ?? this.thumbColor,
      scrollbarSize: scrollbarSize ?? this.scrollbarSize,
      padding: padding ?? this.padding,
      className: className ?? this.className,
      instanceId: instanceId ?? this.instanceId,
    );
  }
}

/// Virtual scroll component properties.
class VirtualScrollProps<T> {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final double itemHeight;
  final String height;
  final int overscan;
  final double scrollTop;
  final void Function(double)? onScroll;

  const VirtualScrollProps({
    required this.items,
    required this.itemBuilder,
    required this.itemHeight,
    required this.height,
    this.overscan = 3,
    this.scrollTop = 0,
    this.onScroll,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for scroll area components.
mixin ScrollAreaRendererContract {
  /// Renders a scroll area component.
  Widget scrollArea(ScrollAreaProps props);

  /// Renders a virtualized scroll list component.
  Widget virtualScroll<T>(VirtualScrollProps<T> props);
}
