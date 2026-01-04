import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/tokens/tokens.dart';

/// A modal dialog component.
///
/// Example:
/// ```dart
/// // Using child:
/// ArcaneDialog(
///   title: 'Confirm',
///   child: Text('Are you sure?'),
///   actions: [ArcaneButton(label: 'OK', onPressed: () {})],
/// )
///
/// // Using children: for multiple elements
/// ArcaneDialog(
///   title: 'Settings',
///   children: [
///     ArcaneTextInput(label: 'Name'),
///     ArcaneTextInput(label: 'Email'),
///   ],
/// )
/// ```
class ArcaneDialog extends StatelessComponent {
  /// Dialog title
  final String? title;

  /// Dialog content (single component)
  final Component? _child;

  /// Dialog content (multiple components) - convenience parameter
  final List<Component>? _children;

  /// Footer actions
  final List<Component>? actions;

  /// Whether to show close button
  final bool showCloseButton;

  /// Close handler
  final void Function()? onClose;

  /// Maximum width
  final double maxWidth;

  /// Whether to close on barrier click
  final bool barrierDismissible;

  /// Creates a dialog.
  ///
  /// Provide either [child] or [children].
  const ArcaneDialog({
    this.title,
    Component? child,
    List<Component>? children,
    this.actions,
    this.showCloseButton = true,
    this.onClose,
    this.maxWidth = 500,
    this.barrierDismissible = true,
    super.key,
  })  : _child = child,
        _children = children,
        assert(child != null || children != null,
            'Either child or children must be provided');

  @override
  Component build(BuildContext context) {
    // Resolve content: children takes precedence over child
    final content = _children ?? [_child!];

    return div(
      classes: 'arcane-dialog-overlay',
      styles: const Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'z-index': '1000',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'padding': ArcaneSpacing.lg,
        'background-color': ArcaneColors.overlay,
        'animation': 'arcane-fade-in 150ms ease',
      }),
      events: barrierDismissible
          ? {
              'click': (event) {
                if (event.target == event.currentTarget && onClose != null) {
                  onClose!();
                }
              },
            }
          : null,
      [
        div(
          classes: 'arcane-dialog',
          attributes: {
            'role': 'dialog',
            'aria-modal': 'true',
            if (title != null) 'aria-labelledby': 'dialog-title',
          },
          styles: Styles(raw: {
            'background-color': ArcaneColors.surface,
            'border-radius': ArcaneRadius.lg,
            'box-shadow': ArcaneEffects.shadowXl,
            'max-width': '${maxWidth}px',
            'width': '100%',
            'max-height': 'calc(100vh - 48px)',
            'display': 'flex',
            'flex-direction': 'column',
            'overflow': 'hidden',
            'animation': 'arcane-scale-in 150ms ease',
          }),
          events: {
            'click': (event) => event.stopPropagation(),
          },
          [
            // Header
            if (title != null || showCloseButton)
              div(
                classes: 'arcane-dialog-header',
                styles: const Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'space-between',
                  'padding': '${ArcaneSpacing.md} 20px',
                  'border-bottom': '1px solid ${ArcaneColors.border}',
                  'flex-shrink': '0',
                }),
                [
                  if (title != null)
                    span(
                      id: 'dialog-title',
                      styles: const Styles(raw: {
                        'font-size': ArcaneTypography.fontLg,
                        'font-weight': ArcaneTypography.weightSemibold,
                        'color': ArcaneColors.onSurface,
                      }),
                      [text(title!)],
                    )
                  else
                    const div([]),
                  if (showCloseButton && onClose != null)
                    button(
                      attributes: {
                        'type': 'button',
                        'aria-label': 'Close dialog'
                      },
                      styles: const Styles(raw: {
                        'display': 'flex',
                        'align-items': 'center',
                        'justify-content': 'center',
                        'width': '32px',
                        'height': '32px',
                        'border-radius': ArcaneRadius.full,
                        'background': ArcaneColors.transparent,
                        'border': 'none',
                        'color': ArcaneColors.muted,
                        'cursor': 'pointer',
                        'transition': ArcaneEffects.transitionFast,
                        'font-size': '1.25rem',
                      }),
                      events: {
                        'click': (event) => onClose!(),
                      },
                      [text('×')],
                    ),
                ],
              ),

            // Body
            div(
              classes: 'arcane-dialog-body',
              styles: const Styles(raw: {
                'padding': '20px',
                'overflow-y': 'auto',
                'flex': '1',
              }),
              content,
            ),

            // Footer
            if (actions != null && actions!.isNotEmpty)
              div(
                classes: 'arcane-dialog-footer',
                styles: const Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'flex-end',
                  'gap': ArcaneSpacing.sm,
                  'padding': '${ArcaneSpacing.md} 20px',
                  'border-top': '1px solid ${ArcaneColors.border}',
                  'flex-shrink': '0',
                }),
                actions!,
              ),
          ],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-fade-in').styles(raw: {
      'from': 'opacity: 0',
      'to': 'opacity: 1',
    }),
    css('@keyframes arcane-scale-in').styles(raw: {
      'from': 'transform: scale(0.95); opacity: 0',
      'to': 'transform: scale(1); opacity: 1',
    }),
    css('.arcane-dialog-header button:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
  ];
}

/// A sheet/drawer dialog that slides in from the edge.
///
/// Example:
/// ```dart
/// // Using child:
/// ArcaneSheet(
///   title: 'Menu',
///   position: SheetPosition.left,
///   child: NavigationList(),
/// )
///
/// // Using children: for multiple elements
/// ArcaneSheet(
///   title: 'Settings',
///   children: [
///     SettingsSection(title: 'General'),
///     SettingsSection(title: 'Privacy'),
///   ],
/// )
/// ```
class ArcaneSheet extends StatelessComponent {
  /// Sheet content (single component)
  final Component? _child;

  /// Sheet content (multiple components) - convenience parameter
  final List<Component>? _children;

  /// Sheet position
  final SheetPosition position;

  /// Close handler
  final void Function()? onClose;

  /// Whether to show close button
  final bool showCloseButton;

  /// Sheet title
  final String? title;

  /// Custom width (for left/right sheets)
  final double? width;

  /// Custom height (for top/bottom sheets)
  final double? height;

  /// Creates a sheet.
  ///
  /// Provide either [child] or [children].
  const ArcaneSheet({
    Component? child,
    List<Component>? children,
    this.position = SheetPosition.right,
    this.onClose,
    this.showCloseButton = true,
    this.title,
    this.width,
    this.height,
    super.key,
  })  : _child = child,
        _children = children,
        assert(child != null || children != null,
            'Either child or children must be provided');

  @override
  Component build(BuildContext context) {
    // Resolve content: children takes precedence over child
    final content = _children ?? [_child!];

    final Map<String, String> sheetStyles = {
      'position': 'fixed',
      'background-color': ArcaneColors.surface,
      'box-shadow': ArcaneEffects.shadowXl,
      'display': 'flex',
      'flex-direction': 'column',
      'overflow': 'hidden',
      'z-index': '1000',
    };

    switch (position) {
      case SheetPosition.right:
        sheetStyles.addAll({
          'top': '0',
          'right': '0',
          'bottom': '0',
          'width': '${width ?? 400}px',
          'max-width': '100%',
          'animation': 'arcane-slide-left 200ms ease',
        });
        break;
      case SheetPosition.left:
        sheetStyles.addAll({
          'top': '0',
          'left': '0',
          'bottom': '0',
          'width': '${width ?? 400}px',
          'max-width': '100%',
          'animation': 'arcane-slide-right 200ms ease',
        });
        break;
      case SheetPosition.bottom:
        sheetStyles.addAll({
          'left': '0',
          'right': '0',
          'bottom': '0',
          'height': '${height ?? 400}px',
          'max-height': '90%',
          'border-radius': '${ArcaneRadius.xl} ${ArcaneRadius.xl} 0 0',
          'animation': 'arcane-slide-up 200ms ease',
        });
        break;
      case SheetPosition.top:
        sheetStyles.addAll({
          'left': '0',
          'right': '0',
          'top': '0',
          'height': '${height ?? 400}px',
          'max-height': '90%',
          'border-radius': '0 0 ${ArcaneRadius.xl} ${ArcaneRadius.xl}',
          'animation': 'arcane-slide-down 200ms ease',
        });
        break;
    }

    return div(
      classes: 'arcane-sheet-overlay',
      styles: const Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'z-index': '999',
        'background-color': ArcaneColors.overlay,
        'animation': 'arcane-fade-in 150ms ease',
      }),
      events: {
        'click': (event) {
          if (event.target == event.currentTarget && onClose != null) {
            onClose!();
          }
        },
      },
      [
        div(
          classes: 'arcane-sheet arcane-sheet-${position.name}',
          styles: Styles(raw: sheetStyles),
          events: {
            'click': (event) => event.stopPropagation(),
          },
          [
            // Header
            if (title != null || showCloseButton)
              div(
                classes: 'arcane-sheet-header',
                styles: const Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'space-between',
                  'padding': '${ArcaneSpacing.md} 20px',
                  'border-bottom': '1px solid ${ArcaneColors.border}',
                  'flex-shrink': '0',
                }),
                [
                  if (title != null)
                    span(
                      styles: const Styles(raw: {
                        'font-size': ArcaneTypography.fontLg,
                        'font-weight': ArcaneTypography.weightSemibold,
                      }),
                      [text(title!)],
                    )
                  else
                    const div([]),
                  if (showCloseButton && onClose != null)
                    button(
                      attributes: {'type': 'button'},
                      styles: const Styles(raw: {
                        'display': 'flex',
                        'align-items': 'center',
                        'justify-content': 'center',
                        'width': '32px',
                        'height': '32px',
                        'border-radius': ArcaneRadius.full,
                        'background': ArcaneColors.transparent,
                        'border': 'none',
                        'color': ArcaneColors.muted,
                        'cursor': 'pointer',
                        'font-size': '1.25rem',
                      }),
                      events: {
                        'click': (event) => onClose!(),
                      },
                      [text('×')],
                    ),
                ],
              ),

            // Content
            div(
              classes: 'arcane-sheet-content',
              styles: const Styles(raw: {
                'flex': '1',
                'overflow-y': 'auto',
                'padding': '20px',
              }),
              content,
            ),
          ],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-slide-left').styles(raw: {
      'from': 'transform: translateX(100%)',
      'to': 'transform: translateX(0)',
    }),
    css('@keyframes arcane-slide-right').styles(raw: {
      'from': 'transform: translateX(-100%)',
      'to': 'transform: translateX(0)',
    }),
    css('@keyframes arcane-slide-up').styles(raw: {
      'from': 'transform: translateY(100%)',
      'to': 'transform: translateY(0)',
    }),
    css('@keyframes arcane-slide-down').styles(raw: {
      'from': 'transform: translateY(-100%)',
      'to': 'transform: translateY(0)',
    }),
  ];
}

/// Sheet position
enum SheetPosition {
  left,
  right,
  top,
  bottom,
}
