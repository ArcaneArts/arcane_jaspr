import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Drawer position
enum DrawerPosition {
  /// Slide in from left
  left,

  /// Slide in from right
  right,

  /// Slide in from top
  top,

  /// Slide in from bottom
  bottom,
}

/// Drawer size variants
enum DrawerSize {
  /// Small drawer (280px / 30vh)
  sm,

  /// Medium drawer (360px / 50vh)
  md,

  /// Large drawer (480px / 70vh)
  lg,

  /// Extra large drawer (640px / 90vh)
  xl,

  /// Full width/height
  full,
}

/// Slide-in drawer/sheet panel
///
/// A panel that slides in from the edge of the screen.
///
/// ```dart
/// ArcaneDrawer(
///   isOpen: showDrawer,
///   onClose: () => setState(() => showDrawer = false),
///   position: DrawerPosition.right,
///   child: DrawerContent(),
/// )
/// ```
class ArcaneDrawer extends StatelessComponent {
  /// Whether the drawer is open
  final bool isOpen;

  /// Callback when drawer should close
  final VoidCallback? onClose;

  /// Drawer position
  final DrawerPosition position;

  /// Drawer size
  final DrawerSize size;

  /// Drawer content
  final Component child;

  /// Optional header content
  final Component? header;

  /// Optional footer content
  final Component? footer;

  /// Whether to show backdrop overlay
  final bool showBackdrop;

  /// Whether clicking backdrop closes drawer
  final bool closeOnBackdropClick;

  /// Whether to show close button
  final bool showCloseButton;

  /// Custom width (overrides size for left/right)
  final String? width;

  /// Custom height (overrides size for top/bottom)
  final String? height;

  const ArcaneDrawer({
    required this.isOpen,
    required this.child,
    this.onClose,
    this.position = DrawerPosition.right,
    this.size = DrawerSize.md,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = true,
    this.width,
    this.height,
    super.key,
  });

  /// Right drawer constructor
  const ArcaneDrawer.right({
    required this.isOpen,
    required this.child,
    this.onClose,
    this.size = DrawerSize.md,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = true,
    this.width,
    this.height,
    super.key,
  }) : position = DrawerPosition.right;

  /// Left drawer constructor
  const ArcaneDrawer.left({
    required this.isOpen,
    required this.child,
    this.onClose,
    this.size = DrawerSize.md,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = true,
    this.width,
    this.height,
    super.key,
  }) : position = DrawerPosition.left;

  /// Bottom sheet constructor
  const ArcaneDrawer.bottom({
    required this.isOpen,
    required this.child,
    this.onClose,
    this.size = DrawerSize.md,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = false,
    this.width,
    this.height,
    super.key,
  }) : position = DrawerPosition.bottom;

  bool get _isHorizontal =>
      position == DrawerPosition.left || position == DrawerPosition.right;

  String get _sizeValue {
    if (_isHorizontal) {
      return width ?? switch (size) {
        DrawerSize.sm => '280px',
        DrawerSize.md => '360px',
        DrawerSize.lg => '480px',
        DrawerSize.xl => '640px',
        DrawerSize.full => '100%',
      };
    } else {
      return height ?? switch (size) {
        DrawerSize.sm => '30vh',
        DrawerSize.md => '50vh',
        DrawerSize.lg => '70vh',
        DrawerSize.xl => '90vh',
        DrawerSize.full => '100%',
      };
    }
  }

  Map<String, String> get _positionStyles => switch (position) {
        DrawerPosition.left => {
            'left': '0',
            'top': '0',
            'bottom': '0',
            'width': _sizeValue,
            'transform': isOpen ? 'translateX(0)' : 'translateX(-100%)',
          },
        DrawerPosition.right => {
            'right': '0',
            'top': '0',
            'bottom': '0',
            'width': _sizeValue,
            'transform': isOpen ? 'translateX(0)' : 'translateX(100%)',
          },
        DrawerPosition.top => {
            'top': '0',
            'left': '0',
            'right': '0',
            'height': _sizeValue,
            'transform': isOpen ? 'translateY(0)' : 'translateY(-100%)',
          },
        DrawerPosition.bottom => {
            'bottom': '0',
            'left': '0',
            'right': '0',
            'height': _sizeValue,
            'transform': isOpen ? 'translateY(0)' : 'translateY(100%)',
          },
      };

  String get _borderRadius => switch (position) {
        DrawerPosition.left => '0 ${ArcaneRadius.lg} ${ArcaneRadius.lg} 0',
        DrawerPosition.right => '${ArcaneRadius.lg} 0 0 ${ArcaneRadius.lg}',
        DrawerPosition.top => '0 0 ${ArcaneRadius.lg} ${ArcaneRadius.lg}',
        DrawerPosition.bottom => '${ArcaneRadius.lg} ${ArcaneRadius.lg} 0 0',
      };

  @override
  Component build(BuildContext context) {
    if (!isOpen && !showBackdrop) {
      return const span([], styles: Styles(raw: {'display': 'none'}));
    }

    return div(
      styles: Styles(raw: {
        'position': 'fixed',
        'top': '0',
        'left': '0',
        'right': '0',
        'bottom': '0',
        'z-index': '1050',
        'pointer-events': isOpen ? 'auto' : 'none',
      }),
      [
        // Backdrop
        if (showBackdrop)
          div(
            styles: Styles(raw: {
              'position': 'absolute',
              'top': '0',
              'left': '0',
              'right': '0',
              'bottom': '0',
              'background': ArcaneColors.overlay,
              'opacity': isOpen ? '1' : '0',
              'transition': 'opacity 0.3s ease',
            }),
            events: closeOnBackdropClick ? {'click': (_) => onClose?.call()} : null,
            [],
          ),

        // Drawer panel
        div(
          styles: Styles(raw: {
            'position': 'absolute',
            'background': ArcaneColors.surface,
            'box-shadow': ArcaneEffects.shadowXl,
            'display': 'flex',
            'flex-direction': 'column',
            'transition': 'transform 0.3s ease',
            'border-radius': size == DrawerSize.full ? '0' : _borderRadius,
            ..._positionStyles,
          }),
          [
            // Header
            if (header != null || showCloseButton)
              div(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'space-between',
                  'padding': ArcaneSpacing.md,
                  'border-bottom': '1px solid ${ArcaneColors.border}',
                  'flex-shrink': '0',
                }),
                [
                  if (header != null) header!,
                  if (header == null) const span([], styles: Styles(raw: {})),
                  if (showCloseButton)
                    button(
                      type: ButtonType.button,
                      attributes: {'aria-label': 'Close drawer'},
                      styles: const Styles(raw: {
                        'width': '32px',
                        'height': '32px',
                        'display': 'flex',
                        'align-items': 'center',
                        'justify-content': 'center',
                        'padding': '0',
                        'border': 'none',
                        'background': 'transparent',
                        'color': ArcaneColors.muted,
                        'cursor': 'pointer',
                        'border-radius': ArcaneRadius.sm,
                        'font-size': ArcaneTypography.fontLg,
                        'transition': ArcaneEffects.transitionFast,
                      }),
                      events: {'click': (_) => onClose?.call()},
                      [text('×')],
                    ),
                ],
              ),

            // Content
            div(
              styles: const Styles(raw: {
                'flex': '1',
                'overflow': 'auto',
                'padding': ArcaneSpacing.md,
              }),
              [child],
            ),

            // Footer
            if (footer != null)
              div(
                styles: const Styles(raw: {
                  'padding': ArcaneSpacing.md,
                  'border-top': '1px solid ${ArcaneColors.border}',
                  'flex-shrink': '0',
                }),
                [footer!],
              ),
          ],
        ),
      ],
    );
  }
}
