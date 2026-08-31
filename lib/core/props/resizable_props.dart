import 'package:arcane_jaspr/flutter.dart';

enum ResizeDirection { horizontal, vertical }

/// Resizable panel data.
class ResizablePanelData {
  final Widget child;
  final double? defaultSize;
  final double? minSize;
  final double? maxSize;
  final bool collapsible;

  const ResizablePanelData({
    required this.child,
    this.defaultSize,
    this.minSize,
    this.maxSize,
    this.collapsible = false,
  });
}

/// Resizable panel group component properties.
class ResizableProps {
  final List<ResizablePanelData> panels;
  final ResizeDirection direction;
  final double handleSize;
  final bool showGrip;

  const ResizableProps({
    required this.panels,
    this.direction = ResizeDirection.horizontal,
    this.handleSize = 8,
    this.showGrip = true,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for resizable components.
mixin ResizableRendererContract {
  Widget resizable(ResizableProps props);
}
