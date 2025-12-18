import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/arcane.dart';
import '../../util/tools/styles.dart';
import '../input/button.dart';

/// A modal dialog component.
class ArcaneDialog extends StatelessComponent {
  /// Dialog title
  final String? title;

  /// Dialog content
  final Component child;

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

  const ArcaneDialog({
    this.title,
    required this.child,
    this.actions,
    this.showCloseButton = true,
    this.onClose,
    this.maxWidth = 500,
    this.barrierDismissible = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);

    return div(
      classes: 'arcane-dialog-overlay',
      styles: Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'z-index': '1000',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'padding': '24px',
        'background-color': theme.barrierColors.dialog.css,
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
            'background-color': 'var(--arcane-surface)',
            'border-radius': '${theme.borderRadiusPx * 1.5}px',
            'box-shadow':
                '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)',
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
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'space-between',
                  'padding': '16px 20px',
                  'border-bottom': '1px solid var(--arcane-outline-variant)',
                  'flex-shrink': '0',
                }),
                [
                  if (title != null)
                    span(
                      id: 'dialog-title',
                      styles: Styles(raw: {
                        'font-size': '1.125rem',
                        'font-weight': '600',
                        'color': 'var(--arcane-on-surface)',
                      }),
                      [text(title!)],
                    )
                  else
                    div([]),
                  if (showCloseButton && onClose != null)
                    button(
                      attributes: {'type': 'button', 'aria-label': 'Close dialog'},
                      styles: Styles(raw: {
                        'display': 'flex',
                        'align-items': 'center',
                        'justify-content': 'center',
                        'width': '32px',
                        'height': '32px',
                        'border-radius': '50%',
                        'background': 'transparent',
                        'color': 'var(--arcane-on-surface-variant)',
                        'cursor': 'pointer',
                        'transition': 'all 150ms ease',
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
              styles: Styles(raw: {
                'padding': '20px',
                'overflow-y': 'auto',
                'flex': '1',
              }),
              [child],
            ),

            // Footer
            if (actions != null && actions!.isNotEmpty)
              div(
                classes: 'arcane-dialog-footer',
                styles: Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'flex-end',
                  'gap': '8px',
                  'padding': '16px 20px',
                  'border-top': '1px solid var(--arcane-outline-variant)',
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
      'background-color': 'var(--arcane-surface-variant)',
    }),
  ];
}

/// A sheet/drawer dialog that slides in from the edge.
class Sheet extends StatelessComponent {
  final Component child;
  final SheetPosition position;
  final void Function()? onClose;
  final bool showCloseButton;
  final String? title;
  final double? width;
  final double? height;

  const Sheet({
    required this.child,
    this.position = SheetPosition.right,
    this.onClose,
    this.showCloseButton = true,
    this.title,
    this.width,
    this.height,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);
    final isHorizontal =
        position == SheetPosition.left || position == SheetPosition.right;

    final sheetStyles = <String, String>{
      'position': 'fixed',
      'background-color': 'var(--arcane-surface)',
      'box-shadow':
          '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)',
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
          'border-radius': '${theme.borderRadiusPx * 2}px ${theme.borderRadiusPx * 2}px 0 0',
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
          'border-radius': '0 0 ${theme.borderRadiusPx * 2}px ${theme.borderRadiusPx * 2}px',
          'animation': 'arcane-slide-down 200ms ease',
        });
        break;
    }

    return div(
      classes: 'arcane-sheet-overlay',
      styles: Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'z-index': '999',
        'background-color': theme.barrierColors.dialog.css,
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
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'space-between',
                  'padding': '16px 20px',
                  'border-bottom': '1px solid var(--arcane-outline-variant)',
                  'flex-shrink': '0',
                }),
                [
                  if (title != null)
                    span(
                      styles: Styles(raw: {
                        'font-size': '1.125rem',
                        'font-weight': '600',
                      }),
                      [text(title!)],
                    )
                  else
                    div([]),
                  if (showCloseButton && onClose != null)
                    button(
                      attributes: {'type': 'button'},
                      styles: Styles(raw: {
                        'display': 'flex',
                        'align-items': 'center',
                        'justify-content': 'center',
                        'width': '32px',
                        'height': '32px',
                        'border-radius': '50%',
                        'background': 'transparent',
                        'color': 'var(--arcane-on-surface-variant)',
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
              styles: Styles(raw: {
                'flex': '1',
                'overflow-y': 'auto',
                'padding': '20px',
              }),
              [child],
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
